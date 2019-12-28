//
//  AVPlayerCacheApply.swift
//  AVPlayerCache


import Foundation
import AVKit

public class AVPlayerCacheApply: NSObject {
    
    @objc public class var shared: AVPlayerCacheApply {
        struct Static {
            static let instance: AVPlayerCacheApply = AVPlayerCacheApply()
        }
        return Static.instance
    }
    
    private lazy var loaderDelegate: AVPlayerResourceLoaderDelegate = AVPlayerResourceLoaderDelegate()
    
    @objc public func avPlayerItem(with url: URL) -> AVPlayerItem {
        if url.absoluteString.hasPrefix("http") {
            let cacheUrl = URL(string: loaderDelegate.kAVPlayerCacheScheme + url.absoluteString)!
            let urlAsset = AVURLAsset(url: cacheUrl)
            urlAsset.resourceLoader.setDelegate(loaderDelegate, queue: DispatchQueue.main)
            return AVPlayerItem(asset: urlAsset)
        }
        return AVPlayerItem(url: url)
    }
    
    @objc public func url(with avPlayerItem: AVPlayerItem) -> URL? {
        let asset = avPlayerItem.asset
        if (asset is AVURLAsset) {
            let _asset: AVURLAsset = asset as! AVURLAsset
            let url = _asset.url
            if url.absoluteString.hasPrefix(loaderDelegate.kAVPlayerCacheScheme) {
                let urlStr = url.absoluteString[loaderDelegate.kAVPlayerCacheScheme.endIndex...]
                let originalUrl = URL(string: String(urlStr))!
                return originalUrl
            }
            return url
        }
        return nil
    }
}
