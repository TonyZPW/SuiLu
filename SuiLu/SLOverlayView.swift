//
//  SLOverlayView.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit
import MediaPlayer
class SLOverlayView: UIView, SLMediaPlayerDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var filmStripView: SLFilmStripView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var scrubTimeLine: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var remainingL: UILabel!
    @IBOutlet weak var currentTimeL: UILabel!
    @IBOutlet weak var togglePlayButton: UIButton!
    @IBOutlet weak var filmstripToggleButton: UIButton!
    
    
    var controlsHidden: Bool?
    var filmstripHidden: Bool?
    var excludedViews: [AnyObject]?
    var sliderOffset: Float?
    var infoViewOffset: Float?
    var timer: NSTimer?
    var scrubbing: Bool?
    var subtitles: [String]?
    var controller: SLSubtitleController?
    var selectedSubtitle: String?
    var lastPlaybackRate: Float?
    var volumeView: MPVolumeView?
    var delegate: SLMediaPlayerConTrolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.filmstripHidden = true;
        self.excludedViews = [self.navigationBar, self.toolbar, self.filmStripView];
        
        var thumbNormalImage = UIImage(named: "knob");
        var thumbHighlightedImage = UIImage(named: "knob_highlighted");
        
        self.slider.setThumbImage(thumbNormalImage, forState: .Normal)
        self.slider.setThumbImage(thumbHighlightedImage, forState: .Highlighted)
        self.infoView.hidden = true;
        calculateInfoViewOffset()
        
        self.slider.addTarget(self, action: "showPopupUI", forControlEvents: .ValueChanged)
        self.slider.addTarget(self, action: "hidePopupUI", forControlEvents: .TouchUpInside)
        self.slider.addTarget(self, action: "unhidePopupUI", forControlEvents: .TouchDown)
        
        self.filmStripView.layer.shadowOffset = CGSizeMake(0, 2)
        self.filmStripView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.filmStripView.layer.shadowRadius = 2
        self.filmStripView.layer.shadowOpacity = 0.8
        
        enableAirplay()
        resetTimer()
        
    }
    
    func calculateInfoViewOffset(){
        
    }
    func enableAirplay(){
        
    }
    func resetTimer(){
        
    }
    
    
    func setCurrentTime(time: NSTimeInterval){
        
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        
    }
    @IBAction func togglePlayback(sender: AnyObject) {
        
    }
    @IBAction func toggleControls(sender: AnyObject)
    {
        
    }
    @IBAction func toggleFilmstripButton(sender: AnyObject) {
        
    }
}
