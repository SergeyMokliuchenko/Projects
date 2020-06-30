//
//  AudioController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 28.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import Foundation

class AudioFilesController {
    
    private let destonationProvider: DestinationProvider
    private var audioList: [FileModel] = []
    
    init(destonationProvider: DestinationProvider = DestinationProvider(format: "mp3", folder: "Audio")) {
        self.destonationProvider = destonationProvider
    }
    
}

extension AudioFilesController: FilesManager {
    
    func loadFiles() {
        audioList.removeAll()
        for file in destonationProvider.getFiles() {
            let name = file.name
            let url = file.url
            let file = FileModel.init(name: name, url: url)
            audioList.append(file)
        }
    }
    
    func deleteFile(url: URL) {
        destonationProvider.deleteFile(url: url)
    }
    
    func getAudioList() -> [FileModel] {
        return audioList
    }
    
}
