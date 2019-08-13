//
//  FRReverbNode.swift
//  FRAudioEngine
//
//  Created by exs-mobile 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

enum FRReverbParamID: AudioUnitParameterID {
    case DryWetMix          = 0
    case Gain               = 1
    case MinDelayTime       = 2
    case MaxDelayTime       = 3
    case DecayTimeAt0Hz     = 4
    case DecayTimeAtNyquist = 5
    case RandomReflections  = 6
}

class FRReverbNode: FRNode {
    override init() {
        super.init()
        componentDescription.componentType = kAudioUnitType_Effect
        componentDescription.componentSubType = kAudioUnitSubType_Reverb2
        
        AVAudioUnit.instantiate(with: componentDescription, options: []) { (unit, error) in
            if error != nil {
                print("AVAudioUnit get instance error : ", error.debugDescription)
                return
            }
            self.unit = unit
        }
    }
    
    // MARK: - Public
    public func setReverbParamter(paramID: FRReverbParamID, value: Float32) {
        var err = noErr
        
        err = AudioUnitSetParameter(self.unit.audioUnit, kReverb2Param_Gain, kAudioUnitScope_Global, 0, value, 0)
        if err != noErr {
            print("set reverb param failed", err)
            return
        }
    }
}
