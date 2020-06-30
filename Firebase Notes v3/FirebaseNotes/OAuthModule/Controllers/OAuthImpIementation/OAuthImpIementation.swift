//
//  OAuthImpIementation.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

protocol OAuthImplementation {
    
    var credentials: Credentials { get }
    var oauthProvider: OAuthProvider? { get }
    
    func validateCredentials() throws
    
}

extension OAuthImplementation {
    var oauthProvider: OAuthProvider? {
        return FirebaseOAuth()
    }
}
