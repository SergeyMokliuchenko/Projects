//
//  BaseViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase

class BaseViewController: UIViewController {
    
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    var user: Users!
    var notes: [Note] = []
    var noteModel: Note?
    var coredataNotes: [Note] = []
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM"
        return dateFormatter.string(from: Date())
    }
    func randomId() -> String {
        return String(Int.random(in: 0..<1000000000000))
    }
    
    func rememberUser(value: Bool) {
        UserDefaults.standard.set(value, forKey: "Authorized")
    }
    
    func goToSignInViewController() {
        let signInViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: SignInViewController.self)) as! SignInViewController
         navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    func goToSignUpViewController() {
        let signUpViewController = SignUpViewController.init()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func goToNotesViewController() {
        let notesViewController = NotesViewController.init()
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
    func goToCreateNoteViewController() {
        let createNoteViewController = CreateNoteViewController.init()
        navigationController?.pushViewController(createNoteViewController, animated: true)
    }
    func goToWatchNoteViewController() {
        let watchNoteViewController = WatchNoteViewController.init()
        navigationController?.pushViewController(watchNoteViewController, animated: true)
    }
    
    func goToNotesCoredataViewController() {
        let notesCoredataViewController = NotesCoredataViewController.init()
        navigationController?.pushViewController(notesCoredataViewController, animated: true)
    }
    func goToCreateCoredataNoteViewController() {
        let createCoredataNoteViewController = CreateCoredataNoteViewController.init()
        navigationController?.pushViewController(createCoredataNoteViewController, animated: true)
    }
}
