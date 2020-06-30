//
//  SignUpViewController.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 28.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: true)
    }
      
    @IBAction func createAccountButtonAction(_ sender: UIButton) {
        createAccount()
    }
    
    private func createAccount() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        let signUpCredentials = UserSignUpCredentials.init(email: email, password: password, confirmPassword: confirmPassword)
        let signUpController = SignUpController.init(credentials: signUpCredentials)
        
        do {
            try signUpController.validateCredentials()
            try signUpController.createUser()
            goToNotesViewController()
        } catch let error {
            guard let oauthError = error as? OAuthErrors else { return }
            handleError(error: oauthError)
        }
    }
    
    private func handleError(error: OAuthErrors) {
        showErrorAlertWithCancelAction(message: error.description)
    }
    
}

extension UIViewController {
    
    func showErrorAlertWithCancelAction(message: String) {
        let alert = UIAlertController(title: "Oauth Error", message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
           
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlertWithCancelAndOneAction(message: String, actionName: String, actionCompletion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Oauth Error", message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
           
        }))
        
        alert.addAction(UIAlertAction(title: actionName, style: UIAlertAction.Style.default, handler: { _ in
           actionCompletion()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
