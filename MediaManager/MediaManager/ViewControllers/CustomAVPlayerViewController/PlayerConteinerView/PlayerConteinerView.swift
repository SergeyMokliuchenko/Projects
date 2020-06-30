//
//  PlayerView.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 04.06.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerConteinerView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private var avPlayerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    var avPlayer: AVPlayer? {
        get { return avPlayerLayer.player }
        set { avPlayerLayer.player = newValue }
    }
    
}
