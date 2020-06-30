//
//  AudioFilesViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class AudioFilesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var audioController: AudioFilesController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAudioList()
    }
    
    private func setupAudioList() {
        audioController = AudioFilesController()
        audioController?.loadFiles()
        tableView.reloadData()
    }
    
}

extension AudioFilesViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let audioList = audioController?.getAudioList() else { return 0 }
        return audioList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self)) as! CustomTableViewCell
        guard let audio = audioController?.getAudioList()[indexPath.row] else { return cell }
        cell.fillWith(model: audio)
        cell.deleteCompletion = {
            self.deleteTrack(url: audio.url)
        }
        
        return cell
    }
    
    private func deleteTrack(url: URL) {
        let deleteFileVC = DeleteFileViewController.init()
        deleteFileVC.modalPresentationStyle = .overFullScreen
        deleteFileVC.modalTransitionStyle = .coverVertical
        deleteFileVC.completion = {
            self.audioController?.deleteFile(url: url)
            self.setupAudioList()
        }
        present(deleteFileVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let audio = audioController?.getAudioList() else { return }
        let userInfo = ["CurrentAudio" : audio[indexPath.row].url, "AudioList" : audio] as [String : Any]
        NotificationCenter.default.post(name: NotificationNames.audioListener, object: nil, userInfo: userInfo)
    }
}
