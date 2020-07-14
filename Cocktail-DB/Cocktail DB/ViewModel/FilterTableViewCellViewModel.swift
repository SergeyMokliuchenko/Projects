//
//  FilterTableViewCellViewModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 11.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class FilterTableViewCellViewModel: FilterTableViewCellViewModelType {
    
    
    private var category: SectionsModel
    
    var name: String {
        return category.nameSection
    }
    
    var isSelected: Bool {
        return category.isSelected
    }
    
    init(category: SectionsModel) {
        self.category = category
    }
}
