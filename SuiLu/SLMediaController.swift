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
    var imageGenerator: AVAssetImageGenerator?

    
    
    init(url: NSURL?) {
        super.init()
        if let turl = url{
            self.asset? = AVAsset.assetWithURL(turl) as! AVAsset
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
            
            self.transport = self.playerView!.overlayView!
            
            (self.transport as! SLOverlayView).delegate = self
            
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        dispatch_async(dispatch_get_main_queue(), {[weak self]  () -> Void in
            
            if let strongSelf = self{
                strongSelf.playerItem?.removeObserver(strongSelf, forKeyPath: "status")
                if(strongSelf.playerItem?.status == .ReadyToPlay){
                    strongSelf.addPlayerItemTimeObserver()
                    strongSelf.addItemEndObserverForPlayerItem()
                    var duration = strongSelf.playerItem!.duration;
                    strongSelf.transport!.setCurrentTime(CMTimeGetSeconds(kCMTimeZero), duration: CMTimeGetSeconds(duration))
                    strongSelf.transport!.setTitle(strongSelf.asset!.title)
                    strongSelf.player?.play()
                    
                    strongSelf.loadMediaOptions()
                    strongSelf.generateThumbnails()
                }else{
                    
                }
            }
        })
    }
    
    func addPlayerItemTimeObserver(){
        var interval =
            CMTimeMakeWithSeconds(0.5, Int32(NSEC_PER_SEC));
         var queue = dispatch_get_main_queue();
        self.timeObserver = self.player?.addPeriodicTimeObserverForInterval(interval, queue: queue, usingBlock: { [weak self](time: CMTime) -> Void in
            if let strongSelf = self{
                var currentTime = CMTimeGetSeconds(time);
                var duration = CMTimeGetSeconds(strongSelf.playerItem!.duration);
                strongSelf.transport?.setCurrentTime(currentTime, duration: duration);  // 4
            }
        })
    }
    
    func addItemEndObserverForPlayerItem(){
        var name = AVPlayerItemDidPlayToEndTimeNotification;

        var queue = NSOperationQueue.mainQueue()
     
        self.itemEndObserver = NSNotificationCenter.defaultCenter().addObserverForName(name, object: self.playerItem, queue: queue, usingBlock: {[weak self] (noti:NSNotification!) -> Void in
            if let strongSelf = self{
                strongSelf.player?.seekToTime(kCMTimeZero, completionHandler: { (finished:Bool) -> Void in
                    strongSelf.transport?.playbackComplete()
                })
            }
            
        })
    }
    
    func loadMediaOptions(){
        var mc = AVMediaCharacteristicLegible
        
       var group = self.asset?.mediaSelectionGroupForMediaCharacteristic(mc)
        if let tgroup = group{
            var subTitles = [String]()
            for option in tgroup.options{
                subTitles.append((option as! AVMediaSelectionOption).displayName)
            }
            self.transport?.setSubTitles(subTitles)
        }else{
             self.transport?.setSubTitles([])
        }
    }
    
    func subtitleSelected(subTitle: String) {
         var mc = AVMediaCharacteristicLegible
        var group = self.asset?.mediaSelectionGroupForMediaCharacteristic(mc)
        if let tgroup = group{
            
            var selected = false
            for option in tgroup.options{
                if(option.displayName == subTitle){
                    self.playerItem?.selectMediaOption(option as! AVMediaSelectionOption, inMediaSelectionGroup: group)
                    selected = true;
                }
            }
            if(!selected){
                self.playerItem?.selectMediaOption(nil, inMediaSelectionGroup: group)
            }
        }
    }
    
    func generateThumbnails(){
         self.imageGenerator = AVAssetImageGenerator(asset: self.asset)
         self.imageGenerator?.maximumSize = CGSizeMake(200, 0.0)
         var duration = self.asset!.duration;
         var times = [AnyObject]();                         // 3
         var increment = duration.value / 20;
         var currentValue = 2 * duration.timescale;
        
        while (Int(currentValue) <= Int(duration.value)) {
            
        var time = CMTimeMake(Int64(currentValue), duration.timescale);
            
        times.append(NSValue(CMTime: time))
         currentValue += Int(increment);
        }
        
        var imageCount = times.count;
        var  images = [AnyObject]();
        self.imageGenerator?.generateCGImagesAsynchronouslyForTimes(times, completionHandler: { (requestedTime:CMTime, imageRef:CGImage!, actualTime:CMTime, result:AVAssetImageGeneratorResult, error:NSError!) -> Void in
            if (result == .Succeeded) {
                var image = UIImage(CGImage: imageRef)
                var thumbnail = SLThumbNail(image: image!, time: actualTime)
                images.append(thumbnail)
            }else{
                
            }
            if (--imageCount == 0) {
                 dispatch_async(dispatch_get_main_queue(), {[weak self] () -> Void in
                    var name = "thumbnailgenerated";
                    var notificationCenter = NSNotificationCenter.defaultCenter()
                    notificationCenter.postNotificationName(name, object: images)
                 })
            }
        })
    }
    
    
    
    // MARK: -Delegates
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func stop() {
        self.player?.rate = 0.0
        self.transport?.playbackComplete()
    }
    
    func jumpedToTime(time: NSTimeInterval) {
        self.player?.seekToTime(CMTimeMakeWithSeconds(time, Int32(NSEC_PER_SEC)))
        
    }
    
    func scrubbingDidStart() {
        self.lastPlaybackRate = self.player?.rate
        self.player?.pause()
        self.player?.removeTimeObserver(self.timeObserver)
    }
    
    func scrubbedToTime(time: NSTimeInterval) {
        self.playerItem?.cancelPendingSeeks()
        self.player?.seekToTime(CMTimeMakeWithSeconds(time, Int32(NSEC_PER_SEC)), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        
    }
    
    func scrubbingDidEnd() {
        
        if(self.lastPlaybackRate > 0.0){
            self.player?.play()
        }
    }
    
    deinit{
        if let ob: AnyObject = self.itemEndObserver{
            var name = AVPlayerItemDidPlayToEndTimeNotification;
            var notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.removeObserver(ob, name: name, object: self.player!.currentItem)
            self.itemEndObserver = nil;
        }
    }
    
}
