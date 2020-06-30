//
//  EnterCityViewController.swift
//  WeatherApp
//
//  Created by Serhii Mokliuchenko on 25.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class EnterCityViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var completion: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewStyle()
        enterLocationTextFieldStyle()
        cancelButtonStyle()
        searchButtonStyle()
    }
    
    private func searchViewStyle() {
        searchView.layer.cornerRadius = 15
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = CGColor(srgbRed: 230/255, green: 109/255, blue: 75/255, alpha: 1)
    }
    
    private func enterLocationTextFieldStyle() {
        citySearchTextField.layer.cornerRadius = 10
        citySearchTextField.layer.masksToBounds = true
        citySearchTextField.layer.borderWidth = 1
        citySearchTextField.layer.borderColor = CGColor(srgbRed: 230/255, green: 109/255, blue: 75/255, alpha: 1)
    }
    
    private func cancelButtonStyle() {
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = CGColor(srgbRed: 230/255, green: 109/255, blue: 75/255, alpha: 1)
    }
    
    private func searchButtonStyle() {
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = CGColor(srgbRed: 230/255, green: 109/255, blue: 75/255, alpha: 1)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        guard let city = citySearchTextField.text, city != "" else { return }
        completion?(city)
        dismiss(animated: true)
    }
    
}
