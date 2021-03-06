//
//  AVPlayerResourceRequestTask.swift
//  AVPlayerCache


import UIKit
import AVFoundation

protocol AVPlayerResourceRequestTaskDelegate: AnyObject {
    
    func requestTask(_ task: AVPlayerResourceRequestTask, didReceiveResponse response: URLResponse)
    
    func requestTask(_ task: AVPlayerResourceRequestTask, didReceiveData data: Data)
    
    func requestTask(_ task: AVPlayerResourceRequestTask, didCompleteWithError error: Error?)
}

// MARK: - AVPlayerResourceRequestTask

class AVPlayerResourceRequestTask: NSObject {
    
    weak var delegate: AVPlayerResourceRequestTaskDelegate?
    let requestRange: NSRange
    var currentOffset: Int
    
    var isCached: Bool = false
    var isExecuting: Bool = false
    var isFinished: Bool = false
    var isCancelled: Bool = false
    
    init(requestRange: NSRange) {
        self.requestRange = requestRange
        self.currentOffset = requestRange.location
    }
    
    func start() {
        isExecuting = true
    }
    
    func cancel() {
        isExecuting = false
        isCancelled = true
    }
}


// MARK: - AVPlayerResourceRequestLocalTask
private let kBufferSize = 1024 * 64
class AVPlayerResourceRequestLocalTask: AVPlayerResourceRequestTask {
    
    // MARK: - Properties
    unowned let fileHandler: AVPlayerResourceCacheFileHandler
    
    init(fileHandler: AVPlayerResourceCacheFileHandler, requestRange: NSRange) {
        self.fileHandler = fileHandler
        super.init(requestRange: requestRange)
    }
    
    
    override func start() {
        super.start()
        DispatchQueue.global().async {
            self.loadLocalData()
        }
    }
    
    private func loadLocalData() {
        if isCancelled {
            isFinished = true;
            let error = NSError(domain: "local task", code: -1, userInfo: [NSLocalizedDescriptionKey: "local task cacelled"])
            self.delegate?.requestTask(self, didCompleteWithError: error)
        }
        
        self.delegate?.requestTask(self, didReceiveResponse: fileHandler.response)
        let upperBound = self.requestRange.upperBound
        
        while currentOffset < upperBound {
            if isCancelled { break }
            autoreleasepool { () -> Void in
                let length = min(upperBound - currentOffset, kBufferSize)
                let data = self.fileHandler.readData(offset: currentOffset, length: length)
                self.delegate?.requestTask(self, didReceiveData: data)
                currentOffset += length
            }
        }
        
        if isCancelled {
            let error = NSError(domain: "local task", code: -1, userInfo: [NSLocalizedDescriptionKey: "local task cacelled"])
            self.delegate?.requestTask(self, didCompleteWithError: error)
        } else {
            self.delegate?.requestTask(self, didCompleteWithError: nil)
        }
        isFinished = true
    }
    
}


// MARK: - AVPlayerResourceRequestRemoteTask

class AVPlayerResourceRequestRemoteTask: AVPlayerResourceRequestTask {
    
    // MARK: - Properties
    let task: URLSessionDataTask
    
    init(task: URLSessionDataTask, requestRange: NSRange) {
        self.task = task
        super.init(requestRange: requestRange)
    }
    
    override func start() {
        super.start()
        task.resume()
    }
    
    override func cancel() {
        if isCancelled || isFinished { return }
        super.cancel()
        task.cancel()
    }
}

