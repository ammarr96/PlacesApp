//
//  ViewController.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var placesTableView: UITableView!
    
    var places: [Place] = []
    var locationManager: CLLocationManager!
    var userLocation: Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesTableView.delegate = self;
        placesTableView.dataSource = self;
        
        self.title = "Nearby places"
        
        placesTableView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellReuseIdentifier: PlacesCell.reuseIdentifier)
        
        placesTableView.tableFooterView = UIView()
        
        requestLocation()

    }
    
    func getNearByPlaces() {
        PlacesManager.getPlaces(longitude: userLocation.longitude!, latitude: userLocation.latitude!, radius: 2000) { (result) in
            switch result {
            case .success(let data):
                self.places = data
                self.placesTableView.reloadData()
                break
                
            case .failure(let err):
                print(err)
                break
            }
        }
    }
    
    func requestLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        userLocation = Location()
        userLocation.latitude = location.coordinate.latitude
        userLocation.longitude = location.coordinate.longitude
        
        getNearByPlaces()
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesCell.reuseIdentifier) as! PlacesCell
        
        cell.setData(place: places[indexPath.row], currentLocation: userLocation)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PlaceDetailsViewController") as! PlaceDetailsViewController
        newViewController.placeId = places[indexPath.row].id
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

    
    
}

