//
//  SignUpViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        ref = Database.database().reference(withPath: "users")
    }
}

extension SignUpViewController {
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text, email != "" else {
            displayErrorLabel(withText: "Invalid email")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            displayErrorLabel(withText: "Invalid password")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
            displayErrorLabel(withText: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard error == nil, user != nil else {
                self?.displayErrorLabel(withText: "\(error!.localizedDescription)")
                return
            }
            
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email" : user?.user.email])
            self?.rememberUser(value: true)
            self?.goToNotesViewController()
        }
    }
    
    private func displayErrorLabel(withText: String) {
        errorLabel.text = withText
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.errorLabel.alpha = 1
        }) { [weak self] complete in
            self?.errorLabel.alpha = 0
        }
    }
}
