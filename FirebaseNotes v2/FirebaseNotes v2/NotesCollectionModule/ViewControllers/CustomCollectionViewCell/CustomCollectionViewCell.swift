//
//  CustomCollectionViewCell.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var swipableView: UIView!
    @IBOutlet weak var viewTarailing: NSLayoutConstraint!
    
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
        self.viewTarailing.constant = 60
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func swipeRight() {
        self.viewTarailing.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func fillWith(model: Note) {
        self.titleLabel.text = model.title
        self.dateLabel.text = model.date
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteCompletion?()
        swipeRight()
    }
}
