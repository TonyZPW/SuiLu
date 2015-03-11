//
//  AVAssetAddition.swift
//  SuiLu
//
//  Created by ZPW on 3/11/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAsset{
    var title: String{
        get{
            var status = self.statusOfValueForKey("commonMetadata", error: nil)  as AVKeyValueStatus
            if(status == .Loaded){
                var items = AVMetadataItem.metadataItemsFromArray(self.commonMetadata, withKey: AVMetadataCommonKeyTitle, keySpace: AVMetadataKeySpaceCommon)
                
                if(items.count > 0){
                    var item = items.first as! AVMetadataItem
                    return (item.value) as! String
                }
            }
            return ""
        }
    }
    
}