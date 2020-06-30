//
//  ExtensionCLLocationCoordinate2D.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 19.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation

extension CLLocationCoordinate2D: Codable {

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decodeIfPresent(CLLocationDegrees.self, forKey: .latitude)!
        let longitude = try container.decodeIfPresent(CLLocationDegrees.self, forKey: .longitude)!

        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
    }
}
