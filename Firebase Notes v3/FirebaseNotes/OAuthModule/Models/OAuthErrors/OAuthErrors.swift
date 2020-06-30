//
//  OAuthErrors.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

enum OAuthErrors: String, Error {
    
    case userNotExist
    case emptyFields
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch
    case someFireBaseError
    
     var description: String {
         switch self {
         case .userNotExist:
             return "Account not found"
         case .invalidEmail:
             return "Wrong email"
         case .invalidPassword:
             return "Wrong password"
         case .passwordsDoNotMatch:
             return "Passwords fo not match"
         case .emptyFields:
            return "Please fill all fields"
         case .someFireBaseError:
            return "Error with SignIn via FireBase"
         }
     }
}
