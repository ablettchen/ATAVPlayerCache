//
//  PlayerViewController.swift
//  ATAVPlayerCache_Example
//
//  Created by ablett on 2020/1/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AVKit
import ATAVPlayerCache

class PlayerViewController: AVPlayerViewController {

    public var playFinished: (() -> Void)?
    
    private lazy var loaderDelegate: AVPlayerResourceLoaderDelegate = AVPlayerResourceLoaderDelegate()

    public func confPlayer(with urlString: String) {
        let item: AVPlayerItem? = AVPlayerItem.cacheItem(url: URL(string: urlString)!, delegate: loaderDelegate)
        player = AVPlayer.init(playerItem: item)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoGravity = AVLayerVideoGravity.resizeAspect.rawValue
        showsPlaybackControls = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(playFinishedAction(noti:)), name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }

    @objc func playFinishedAction(noti: Notification) {
        playFinished?()
    }

}
