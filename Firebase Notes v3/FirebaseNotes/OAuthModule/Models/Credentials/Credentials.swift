//
//  Credentials.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 28.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol Credentials {
    
    var email: String { get }
    var password: String { get }
    var confirmPassword: String? { get }
    
    func isEqual(to credentials: Credentials) -> Bool
}

extension Credentials {
    
    func isEqual(to credentials: Credentials) -> Bool {
        return email == credentials.email && password == credentials.password
    }
    
}
