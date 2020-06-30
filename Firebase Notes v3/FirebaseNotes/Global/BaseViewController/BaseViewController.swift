//
//  BaseViewController.swift
//  FirebaseNotes
//
//  Created by Serhii Mokliuchenko on 29.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func goToNotesViewController() {
        let notesViewController = NotesViewController.init()
        navigationController?.pushViewController(notesViewController, animated: true)
    }
}
