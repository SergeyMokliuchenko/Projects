//
//  SignUpController.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct SignUpController: OAuthImplementation {
    
    private(set) var credentials: Credentials
    
    func validateCredentials() throws {
        
        let credentialsValidator = CredentialsValidator.init(credentials: credentials)
        do {
            try credentialsValidator.validateRegistrationCredentionals()
            
        } catch let error {
            throw error
        }
    }
    
    func createUser() throws {
        oauthProvider?.signUp(credentials: self.credentials) { oauthHandler in
            print(oauthHandler)
        }
    }
}
