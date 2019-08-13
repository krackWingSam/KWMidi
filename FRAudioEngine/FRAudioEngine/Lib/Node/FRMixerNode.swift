//
//  FRMixerNode.swift
//  FRAudioEngine
//
//  Created by Fermata 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class FRMixerNode: FRNode {
    override init() {
        super.init()
        
        componentDescription.componentType = kAudioUnitType_Mixer
        componentDescription.componentSubType = kAudioUnitSubType_MultiChannelMixer
        
        AVAudioUnit.instantiate(with: componentDescription, options: []) { (unit, error) in
            if error != nil {
                print("AVAudioUnit get instance error : ", error.debugDescription)
                return
            }
            self.unit = unit
        }
    }
    
    public func setInputChannelVolume(_ inChannel: UInt32, volume: Float32) {
        let unit = self.unit.audioUnit
        let err = AudioUnitSetParameter(unit, kMultiChannelMixerParam_Volume, kAudioUnitScope_Input, inChannel, volume, 0)
        if err != noErr {
            print("set mixer input channel error : ", err)
        }
    }
    
    public func setOutputChannelVolume(volume: Float32) {
        let unit = self.unit.audioUnit
        let err = AudioUnitSetParameter(unit, kMultiChannelMixerParam_Volume, kAudioUnitScope_Output, 0, volume, 0)
        if err != noErr {
            print("set mixer output channel error : ", err)
        }
    }
}
