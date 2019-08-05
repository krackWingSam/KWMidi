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
    
    init(useMic: Bool = false) {
        super.init(.IO)
        
        if useMic {
            var err = noErr
            var flag = UInt32(1)
            var size = UInt32(MemoryLayout.size(ofValue: flag))
            err = AudioUnitSetProperty(self.audioUnit!, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, 1, &flag, size)
            if err != noErr {
                printError("io unit enable input mic failed", err)
            }
            
            var desc = getOutputDesc()
            desc.mSampleRate = 44100
            size = UInt32(MemoryLayout.size(ofValue: desc))
            err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &desc, size)
            if err != noErr {
                printError("io unit set input stream format failed", err)
            }
            
            err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 1, &desc, size)
            if err != noErr {
                printError("io unit set output stream format failed", err)
            }
        }
    }
    
    override func initializeAudioUnit() {
        super.initializeAudioUnit()
        
        var err = noErr
        err = AudioOutputUnitStart(self.audioUnit!)
        if err != noErr {
            printError("io unit start error", err)
        }
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
