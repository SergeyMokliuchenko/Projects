//
//  CustomCollectionViewCell.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 02.06.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var nameFileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    private func prepareUI() {
        
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 20
        coverImageView.layer.masksToBounds = true
        playImageView.layer.cornerRadius = 25
        playImageView.layer.masksToBounds = true
    }
    
    func fillWith(model: FileModel) {
        
        coverImageView.image = model.getFirstFrameWithVideo()
        nameFileLabel.text = model.name
    }
       
}
