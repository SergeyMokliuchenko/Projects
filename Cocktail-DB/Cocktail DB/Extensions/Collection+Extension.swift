//
//  Collection+Extension.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

extension Collection {

    /// Get at index object
    ///
    /// - Parameter index: Index of object
    /// - Returns: Element at index or nil
    func get(at index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
