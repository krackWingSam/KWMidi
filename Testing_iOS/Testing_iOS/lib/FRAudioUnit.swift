//
//  FRAudioUnit.swift
//  FRAudioUnit
//
//  Created by exs-mobile 강상우 on 02/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import AudioToolbox

enum FRAudioUnitType: Int {
    case IO
    case Mixer
    case Sampler
    case Reverb
    case EQ
    case File
    case PeakLimiter
    case Compressor
    case Converter
}

class FRAudioUnit: NSObject {
    public typealias FourCharCode = UInt32
    public typealias OSType = FourCharCode
    
    var type                    : FRAudioUnitType!
    var audioUnit               : AudioUnit?        = nil
    
    //MARK: - Initializer
    /**
     초기화 함수
     */
    init(_ type: FRAudioUnitType!) {
        super.init()
        self.type = type
        var desc = self.getDesc(type)
        let comp = AudioComponentFindNext(nil, &desc)
        let err = AudioComponentInstanceNew(comp!, &audioUnit)
        if err != noErr {
            printError("audio unit create error", err)
        }
    }
    
    //MARK: - Module Private
    func printError(_ title: String, _ err: Any) {
        print(title + " ## ", err)
    }
    
    //MARK: - Private
    private func getDesc(_ type: FRAudioUnitType) -> AudioComponentDescription {
        let manufacturer: OSType    = kAudioUnitManufacturer_Apple
        let flags: UInt32           = 0
        let flagsMask: UInt32       = 0
        var componentType: OSType
        var componentSubType: OSType
        
        switch type {
        case .IO:
            componentType       = kAudioUnitType_Output
            componentSubType    = kAudioUnitSubType_RemoteIO
            
        case .Mixer:
            componentType       = kAudioUnitType_Mixer
            componentSubType    = kAudioUnitSubType_MultiChannelMixer
            
        case .Sampler:
            componentType       = kAudioUnitType_MusicDevice
            componentSubType    = kAudioUnitSubType_Sampler
            
        case .EQ:
            componentType       = kAudioUnitType_Effect
            componentSubType    = kAudioUnitSubType_NBandEQ
            
        case .Reverb:
            componentType       = kAudioUnitType_Effect
            componentSubType    = kAudioUnitSubType_Reverb2
            
        case .File:
            componentType       = kAudioUnitType_Generator
            componentSubType    = kAudioUnitSubType_VoiceProcessingIO
            
        case .PeakLimiter:
            componentType       = kAudioUnitType_Effect
            componentSubType    = kAudioUnitSubType_PeakLimiter
            
        case .Compressor:
            componentType       = kAudioUnitType_Effect
            componentSubType    = kAudioUnitSubType_DynamicsProcessor
            
        case .Converter:
            componentType       = kAudioUnitType_FormatConverter
            componentSubType    = kAudioUnitSubType_AUConverter
        }
        return AudioComponentDescription(componentType: componentType, componentSubType: componentSubType, componentManufacturer: manufacturer, componentFlags: flags, componentFlagsMask: flagsMask)
    }
    
    func getInputDesc() -> AudioStreamBasicDescription {
        var err = noErr
        var desc = AudioStreamBasicDescription()
        var size = UInt32(MemoryLayout.size(ofValue: desc))
        err = AudioUnitGetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &desc, &size)
        if err != noErr {
            printError("get audio component description in io unit", err)
        }
        
        return desc
    }
    
    func getOutputDesc() -> AudioStreamBasicDescription {
        var err = noErr
        var desc = AudioStreamBasicDescription()
        var size = UInt32(MemoryLayout.size(ofValue: desc))
        err = AudioUnitGetProperty(self.audioUnit!, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 0, &desc, &size)
        if err != noErr {
            printError("get audio component description in io unit", err)
        }
        
        return desc
    }
    
    //MARK: - Public
    /**
    */
    public func connectAudioUnit(_ destination: FRAudioUnit, _ destInputNumber: UInt32) {
        let dest = destination.audioUnit!
        var sourceOutputNumber: UInt32 = 0
        if self.type == .IO {
            sourceOutputNumber = 1
        }
        var connectionInfo = AudioUnitConnection(sourceAudioUnit: self.audioUnit, sourceOutputNumber: sourceOutputNumber, destInputNumber: destInputNumber)
        
        let size = UInt32(MemoryLayout.size(ofValue: connectionInfo))
        let err = AudioUnitSetProperty(dest, kAudioUnitProperty_MakeConnection, kAudioUnitScope_Input, 0, &connectionInfo, size)
        if err != noErr {
            printError("connect Audio Unit", err)
        }
        
        print("##########")
        print(self)
        print(getInputDesc())
        print(getOutputDesc())
        print("##########")
    }
    
    public func initializeAudioUnit() {
        var err: OSStatus = noErr
        if self.audioUnit == nil {
            printError("initialize audio unit", "unit not allocated")
        }
        err = AudioUnitInitialize(self.audioUnit!)
        if err != noErr {
            printError("initialize audio unit", err)
        }
    }
    
    public func unInitializeAudioUnit() {
        var err: OSStatus = noErr
        err = AudioUnitUninitialize(self.audioUnit!)
        if err != noErr {
            printError("unInitialize audio unit", err)
        }
    }
}
