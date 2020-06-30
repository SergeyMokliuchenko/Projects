//
//  DeleteFileViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 05.06.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class DeleteFileViewController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var completion: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertViewStyle()
        cancleButtonStyle()
        deleteButtonStyle()
    }
    
    private func alertViewStyle() {
        alertView.layer.cornerRadius = 10
    }
    
    private func cancleButtonStyle() {
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderColor = CGColor(srgbRed: 255/255, green: 120/255, blue: 91/255, alpha: 1)
    }
    
    private func deleteButtonStyle() {
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.masksToBounds = true
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        completion?()
        dismiss(animated: true, completion: nil)
    }
}
