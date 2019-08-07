//
//  FRReverbUnit.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

enum FRReverbParamID: UInt32 {
    case DryWetMix          = 0
    case Gain
    case MinDelayTime
    case MaxDelayTime
    case DecayTimeAt0Hz
    case DecayTimeAtNyquist
    case RandomReflections
}

class FRReverbUnit: FRAudioUnit {
    init() {
        super.init(.Reverb)
    }
    
    //MARK: - Public
    public func setReverbParamter(paramID: FRReverbParamID, value: Float32) {
        var err = noErr
        err = AudioUnitSetParameter(self.audioUnit!, paramID.rawValue, kAudioUnitScope_Global, 0, value, 0)
        if err != noErr {
            printError("set reverb param failed", err)
            return
        }
    }
}
