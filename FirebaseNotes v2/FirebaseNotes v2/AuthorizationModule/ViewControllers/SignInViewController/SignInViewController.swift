//
//  ViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        userDefault()
    }
    
    private func userDefault() {
        let userDefault = UserDefaults.standard.bool(forKey: "Authorized")
        if userDefault {
            if CheckInternet.connection() {
                goToNotesViewController()
            } else {
                goToNotesCoredataViewController()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SignInViewController {
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        resetPassword()
    }
    
    private func resetPassword() {
        guard let email = emailTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if error != nil {
                self?.displayErrorLabel(withText: "\(String(describing: error?.localizedDescription))")
            }
            self?.displayErrorLabel(withText: "Check your email")
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
    
    @IBAction func loginAction(_ sender: UIButton) {
         
         guard let email = emailTextField.text, email != "" else {
             displayErrorLabel(withText: "Invalid email")
             return
         }
         guard let password = passwordTextField.text, password != "" else {
             displayErrorLabel(withText: "Invalid password")
             return
         }
         
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            
             if error != nil {
                 self?.displayErrorLabel(withText: "\(String(describing: error?.localizedDescription))")
                 self?.forgotPassword.alpha = 1
                 return
             }
             
             if user != nil {
                 self?.rememberUser(value: true)
                 self?.goToNotesViewController()
                 return
             }
         }
     }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        goToSignUpViewController()
    }
}
