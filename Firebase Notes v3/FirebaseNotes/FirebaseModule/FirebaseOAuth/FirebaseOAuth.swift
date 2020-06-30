//
//  FirebaseOAuth.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseOAuth: OAuthProvider {
    
    private var reference = Database.database()
    
    func signIn(credentials: Credentials, completion: @escaping (OAuthHandler) -> ()) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { authResult, error in
            let oauthHandler = OAuthHandler.init(error: error)
            completion(oauthHandler)
        }
    }
    
    func signUp(credentials: Credentials, completion: @escaping (OAuthHandler) -> ()) {
        Auth.auth().createUser(withEmail: credentials.email, password:credentials.password) { authResult, error in
            let oauthHandler = OAuthHandler.init(error: error)
            completion(oauthHandler)
        }
    }
}
