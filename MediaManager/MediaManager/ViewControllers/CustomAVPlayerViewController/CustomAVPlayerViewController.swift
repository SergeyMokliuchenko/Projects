//
//  CustomAVPlayerViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 03.06.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit
import AVFoundation

class CustomAVPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerConteinerView: UIView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackIconImage: UIImageView!
    
    @IBOutlet weak var controllView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    private var playerView = PlayerConteinerView()
    private var avPlayer = AVPlayer()
    private var playerItems: [AVPlayerItem] = []
    private var currentTrack: Int = 0
    private var playPause: Bool = false {
        didSet { playPause ? playerPause() : playerPlay() }
    }
    
    private func playerPause() {
        avPlayer.pause()
        playPauseButton.setImage(UIImage(named: "Play_button.png"), for: UIControl.State.normal)
    }
    
    private func playerPlay() {
        avPlayer.play()
        playPauseButton.setImage(UIImage(named: "Stop_button.png"), for: UIControl.State.normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackNameLabel.isHidden = !trackNameLabel.isHidden
        controllView.isHidden = !controllView.isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSliderStyle()
        
        initilizePlayer()
        setupPlayerView()
        sliderTouchHandlers()
        setupPlayerObserver()
        setupNotificationObserver()
    }
    
    private func timeSliderStyle() {
        timeSlider.setThumbImage(UIImage(named: "Scroll_box.png"), for: .normal)
        timeSlider.setThumbImage(UIImage(named: "Scroll_box.png"), for: .highlighted)
    }
    
    private func initilizePlayer() {
        playerView.avPlayer = avPlayer
    }
    
    private func setupPlayerView() {
        
        playerConteinerView.addSubview(playerView)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerConteinerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerConteinerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerConteinerView.widthAnchor, multiplier: 16/9).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerConteinerView.centerYAnchor).isActive = true
    }
    
    private func sliderTouchHandlers() {
         
         timeSlider.addTarget(self, action: #selector(self.sliderTouchBeginAction), for: .touchDown)
         timeSlider.addTarget(self, action: #selector(self.sliderTouchEndAction), for: .touchUpInside)
         timeSlider.addTarget(self, action: #selector(self.sliderTouchEndAction), for: .touchUpOutside)
         timeSlider.addTarget(self, action: #selector(self.changeSliderValueAction), for: .valueChanged)
     }
    
    private func setupPlayerObserver() {
        
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main) { [weak self] time in
            guard let duration: CMTime = self?.avPlayer.currentTime() else { return }
            let seconds: Float64 = CMTimeGetSeconds(duration)
            self?.timeSlider.value = Float(seconds)
            self?.currentTimeLabel.text = self?.stringFromTimeInterval(interval: seconds)
        }
    }
    
    private func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let minutes = (interval / 60) % 60
        let seconds = interval % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func setupNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(playAudio(_:)), name: NotificationNames.audioListener, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playVideo(_:)), name: NotificationNames.videoListener, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(forwardAction), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc private func playAudio(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
        let dict = userInfo as NSDictionary?,
        let audioURL = dict["CurrentAudio"] as? URL,
        let audioList = dict["AudioList"] as? [FileModel] else { return  }
        
        currentPlay(with: audioURL)
        playerPlay()
        playerConteinerView.alpha = 0
        resetSlider()
        setOvnerTime()
        addPlayList(array: audioList)
    }
    
    private func currentPlay(with url: URL) {
        playerItems.removeAll()
        let item = getItem(with: url)
        avPlayer.replaceCurrentItem(with: item)
        getTrackName(item: item)
        getCover(item: item)
    }
    
    private func getItem(with url: URL) -> AVPlayerItem {
        
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        return item
    }
    
    private func getTrackName(item: AVPlayerItem) {
        
        for metadataItem in item.asset.commonMetadata {
            if metadataItem.commonKey!.rawValue == "title" {
                let trackName = metadataItem.value as! String
                self.trackNameLabel.text = trackName
            }
        }
    }
    
    private func getCover(item: AVPlayerItem) {
        
        for metadataItem in item.asset.commonMetadata {
            if metadataItem.commonKey!.rawValue == "artwork" {
                let imageData = metadataItem.value as! NSData
                let image: UIImage = UIImage(data: imageData as Data)!
                self.trackIconImage.image = image
            }
        }
    }
    
    private func resetSlider() {
        timeSlider.value = 0
        guard let duration: CMTime = avPlayer.currentItem?.asset.duration else { return }
        let seconds: Float64 = CMTimeGetSeconds(duration)
        timeSlider.maximumValue = Float(seconds)
    }
    
    private func setOvnerTime() {
        guard let duration: CMTime = avPlayer.currentItem?.asset.duration else { return }
        let seconds: Float64 = CMTimeGetSeconds(duration)
        endTimeLabel.text = stringFromTimeInterval(interval: seconds)
    }
    
    private func addPlayList(array model: [FileModel]) {
        playerItems.removeAll()
        for unit in model {
            let item = getItem(with: unit.url)
            if item != avPlayer.currentItem {
                playerItems.append(item)
            }
        }
    }
    
    @objc private func playVideo(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let dict = userInfo as NSDictionary?,
            let videoURL = dict["CurrentVideo"] as? URL,
            let videoList = dict["VideoList"] as? [FileModel] else { return  }
        currentPlay(with: videoURL)
        playerPlay()
        playerConteinerView.alpha = 1
        resetSlider()
        setOvnerTime()
        addPlayList(array: videoList)
    }
        
}

extension CustomAVPlayerViewController {
    
    
    @IBAction func sliderTouchBeginAction(_ sender: UISlider) {
        playerPause()
    }
    
    @IBAction func sliderTouchEndAction(_ sender: UISlider) {
        
        let seekToTime: CMTime = CMTime.init(seconds: Double(sender.value), preferredTimescale: 10)
        avPlayer.seek(to: seekToTime)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { self.playerPlay() })
    }
    
    @IBAction func changeSliderValueAction(_ sender: UISlider) {
        
        let seconds: TimeInterval = TimeInterval.init(sender.value)
        currentTimeLabel.text = self.stringFromTimeInterval(interval: seconds)
    }
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        playPause = !playPause
    }
    
    @IBAction func backwardAction(_ sender: UIButton) {
        previousTrack()
        playTrack()
        resetSlider()
        setOvnerTime()
    }
    
    private func previousTrack() {
        
        if currentTrack - 1 < 0 {
               currentTrack = (playerItems.count - 1) < 0 ? 0 : (playerItems.count - 1)
           } else {
               currentTrack -= 1
           }
    }
    
    private func playTrack() {

        if playerItems.count > 0 {
            avPlayer.replaceCurrentItem(with: playerItems[currentTrack])
            avPlayer.seek(to: CMTime.zero)
            getTrackName(item: playerItems[currentTrack])
            getCover(item: playerItems[currentTrack])
            playerPlay()
        }
    }

    @IBAction func forwardAction(_ sender: UIButton) {
        nextTrack()
        playTrack()
        resetSlider()
        setOvnerTime()
    }
    
    private func nextTrack() {
        if currentTrack + 1 >= playerItems.count {
            currentTrack = 0
        } else {
            currentTrack += 1
        }
    }
    
}
