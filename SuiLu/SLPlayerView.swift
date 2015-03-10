//
//  SLPlayerView.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit
import AVFoundation
class SLPlayerView: UIView {
    
    var overlayView:SLOverlayView?
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.classForCoder()
    }
    
    init(player: AVPlayer) {
        super.init()
        self.backgroundColor = UIColor.blackColor()
        self.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        
        (self.layer as AVPlayerLayer).player = player
            

    }
   
    required init(coder aDecoder: NSCoder) {
        super.init()
    }
}
