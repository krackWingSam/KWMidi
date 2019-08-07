//
//  FRIOUnit.swift
//  FRAudioUnit
//
//  Created by exs-mobile 강상우 on 02/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FROutputUnit: FRAudioUnit {
    
    init() {
        super.init(.IO)
    }
    
    override func initializeAudioUnit() {
        super.initializeAudioUnit()
        
        var err = noErr
        err = AudioOutputUnitStart(self.audioUnit!)
        if err != noErr {
            printError("io unit start error", err)
        }
    }
    
    override func unInitializeAudioUnit() {
        var err = noErr
        err = AudioOutputUnitStop(self.audioUnit!)
        if err != noErr {
            printError("io unit stop error", err)
        }
        
        super.unInitializeAudioUnit()
    }
    
    //MARK: - Public
    public func setOutputVolume(volume: Float) {
        var err = noErr
        err = AudioUnitSetParameter(self.audioUnit!, kHALOutputParam_Volume, kAudioUnitScope_Output, 0, volume, 0)
        if err != noErr {
            printError("output volue set", err)
        }
    }
}
