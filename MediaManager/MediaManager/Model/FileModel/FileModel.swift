//
//  ListModel.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 27.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit
import AVKit

class FileModel {
    
    var name: String
    var url: URL
    lazy var fileItem: AVPlayerItem = AVPlayerItem.init(url: url)
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
    
extension FileModel {
    
    func getFirstFrameWithVideo() -> UIImage {
        do {
            let imgGenerator = AVAssetImageGenerator(asset: fileItem.asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        return UIImage()
    }
    
    func getCover() -> UIImage {
        for metadataItem in fileItem.asset.commonMetadata {
            if metadataItem.commonKey!.rawValue == "artwork" {
                let imageData = metadataItem.value as! NSData
                let image: UIImage = UIImage(data: imageData as Data)!
                return image
            }
        }
        return UIImage()
    }
    
    func getArtistName() -> String {
        for metadataItem in fileItem.asset.commonMetadata {
            if metadataItem.commonKey!.rawValue == "artist" {
                let artistName = metadataItem.value as! String
                return artistName
            }
        }
        return String()
    }
    
    func getTrackName() -> String {
        for metadataItem in fileItem.asset.commonMetadata {
            if metadataItem.commonKey!.rawValue == "title" {
                let trackName = metadataItem.value as! String
                return trackName
            }
        }
        return String()
    }
    
}
