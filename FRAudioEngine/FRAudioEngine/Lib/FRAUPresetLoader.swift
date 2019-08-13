//
//  FRAUPresetLoader.swift
//  Testing_iOS
//
//  Created by Fermata 강상우 on 07/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRAUPresetLoader: NSObject {
    
    class func loadPreset(presetName: String) -> CFPropertyList? {
        guard let presetData = loadPresetData(presetName) else { return nil }
        guard let presetDic = convertDataToDictionary(presetData) else { return nil }
        guard let fixedPresetDic = fixFileRef(presetDic) else { return nil }
        return fixedPresetDic as CFPropertyList
    }
    
    class func loadPresetData(_ presetName: String) -> Data? {
        // prepare property data
        guard let presetPath = Bundle.main.path(forResource:presetName , ofType: "aupreset") else {
            print("sampler unit load preset", " ### ", "no preset name")
            return nil
        }
        let presetURL = URL(fileURLWithPath: presetPath)
        var propertyResourceData: Data?
        let dataReadingOptions: NSData.ReadingOptions = []
        
        do {
            propertyResourceData = try Data(contentsOf: presetURL, options: dataReadingOptions)
        } catch {
            print("sampler unit load preset", " ### ", error)
            return nil
        }
        
        return propertyResourceData
    }
    
    class func convertDataToDictionary(_ data: Data) -> [String: Any]? {
        var tempList: Any
        do {
            tempList = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        } catch {
            print("convert Data To Dictionary", " ### ", error)
            return nil
        }
        
        guard let list = tempList as? [String: Any] else { return nil }
        return list
    }
    
    class func fixFileRef(_ presetDic: [String: Any]) -> [String: Any]? {
        let KEY_FILE_REFERENCE = "file-references"
        
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
    
//    private func applyPropertyList(_ list: CFPropertyList) {
//        var err = noErr
//        var propertyList = list
//        let size = MemoryLayout.size(ofValue: list)
//        err = AudioUnitSetProperty(self.audioUnit!, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &propertyList, UInt32(size))
//
//        if err != noErr {
//            printError("apply property list", err)
//        }
//    }
}
