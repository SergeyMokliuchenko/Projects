//
//  DrinkModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct DrinksModel: Decodable {
    
    let drinks: [Drink]
    
}

struct Drink: Decodable {
    
    let name: String
    let imageURL: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
        case id = "idDrink"
    }
}
