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
    
    var transport: SLMediaPlayerDelegate{
        get{
            return self.overlayView!
        }
    }
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.classForCoder()
    }
    
    init(player: AVPlayer) {
        super.init()
        self.backgroundColor = UIColor.blackColor()
        self.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        
        (self.layer as! AVPlayerLayer).player = player
            
       self.overlayView = NSBundle.mainBundle().loadNibNamed("SLOverlayView", owner: self, options: nil)[0] as? SLOverlayView
        
        if let overlayV = self.overlayView{
            self.addSubview(overlayV)
        }
    }
   
    required init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.overlayView?.frame = self.bounds
    }
    
    
}
