//
//  FRMicUnit.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 06/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FRMicUnit: FRAudioUnit {
    init() {
        super.init(.Mic)
        
        var err = noErr
        var size : UInt32 = 0
        var desc = getOutputDesc()
        desc.mSampleRate = 44100

        var on = UInt32(1)
        var off = UInt32(0)
        size = UInt32(MemoryLayout.size(ofValue: on))
        err = AudioUnitSetProperty(self.audioUnit!, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, 1, &on, size)
        if err != noErr {
            printError("io unit enable input mic failed", err)
        }
        
        err = AudioUnitSetProperty(self.audioUnit!, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, 0, &off, size)
        if err != noErr {
            printError("io unit disable output mic failed", err)
        }
        
        size = UInt32(MemoryLayout.size(ofValue: desc))
        err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &desc, size)
        if err != noErr {
            printError("io unit set input stream format failed", err)
        }
    }
}
