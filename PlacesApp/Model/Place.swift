//
//  Place.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import Foundation

class PlacesResponseObject: Codable {
    
    var places: [Place]?
    
    enum CodingKeys: String, CodingKey {
        case places = "results"
    }
}

class Place: Codable {
    
    var id : String?
    var name : String?
    var geometry : Geometry?
    
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case name = "name"
        case geometry = "geometry"
    }
    
}

class Geometry: Codable {
    var location : Location?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
    }
}

class Location: Codable {
    var latitude : Double?
    var longitude : Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
