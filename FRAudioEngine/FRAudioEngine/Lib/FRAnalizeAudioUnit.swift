//
//  AnalyzeAudioUnit.swift
//  FRAudioEngine
//
//  Created by exs-mobile 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class FRAnalizeAudioUnit: NSObject {
    class func analize(_ unit: AudioUnit) {
        let something: UInt32 = 0
        var size = UInt32(MemoryLayout.size(ofValue: something))
        var err = AudioUnitGetPropertyInfo(unit,
                                           kAudioUnitProperty_ParameterList,
                                           kAudioUnitScope_Global,
                                           0,
                                           &size,
                                           nil);
        
        if err != noErr {
            print("error for get property size")
        }
        
        let numOfparams = size / UInt32(MemoryLayout.size(ofValue: something))
        print("numOfParams = ", numOfparams)
        
        // paramList
        var paramList: [AudioUnitParameterID] = Array(repeating: 0, count: Int(numOfparams))
        
        err = AudioUnitGetProperty(unit,
                             kAudioUnitProperty_ParameterList,
                             kAudioUnitScope_Global,
                             0,
                             &paramList,
                             &size);
        
        if err != noErr {
            print("error for get property list")
            return
        }
        
        print(paramList)
        
        var paramInfo: [AudioUnitParameterInfo] = []
        for _ in 0..<numOfparams {
            paramInfo.append(AudioUnitParameterInfo())
        }
        
        for i in 0..<Int(numOfparams) {
            print("param : ", i)
            let paramID = paramList[i]
            var size = UInt32(MemoryLayout.size(ofValue: paramInfo[i]))
            
            err = AudioUnitGetProperty(unit,
                                       kAudioUnitProperty_ParameterInfo,
                                       kAudioUnitScope_Global,
                                       paramID,
                                       &paramInfo[i],
                                       &size)
            if err != noErr {
                print("get audio unit property error : err")
                continue
            }
            
            var buffer = paramInfo[i].name
            let name = withUnsafePointer(to: &buffer) {
                $0.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout.size(ofValue: paramInfo[i].name)) {
                    String(cString: $0)
                }
            }
            print("# name = ", name)
            print("# minValue = ", paramInfo[i].minValue)
            print("# maxValue = ", paramInfo[i].maxValue)
            print("# defaultValue = ", paramInfo[i].defaultValue)
        }
    }
}
