//
//  NavigationBarDelegate.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

@objc protocol NavigationBarDelegate: class {
    
    @objc optional func leftAction()
    @objc optional func rightAction()
}
