//
//  DrinkTableViewCellViewModelType.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

protocol DrinkTableViewCellViewModelType: class {
    
    var name: String { get }
    var imageURL: NSURL { get }
    
}
