//
//  WatchNoteViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 06.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class WatchNoteViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var someImageView: UIImageView!
    
    var completionWatch: (() -> ())?
    var completionUpdate: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        completionWatch?()
    }
    
    func watchNote(model: Note) {
        self.titleLabel.text = model.title
        self.bodyLabel.text = model.body
        
        self.storageRef = Storage.storage().reference(forURL: model.imageURL)
        let megaByte = Int64(5 * 1024 * 1024)
        storageRef.getData(maxSize: megaByte) { [weak self] (data, error) in
            guard let imageData = data else { return }
            let image = UIImage.init(data: imageData)
            self?.someImageView.image = image
        }
        
        self.storageRef = Storage.storage().reference(forURL: model.imageURL)
    }
    
    func watchCoredataNote(model: Note) {
        self.titleLabel.text = model.title
        self.bodyLabel.text = model.body
        let imdage = UIImage(data: model.imageData!)
        self.someImageView.image = imdage
    }
    
}

extension WatchNoteViewController {
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateAction(_ sender: UIBarButtonItem) {
        completionUpdate?()
    }
}
