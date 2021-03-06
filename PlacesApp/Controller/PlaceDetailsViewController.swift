//
//  PlaceDetailsViewController.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import UIKit
import MapKit

class PlaceDetailsViewController: UIViewController, MKMapViewDelegate {
    
    public var placeId: String?
    var placeDetails: PlaceDetails?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var workingHoursLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlaceDetails()
    
        mapView.delegate = self;
    }
    
    func getPlaceDetails() {
        
        PlacesManager.getPlacedetails(placeId: placeId!) { (result) in
            switch result {
            case .success(let data):
                self.placeDetails = data
                self.showData()
                break
                
            case .failure(let err):
                print(err)
                break
            }
        }
       
    }
    
    func showData() {
        title = placeDetails?.name
        addressLabel.text = placeDetails?.address ?? "-"
        
        var rating = 0
        if (placeDetails?.rating != nil) {
            let imageSize: CGFloat = 20.0
            rating = (Int) (placeDetails?.rating ?? 0.0)
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named:"star_selected")
            let imageOffsetY: CGFloat = -5.0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageSize, height: imageSize)
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            let completeText = NSMutableAttributedString(string: "")
            for i in 1...rating {
                completeText.append(attachmentString)
                completeText.append(NSAttributedString(string: " "))
            }
            let imageAttachment2 = NSTextAttachment()
            imageAttachment2.image = UIImage(named:"star")
            imageAttachment2.bounds = CGRect(x: 0, y: imageOffsetY, width: imageSize, height: imageSize)
            let attachmentString2 = NSAttributedString(attachment: imageAttachment2)
            if (rating<5) {
                for i in 1...5-rating {
                    completeText.append(attachmentString2)
                    completeText.append(NSAttributedString(string: " "))
                }
            }
        //ratingLabel.text = "\(placeDetails?.rating ?? 0.0)"
            ratingLabel.attributedText = completeText
        }
        else {
            ratingLabel.text = "-"
        }
        phoneLabel.text = placeDetails?.phone ?? "-"
        if (placeDetails?.priceLevel != nil) {
            priceLabel.text = "\(placeDetails?.priceLevel ?? 0)"
        }
        else {
            priceLabel.text = "-"
        }
        
        if (placeDetails?.openingHours != nil) {
            workingHoursLabel.text = placeDetails?.openingHours?.weekdayText?.joined(separator: "\n")
        }
        else {
            workingHoursLabel.text = "-"
        }
        
        addPin()
        if (placeDetails?.photos?.count ?? 0 > 0) {
            showImage()
        }
    }
    
    func addPin() {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: (placeDetails?.geometry?.location?.latitude)!, longitude: (placeDetails?.geometry?.location?.longitude)!)
        annotation.coordinate = centerCoordinate
        annotation.title = placeDetails?.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion( center: centerCoordinate, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let longitude: Double = view.annotation?.coordinate.longitude ?? 0.0
        let latitude: Double = view.annotation?.coordinate.latitude ?? 0.0
        let url  = NSURL(string: "http://maps.apple.com/?q=\(latitude),\(longitude)")
        if UIApplication.shared.canOpenURL(url! as URL) == true {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    
    func showImage() {
        
        let reference: String = placeDetails?.photos![0].photoReference ?? ""
        let maxHeight: Int = 300
        
        let imageUrl: String = "\(Constants.apiBaseUrl)\(Constants.apiPhotoUrl)?key=\(Constants.apiKey)&photoreference=\(reference)&maxheight=\(maxHeight)"
        
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
        
    }


}
