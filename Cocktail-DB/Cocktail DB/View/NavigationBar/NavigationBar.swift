//
//  NavigationBar.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var leadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var filtersButton: UIButton!
    
    weak var delegate: NavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: NavigationBar.self)
        bundle.loadNibNamed("NavigationBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        delegate?.leftAction?()
    }
    
    @IBAction func filtersButtonAction(_ sender: UIButton) {
        delegate?.rightAction?()
    }
}
