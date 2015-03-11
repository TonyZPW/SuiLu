//
//  SLThumbNail.swift
//  SuiLu
//
//  Created by ZPW on 3/11/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit
import AVFoundation
class SLThumbNail: NSObject {
    var time: CMTime?
    var image: UIImage?
    
    
   convenience init(image: UIImage, time: CMTime){
        self.init(timage:image, ttime:time)
    }
    
    init(timage: UIImage, ttime: CMTime) {
        super.init()
        self.time = ttime
        self.image = timage
    }
}
