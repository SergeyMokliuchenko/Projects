//
//  CustomTableViewCell.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 27.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var swipableView: UIView!
    @IBOutlet weak var swipableViewTrailingConstraint: NSLayoutConstraint!
    
    var deleteCompletion: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        addGestures()
    }
    
    func prepareUI() {
        
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
    
    func addGestures() {
        
        self.swipableView.isUserInteractionEnabled = true
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(self.swipeLeft))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(self.swipeRight))
        rightSwipe.direction = .right
        swipableView.addGestureRecognizer(leftSwipe)
        swipableView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipeLeft() {
        
        self.swipableViewTrailingConstraint.constant = 80
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight() {
        
        self.swipableViewTrailingConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func fillWith(model: FileModel) {
        
        artistNameLabel.text = model.getArtistName()
        trackNameLabel.text = model.getTrackName()
        coverImageView.image = model.getCover()
        
    }
    
    @IBAction func deleteFileAction(_ sender: UIButton) {
        
        deleteCompletion?()
        swipeRight()
    }
}
