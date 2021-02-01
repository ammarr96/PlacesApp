//
//  PlaceDetails.swift
//  PlacesApp
//
//  Created by Amar Lubovac on 1/31/21.
//

import UIKit

class PlaceDetailsResponseObject: Codable {
    
    var placeDetails: PlaceDetails?
    
    enum CodingKeys: String, CodingKey {
        case placeDetails = "result"
    }
}

class PlaceDetails: Codable {
    
    var id : String?
    var name : String?
    var geometry : Geometry?
    var address: String?
    var phone: String?
    var priceLevel: Int?
    var rating: Double?
    var openingHours: OpeningHours?
    var photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case name = "name"
        case geometry = "geometry"
        case address = "formatted_address"
        case phone = "international_phone_number"
        case priceLevel = "price_level"
        case rating = "rating"
        case openingHours = "opening_hours"
        case photos = "photos"
    }

}

class Photo: Codable {
    
    var height: Int?
    var width: Int?
    var photoReference: String?
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case width = "width"
        case photoReference = "photo_reference"
    }
    
}

class OpeningHours: Codable {
    
    var weekdayText: [String]?
    
    enum CodingKeys: String, CodingKey {
        case weekdayText = "weekday_text"
    }
    
}
