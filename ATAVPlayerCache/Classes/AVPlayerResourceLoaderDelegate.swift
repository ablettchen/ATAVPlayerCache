//
//  AVPlayerResourceLoaderDelegate.swift
//  AVPlayerCache


import Foundation
import AVFoundation

let kScheme = "__AVPlayerScheme__"

public class AVPlayerResourceLoaderDelegate: NSObject {
    // MARK: - Properties
    private lazy var loadingRequests: [URL: AVPlayerResourceLoader] = [:]
}

// MARK: - PoAVPlayerResourceLoaderManager

extension AVPlayerResourceLoaderDelegate: AVAssetResourceLoaderDelegate {
    
    /// avasset遇到系统无法处理的url时会调用此方法
    public func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        if let url = loadingRequest.request.url, url.absoluteString.hasPrefix(kScheme) {
            if let loader = loadingRequests[url] {
                loader.appending(loadingRequest)
            } else {
                loadingRequests.removeAll() // 释放之前地址的loader对象
                let urlStr = url.absoluteString[kScheme.endIndex...]
                let originalUrl = URL(string: String(urlStr))!
                let loader = AVPlayerResourceLoader(resourceIdentifier: originalUrl)
                loader.appending(loadingRequest)
                loadingRequests[url] = loader
            }
            return true
        }
        return false
    }
    
    /// 当数据加载完成或者播放跳转到到别的时间时会调用此方法
    public func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
        if let url = loadingRequest.request.url, let loader = loadingRequests[url] {
            loader.cancel(loadingRequest)
            if loader.isEmpty {
                loadingRequests.removeValue(forKey: url)
            }
        }
    }
}
