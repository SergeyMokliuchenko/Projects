//
//  UIImage+Extension.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 13.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

extension UIImage {
    
    func downloadImageFromURL(url: NSURL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let data = try? Data(contentsOf: url as URL),
            let image = UIImage(data: data) else { return }
            DispatchQueue.main.sync {
                completion(image)
            }
        }
    }
}
