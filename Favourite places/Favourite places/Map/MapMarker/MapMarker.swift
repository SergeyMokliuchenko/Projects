//
//  MapMarker.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation
import GoogleMaps

class MapMarker: NSObject, Codable, GMUClusterItem {
    
    var position: CLLocationCoordinate2D
    var place: PlaceModel?
    
    init(position: CLLocationCoordinate2D, place: PlaceModel?) {
        self.position = position
        self.place = place
    }
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case place = "place"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let position = try container.decodeIfPresent(CLLocationCoordinate2D.self, forKey: .position)!
        let place = try container.decodeIfPresent(PlaceModel.self, forKey: .place)!
        
        self.init(position: position, place: place)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(place, forKey: .place)
    }
}
