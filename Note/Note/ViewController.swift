//
//  ViewController.swift
//  Note
//
//  Created by Сергей Моключенко on 24.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myNote: [NoteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        loadData()
    }
    
    func prepareTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: String(describing: CustomTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
    }
    
    func loadData() {
        myNote.removeAll()
        
        for obj in CoreDataManager.shared.getNotes()! {
            
            let noteModel = NoteModel.init(noteId: 0, createdDate: Date(), noteTitle: "", noteBody: "")
            
            noteModel.fillWith(model: obj)
            
            myNote.append(noteModel)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addNote(_ sender: Any) {
        updateNote(noteModel: nil)
    }
    
    func updateNote(noteModel: NoteModel?) {
        
        let createVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddNoteViewController.self)) as! AddNoteViewController
        createVC.completionReload = {
            self.loadData()
        }
        createVC.noteModel = noteModel
        self.navigationController?.pushViewController(createVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self)) as! CustomTableViewCell
        
        cell.fillWith(model: myNote[indexPath.row])
        
        cell.deleteCompletion = {
            
            CoreDataManager.shared.deleteNote(noteModel: self.myNote[indexPath.row])
            
            let alertController = UIAlertController(title: "Your note is deleted", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction (title: "Ok", style: .destructive) { (alert) in}
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            self.loadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateNote(noteModel: myNote[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
