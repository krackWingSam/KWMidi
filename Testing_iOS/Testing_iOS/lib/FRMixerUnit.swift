//
//  FRMixerUnit.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FRMixerUnit: FRAudioUnit {
    let MIXER_MAX_CHANNEL   = 30
    let MIXER_AUDIO_CHANNEL = 1
    
    init() {
        super.init(.Mixer)
        
        var err = noErr
        var busCount = UInt32(MIXER_MAX_CHANNEL)
        let size = MemoryLayout.size(ofValue: busCount)
        
        err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_ElementCount, kAudioUnitScope_Input, 0, &busCount, UInt32(size))
        if err != noErr {
            printError("Mixer Unit set Input Channel Count", err)
            return
        }
        
        for i in 0..<busCount {
            setMixerVolume(0, channel: i)
        }
    }
    
    
    //MARK: - Public
    public func setMixerVolume(_ volume: Float32, channel: UInt32) {
        var err = noErr
        err = AudioUnitSetParameter(self.audioUnit!, kMultiChannelMixerParam_Volume, kAudioUnitScope_Input, channel, volume, 0)
        if err != noErr {
            printError("Set Mixer Volume", err)
            return
        }
    }
    
    public func setMixerOutputVolume(_ volume: Float32) {
        var err = noErr
        err = AudioUnitSetParameter(self.audioUnit!, kMultiChannelMixerParam_Volume, kAudioUnitScope_Output, 0, volume, 0)
        if err != noErr {
            printError("set Mixer Output Volume", err)
            return
        }
    }
}
