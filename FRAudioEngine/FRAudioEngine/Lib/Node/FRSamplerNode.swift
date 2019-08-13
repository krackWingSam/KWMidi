//
//  FRSamplerNode.swift
//  FRAudioEngine
//
//  Created by Fermata 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class FRSamplerNode: FRNode {
    override init() {
        super.init()
        
        componentDescription.componentType = kAudioUnitType_MusicDevice
        componentDescription.componentSubType = kAudioUnitSubType_Sampler
        
        AVAudioUnit.instantiate(with: componentDescription, options: []) { (unit, error) in
            if error != nil {
                print("AVAudioUnit get instance error : ", error.debugDescription)
                return
            }
            self.unit = unit
        }
    }
    
    func loadPreset(_ presetName: String) {
        let unit = self.unit.audioUnit
        var propertyList = FRAUPresetLoader.loadPreset(presetName: "KDPiano")
        let size = MemoryLayout.size(ofValue: propertyList)
        let err = AudioUnitSetProperty(unit, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &propertyList, UInt32(size))
        if err != noErr {
            print("set load aupreset in sampler error : ", err)
        }
    }
}
