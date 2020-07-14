//
//  HeaderTableViewCellType.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    weak var viewModel: HeaderTableViewCellType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.headerLabel.text = viewModel.headerName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
