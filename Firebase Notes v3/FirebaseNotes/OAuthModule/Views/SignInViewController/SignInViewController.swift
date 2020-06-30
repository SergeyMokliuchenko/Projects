//
//  SignInViewController.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 28.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        signIn()
    }
    
    private func signIn() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let userCredentials = UserSignInCredentials.init(email: email, password: password)
        let signInController = SignInController.init(credentials: userCredentials)
        
        do {
            try signInController.validateCredentials()
            try signInController.signIn()
            goToNotesViewController()
        } catch let error {
            guard let oauthError = error as? OAuthErrors else { return }
            handleError(error: oauthError)
        }
    }
    
    private func handleError(error: OAuthErrors) {
        if (error == .invalidPassword) {
            showErrorAlertWithCancelAndOneAction(message: error.description, actionName: "Forgot password?") {
                self.forgotPassword()
            }
        } else {
            showErrorAlertWithCancelAction(message: error.description)
        }
    }
    
    private func forgotPassword() {
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        goToSignUpViewController()
    }
    
    private func goToSignUpViewController() {
        let signUpViewController = SignUpViewController.init()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}
