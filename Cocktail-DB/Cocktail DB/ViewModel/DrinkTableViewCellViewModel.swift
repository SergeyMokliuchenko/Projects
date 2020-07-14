//
//  DrinkTableViewCellViewModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class DrinkTableViewCellViewModel: DrinkTableViewCellViewModelType {
    
    private var drink: Drink
    
    var name: String {
        return drink.name
    }
    
    var imageURL: NSURL {
        return NSURL(string: drink.imageURL)!
    }
    
    init(drink: Drink) {
        self.drink = drink
    }
}
