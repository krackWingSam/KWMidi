//
//  FRIOUnit.swift
//  FRAudioUnit
//
//  Created by exs-mobile 강상우 on 02/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FRIOUnit: FRAudioUnit {
    
    init() {
        super.init(.IO)
    }
    
    //MARK: - Public
    public func setOutputVolume(volume: Float) {
        var err = noErr
        err = AudioUnitSetParameter(self.audioUnit!, kHALOutputParam_Volume, kAudioUnitScope_Output, 0, volume, 0)
        printError("output volue set", err)
    }
}
