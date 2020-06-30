//
//  CustomTableViewCell.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 16.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabal: UILabel!
    @IBOutlet weak var starRating: SwiftyStarRatingView!
    @IBOutlet weak var swipableView: UIView!
    @IBOutlet weak var swipableViewTrailingConstraints: NSLayoutConstraint!
    
    var shareCompletion: (()->())?
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
        self.swipableViewTrailingConstraints.constant = 40
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight() {
        self.swipableViewTrailingConstraints.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func fillWith(model: MapMarker) {
        let place = model.place
        titleLabal.text = place?.name
        starRating.value = CGFloat(place!.starRating)
    }
    @IBAction func sharePlaceAction(_ sender: UIButton) {
        shareCompletion?()
    }
    
    @IBAction func deletePlaceAction(_ sender: UIButton) {
        deleteCompletion?()
        swipeRight()
    }
}
