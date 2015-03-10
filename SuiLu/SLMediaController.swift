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
        var keys = ["tracks","duration","commonMetadata","availableMediaCharacteristicsWithMediaSelectionOptions"]
        if let asset = self.asset{
            self.playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: keys)
            
            
            self.player = AVPlayer(playerItem: self.playerItem)
            
        }
        
        
        
    
        
    }
    
    
}
