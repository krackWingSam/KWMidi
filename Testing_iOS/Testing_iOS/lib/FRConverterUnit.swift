//
//  FRConverterUnit.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FRConverterUnit: FRAudioUnit {
    init() {
        super.init(.Converter)
    }
    
    override func connectAudioUnit(_ destination: FRAudioUnit, _ destInputNumber: UInt32) {
        var err = noErr
        var desc = AudioStreamBasicDescription()
        var size = UInt32(MemoryLayout.size(ofValue: desc))
        err = AudioUnitGetProperty(destination.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &desc, &size)
        if err != noErr {
            printError("get audio input description in Converter Unit", err)
        }

        err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 0, &desc, size)
        if err != noErr {
            printError("set audio input description in Converter Unit", err)
        }
        
        super.connectAudioUnit(destination, destInputNumber)
    }
}
