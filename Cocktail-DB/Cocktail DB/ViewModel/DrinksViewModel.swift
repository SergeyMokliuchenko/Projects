//
//  DrinksViewModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 10.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

class DrinksViewModel: DrinksViewModelType {
    
    private var dataProvider: DataProvider = RequestManager()
    private var sections: [SectionsModel] = []
    
    func getSections() -> [SectionsModel] {
        return sections
    }
    
    func selectedFilters(sections: [SectionsModel]) {
        self.sections = sections
    }
    
    func selectedCategory() -> [SectionsModel] {
        return sections.filter { $0.isSelected == true }
    }
    
    func pagination(forRowAt indexPath: IndexPath, completion: @escaping () -> Void) {
        
        if indexPath.row == selectedCategory()[indexPath.section].drinks.count - 1  {
            guard selectedCategory().get(at: indexPath.section + 1) != nil else { return }
            loadDrinks(name: selectedCategory()[indexPath.section + 1].nameSection) {
                completion()
                }
            }
    }
    
    func loadDrinksCategories(completion: @escaping () -> Void) {
        dataProvider.loadDrinksCategories { [unowned self] response in
            var tableViewModel: [SectionsModel] = []

            for drinkCategory in response.drinks {
                tableViewModel.append(SectionsModel(nameSection: drinkCategory.name, drinks: []))
            }
            self.sections = tableViewModel
            completion()
        }
    }
    
    func loadDrinks(name: String, completion: @escaping () -> Void) {
        
        dataProvider.loadDrinks(with: name) { [unowned self] response in
            self.sections = self.sections.map { sections -> SectionsModel in

                return sections.nameSection == name
                    ? SectionsModel(nameSection: name, drinks: response.drinks)
                    : sections
            }
            completion()
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> DrinkTableViewCellViewModelType {
        let drink = sections.filter { $0.isSelected == true } [indexPath.section].drinks[indexPath.row]
        return DrinkTableViewCellViewModel(drink: drink)
    }
    
    func headerCellViewModel(forIndexPath section: Int) -> HeaderTableViewCellType {
        let section = sections.filter { $0.isSelected == true }[section]
        return HeaderTableViewCellViewModel(section: section)
    }
}
