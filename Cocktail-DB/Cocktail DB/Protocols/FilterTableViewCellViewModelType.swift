//
//  FilterTableViewCellViewModelType.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol FilterTableViewCellViewModelType: class {
    
    var name: String { get }
    var isSelected: Bool { get }
}
