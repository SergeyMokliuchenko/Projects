//
//  UserCredentials.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 28.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct UserSignInCredentials: Credentials {
    
    private(set) var email: String
    private(set) var password: String
    private(set) var confirmPassword: String? = nil
    
}

struct UserSignUpCredentials: Credentials {
    
    private(set) var email: String
    private(set) var password: String
    private(set) var confirmPassword: String?
    
}
