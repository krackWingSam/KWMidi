//
//  FRSamplerUnit.swift
//  FRAudioUnit
//
//  Created by exs-mobile 강상우 on 02/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AudioToolbox

class FRSamplerUnit: FRAudioUnit {
    
    fileprivate let KEY_FILE_REFERENCE = "file-references"
    
    init(_ presetName: String) {
        super.init(.Sampler)
        guard let propertyList = loadPreset(presetName) else { return }
        applyPropertyList(propertyList)
    }
    
    func loadPreset(_ presetName: String) -> CFPropertyList? {
        guard let presetData = loadPresetData(presetName) else { return nil }
        guard let presetDic = convertDataToDictionary(presetData) else { return nil }
        guard let fixedPresetDic = fixFileRef(presetDic) else { return nil }
        return fixedPresetDic as CFPropertyList
    }
    
    private func loadPresetData(_ presetName: String) -> Data? {
        // prepare property data
        guard let presetPath = Bundle.main.path(forResource:presetName , ofType: "aupreset") else {
            printError("sampler unit load preset", "no preset name")
            return nil
        }
        let presetURL = URL(fileURLWithPath: presetPath)
        var propertyResourceData: Data?
        let dataReadingOptions: NSData.ReadingOptions = []
        
        do {
            propertyResourceData = try Data(contentsOf: presetURL, options: dataReadingOptions)
        } catch {
            printError("sampler unit load preset", error)
            return nil
        }
        
        return propertyResourceData
    }
    
    private func convertDataToDictionary(_ data: Data) -> [String: Any]? {
        var tempList: Any
        do {
            tempList = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        } catch {
            printError("convert Data To Dictionary", error)
            return nil
        }
        
        guard let list = tempList as? [String: Any] else { return nil }
        return list
    }
    
    private func fixFileRef(_ presetDic: [String: Any]) -> [String: Any]? {
        guard var fileRefDic = presetDic[KEY_FILE_REFERENCE] as? [String: Any] else { return nil }
        
        for key in fileRefDic.keys {
            guard let strValue = fileRefDic[key] as? String else { continue }
            let value = strValue.replacingOccurrences(of: ".caf", with: "")
            guard let newValue = Bundle.main.path(forResource: value, ofType: ".caf") else { continue }
            fileRefDic[key] = newValue
        }
        
        var returnDic = presetDic
        returnDic.updateValue(fileRefDic, forKey: KEY_FILE_REFERENCE)
        
        return returnDic
    }
    
    private func applyPropertyList(_ list: CFPropertyList) {
        var err = noErr
        var propertyList = list
        let size = MemoryLayout.size(ofValue: list)
        err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &propertyList, UInt32(size))
        
        if err != noErr {
            printError("apply property list", err)
        }
    }
    
    //MARK: - Public
    public func onMidiSignal(_ noteNumber: UInt32, velocity: UInt32) {
        var err = noErr
        let noteCommand = 0x9 << 4 | 0
        
        err = MusicDeviceMIDIEvent(self.audioUnit!, UInt32(noteCommand), noteNumber, velocity, 0)
        if err != noErr {
            printError("on midi signal in sampler", err)
        }
    }
    
    public func offMidiSignal(_ noteNumber: UInt32, velocity: UInt32) {
        var err = noErr
        let noteCommand = 0x8 << 4 | 0
        
        err = MusicDeviceMIDIEvent(self.audioUnit!, UInt32(noteCommand), noteNumber, velocity, 0)
        if err != noErr {
            printError("off midi signal in sampler", err)
        }
    }
    
}
