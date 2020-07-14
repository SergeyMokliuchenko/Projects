//
//  FiltersViewModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 11.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

class FiltersViewModel: FiltersViewModelType {
    
    var delegate: FilterCategoryDelegate!
    private var categories: [SectionsModel] = []
    
    func getCategory(category: [SectionsModel]) {
        self.categories = category
    }
    
    func getSelectedCategory() -> [SectionsModel] {
        return categories
    }
    
    func numberOfRowsInSection() -> Int {
        return categories.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FilterTableViewCellViewModelType? {
        let category = categories[indexPath.row]
        return FilterTableViewCellViewModel(category: category)
    }
    
    func selectedFilter(name: String) {
        
        categories = categories.map { category -> SectionsModel in
            if category.nameSection == name {
                return SectionsModel(nameSection: name, drinks: [], isSelected: !category.isSelected)
            }
            
            return category
        }
    }
}
