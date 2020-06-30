//
//  OAuthHandler.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

class OAuthHandler {
    
    private var status: ApiOAuthStatus = .statusFail
    private var error: Error?
    
    init(error: Error? = nil) {
        if(error == nil) {
            self.status = .statusOK
        }
        self.error = error
    }
}
