//
//  WarningViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 29.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var warningText: String
    
    init(warningText: String) {
        self.warningText = warningText
        super.init(nibName: "WarningViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillStyle()
        fillWith()
    }
    
    private func fillStyle() {
        warningViewStyle()
        cancelButtonStyle()
    }
    
    private func warningViewStyle() {
        warningView.layer.cornerRadius = 10
    }
    
    private func cancelButtonStyle() {
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderColor = CGColor(srgbRed: 255/255, green: 120/255, blue: 91/255, alpha: 1)
    }
    
    private func fillWith() {
        warningLabel.text = warningText
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
