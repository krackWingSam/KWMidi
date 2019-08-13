//
//  FRNode.swift
//  FRAudioEngine
//
//  Created by Fermata 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class FRNode: NSObject {
    var isInit: Bool {
        if unit != nil {
            return true
        }
        
        return false
    }
    
    var componentDescription = AudioComponentDescription()
    var unit: AVAudioUnit!
    
    override init() {
        super.init()
        
        componentDescription.componentManufacturer = kAudioUnitManufacturer_Apple
        componentDescription.componentFlags = 0
        componentDescription.componentFlagsMask = 0
    }
}
