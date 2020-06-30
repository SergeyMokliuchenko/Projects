//
//  CredentialsValidator.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

class CredentialsValidator {
    
    private var credentials: Credentials
    
    init(credentials: Credentials) {
        self.credentials = credentials
    }
    
    func validateSignInCredentionals() throws {
        do {
            try validateEmail()
            try validatePassword()
        } catch let error {
            throw error
        }
    }
    
    func validateRegistrationCredentionals() throws {
        do {
            try validateEmail()
            try validatePassword()
            try comparePasswords()
        } catch let error {
            throw error
        }
    }
    
    private func validateEmail() throws {
        let emailValidator = NSPredicate(format:"SELF MATCHES[c] %@", RegularExpression.emailValidationExpression)
        if(!emailValidator.evaluate(with: credentials.email)) {
            throw OAuthErrors.invalidEmail
        }
    }
    
    private func validatePassword() throws {
        if (credentials.password.count < 8) {
            throw OAuthErrors.invalidPassword
        }
    }
    
    private func comparePasswords() throws {
        if (credentials.password != credentials.confirmPassword) {
            throw OAuthErrors.passwordsDoNotMatch
        }
    }
}
