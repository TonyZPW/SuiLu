//
//  MediaPlayerDelegate.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//
import UIKit

@objc protocol SLMediaPlayerConTrolDelegate{
    
    func play()
    func pause()
    func stop()

    func scrubbingDidStart()
    func scrubbedToTime(time: NSTimeInterval)
    func scrubbingDidEnd()
    
    func jumpedToTime(time: NSTimeInterval)
    
    optional func subtitleSelected(subTitle: String)
}

@objc protocol SLMediaPlayerDelegate{
    
   var delegate: SLMediaPlayerConTrolDelegate{get set}
    
    func setTitle(title: String)
    func setCurrentTime(time: NSTimeInterval, duration:NSTimeInterval)
    func setScrubbingTime(time: NSTimeInterval)
    func playbackComplete()
    func setSubTitles(titles: Array<String>)
    
}

