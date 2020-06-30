//
//  AddMarkerViewController.swift
//  Favourite places
//
//  Created by Serhii Mokliuchenko on 14.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class AddMarkerViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var starRating: SwiftyStarRatingView!
    
    var addCompletionHandler: ((PlaceModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPlaceAction(_ sender: UIButton) {
        newPlace()
    }
    
    private func newPlace() {
        guard let name = titleTextField.text, let description = descriptionTextField.text else { return }
        let rating = Float(starRating.value)
        let place = PlaceModel.init(name: name, description: description, starRating: rating)
        addCompletionHandler?(place)
        self.dismiss(animated: true, completion: nil)
    }
}
