//
//  PlacesManager.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import Foundation
import Alamofire

struct PlacesManager {
    
    public static func getPlaces(longitude: Double, latitude: Double, radius: Double, completion: @escaping (Result<[Place], Error>) -> ()) {
        
        let params: Parameters = ["location": "\(latitude),\(longitude)",
                                "radius": "\(radius)",
                                "key": "\(Constants.apiKey)"]
        
        let url: String = "\(Constants.apiBaseUrl)\(Constants.apiNearbyPlacesUrl)"
        
        AF.request(url, method: .get,  parameters: params, encoding: URLEncoding.default)
            .responseJSON { response in
                
                guard let data = response.data else { return }
                do {
                    let responseobject = try JSONDecoder().decode(PlacesResponseObject.self, from: data)
                    completion(.success(responseobject.places!))
                } catch let error {
                    print(error)
                    completion(.failure(error))
                }
                
            }
        
    }
    
    public static func getPlacedetails(placeId: String, completion: @escaping (Result<PlaceDetails, Error>) -> ()) {
        
        let params: Parameters = ["place_id": "\(placeId)",
                                "key": "\(Constants.apiKey)"]
        
        let url: String = "\(Constants.apiBaseUrl)\(Constants.apiPlaceDetailsUrl)"
        
        AF.request(url, method: .get,  parameters: params, encoding: URLEncoding.default)
            .responseJSON { response in
                
                guard let data = response.data else { return }
                do {
                    let responseobject = try JSONDecoder().decode(PlaceDetailsResponseObject.self, from: data)
                    completion(.success(responseobject.placeDetails!))
                } catch let error {
                    print(error)
                    completion(.failure(error))
                }
                
            }
        
    }
    
}
