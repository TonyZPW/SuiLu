//
//  ViewController.swift
//  SuiLu
//
//  Created by Tony_Zhao on 3/10/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import UIKit

class SLHomeController: UIViewController {
    
    
    var localURL : NSURL? = NSBundle.mainBundle().URLForResource("", withExtension: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier != "play"){
            return false
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "play"){
            
            var playMC = segue.destinationViewController as SLPlayMediaController
            
            if let localUrl = self.localURL{
                playMC.assetURL? = localUrl
            }
        }
        
    }


}

