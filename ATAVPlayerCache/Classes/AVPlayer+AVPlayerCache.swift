//
//  AVPlayer+AVPlayerCache.swift
//  ATAVPlayerCache
//
//  Created by ablett on 2019/12/20.
//

import Foundation
import AVKit

extension AVPlayer {
    @objc public func currentUrl() -> URL? {
        let asset = self.currentItem?.asset
        if (asset is AVURLAsset) {
            let _asset: AVURLAsset = asset as! AVURLAsset
            let url = _asset.url
            if url.absoluteString.hasPrefix(kScheme) {
                let urlStr = url.absoluteString[kScheme.endIndex...]
                let originalUrl = URL(string: String(urlStr))!
                return originalUrl
            }
            return url
        }
        return nil
    }
}

extension AVPlayerItem {
    @objc public class func cacheItem(url: URL, delegate: AVPlayerResourceLoaderDelegate) -> AVPlayerItem {
        if url.absoluteString.hasPrefix("http") {
            let cacheUrl = URL(string: kScheme + url.absoluteString)!
            let urlAsset = AVURLAsset(url: cacheUrl)
            urlAsset.resourceLoader.setDelegate(delegate, queue: DispatchQueue.main)
            return AVPlayerItem(asset: urlAsset)
        }
        return AVPlayerItem(url: url)
    }
}
