//
//  HeaderTableViewCellViewModel.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

class HeaderTableViewCellViewModel: HeaderTableViewCellType {
    
    private var section: SectionsModel
    
    var headerName: String {
        return section.nameSection
    }
    
    init(section: SectionsModel) {
        self.section = section
    }
}
