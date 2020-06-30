//
//  CustomTableViewCell.swift
//  Note
//
//  Created by Сергей Моключенко on 26.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var swipableView: UIView!
    @IBOutlet weak var viewTarailing: NSLayoutConstraint!
    
    var deleteCompletion: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        addGestures()
    }
    
    func fillWith(model: NoteModel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM HH:mm"
        
        self.dataLabel.text = dateFormatter.string(from: model.createdDate)
        self.headerLabel.text = model.noteTitle
        self.bodyLabel.text = model.noteBody
        self.swipeRight()
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
        
        self.viewTarailing.constant = 100
        
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
    
    @IBAction func deleteNote(_ sender: Any) {
        self.deleteCompletion?()
    }
}
