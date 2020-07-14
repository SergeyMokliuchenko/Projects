//
//  DrinksViewModelType.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol DrinksViewModelType: FilterCategoryDelegate {
    
    func getSections() -> [SectionsModel]
    
    func selectedCategory() -> [SectionsModel]
    
    func pagination(forRowAt indexPath: IndexPath, completion: @escaping () -> Void)
    
    func loadDrinksCategories(completion: @escaping () -> Void)
    
    func loadDrinks(name: String, completion: @escaping () -> Void)
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DrinkTableViewCellViewModelType
    
    func headerCellViewModel(forIndexPath section: Int) -> HeaderTableViewCellType
    
}
