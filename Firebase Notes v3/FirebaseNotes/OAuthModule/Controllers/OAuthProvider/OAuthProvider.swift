//
//  OAuthProvider.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol OAuthProvider {
    
    func signIn(credentials: Credentials, completion: @escaping (OAuthHandler) -> ())
    func signUp(credentials: Credentials, completion: @escaping (OAuthHandler) -> ())
    
}
