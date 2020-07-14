//
//  DrinksCategoryModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 11.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct DrinksCategoryModel: Decodable {
    
    var drinks: [Category]
}

struct Category: Decodable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
