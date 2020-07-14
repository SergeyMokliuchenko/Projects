//
//  SectionsModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 11.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct SectionsModel {
    
    var nameSection: String
    var drinks: [Drink]
    var isSelected: Bool = true
}
