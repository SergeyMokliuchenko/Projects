//
//  FiltersViewModelType.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol FiltersViewModelType {
    
    var delegate: FilterCategoryDelegate! { get set }
    
    func getCategory(category: [SectionsModel])
    
    func getSelectedCategory() -> [SectionsModel]
    
    func numberOfRowsInSection() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FilterTableViewCellViewModelType?
    
    func selectedFilter(name: String)
    
}
