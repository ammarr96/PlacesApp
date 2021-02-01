//
//  Utils.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import Foundation
import CoreLocation

struct Utils {
    
    public static func getDistance(locationFrom: Location, locationTo: Location) -> Int {
        
        let coordinate1 = CLLocation(latitude: locationFrom.latitude!, longitude: locationFrom.longitude!)
        let coordinate2 = CLLocation(latitude: locationTo.latitude!, longitude: locationTo.longitude!)

        let distanceInMeters = coordinate1.distance(from: coordinate2)
        
        return Int(distanceInMeters)
    }
    
}
