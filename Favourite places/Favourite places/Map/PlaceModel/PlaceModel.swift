//
//  PlaceModel.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation

class PlaceModel: Codable {
    
    var name: String
    var description: String
    var starRating: Float
    
    init(name: String, description: String, starRating: Float) {
        self.name = name
        self.description = description
        self.starRating = starRating
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case starRating = "starRating"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decodeIfPresent(String.self, forKey: .name)!
        let description = try container.decodeIfPresent(String.self, forKey: .description)!
        let starRating = try container.decodeIfPresent(Float.self, forKey: .starRating)!
        
        self.init(name: name, description: description, starRating: starRating)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(starRating, forKey: .starRating)
    }
}
