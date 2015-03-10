//
//  SLMediaController.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit
import AVFoundation
class SLMediaController: UIViewController, SLMediaPlayerConTrolDelegate {
    
    var asset: AVAsset?
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var playerView: SLPlayerView?
    var transport: SLMediaPlayerDelegate?
    
    var timeObserver: AnyObject?
    var itemEndObserver: AnyObject?
    var lastPlaybackRate: Float?
    var imageGenerator: AVAssetImageGenerator
    
    init(url: NSURL?) {
        super.init()
        if let turl = url{
            self.asset? = AVAsset.assetWithURL(turl) as AVAsset
            prepareToPlay()
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }
    
        
    func prepareToPlay(){
        if let asset = self.asset{
            var keys = ["tracks","duration","commonMetadata","availableMediaCharacteristicsWithMediaSelectionOptions"]
            self.playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: keys)
            
            self.playerItem?.addObserver(self, forKeyPath: "status", options: .New, context: nil)
            
            self.player = AVPlayer(playerItem: self.playerItem)
            
            self.playerView = SLPlayerView(player: self.player!)
            
            self.transport = self.playerView?.transport
            
            self.transport?.delegate = self
            
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in

            self.playerItem?.removeObserver(self, forKeyPath: "status")
            if(self.playerItem?.status == .ReadyToPlay){
//                var duration = self.playerItem.duration;
                self.player?.play()
            }
        })
    }
    
    
}
