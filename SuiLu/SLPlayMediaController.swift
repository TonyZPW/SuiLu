//
//  SLPlayMediaController.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit

class SLPlayMediaController: UIViewController {
    
    var assetURL : NSURL?
    
    lazy var mediaController : SLMediaController = {
        return SLMediaController(url: self.assetURL)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var preview = self.mediaController.view
        preview.frame = self.view.frame
        self.view.addSubview(preview)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
