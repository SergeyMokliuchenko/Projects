//
//  DownloadManager.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import Foundation
import Alamofire

class DownloadManager {
    
    var format: String
    var folder: String
    
    init(format: String = "mp3", folder: String = "Audio") {
        self.format = format
        self.folder = folder
    }
    
    func downloadFile(url: String, fileName: String, completion: @escaping (Progress) -> Void) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("\(self.folder)/\(fileName).\(self.format)")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(url, to: destination)
            .response { response in debugPrint(response) }
            .downloadProgress { progress in completion(progress) }
    }
    
}
