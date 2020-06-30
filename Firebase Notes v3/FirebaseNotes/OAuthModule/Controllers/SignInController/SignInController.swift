//
//  SignInController.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct SignInController: OAuthImplementation {
    
    private(set) var credentials: Credentials
    
    func validateCredentials() throws {
        
        let credentialsValidator = CredentialsValidator.init(credentials: credentials)
        do {
            try credentialsValidator.validateSignInCredentionals()
            
        } catch let error {
            throw error
        }
    }
    
    func signIn() throws {
        oauthProvider?.signIn(credentials: self.credentials) { oauthHandler in
                
        }
    }
}
