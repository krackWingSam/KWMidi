//
//  FRSamplerUnit.swift
//  FRAudioUnit
//
//  Created by exs-mobile 강상우 on 02/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRSamplerUnit: FRAudioUnit {
    
    init(_ presetName: String) {
        super.init(.Sampler)
        loadPreset(presetName)
    }
    
    func loadPreset(_ presetName: String) {
        var err = noErr
        
        // prepare property data
        guard let presetPath = Bundle.main.path(forResource:presetName , ofType: "aupreset") else {
            printError("sampler unit load preset", "no preset name")
            return
        }
        let presetURL = URL(fileURLWithPath: presetPath)
        var propertyResourceData: Data?
        var dataReadingOptions: NSData.ReadingOptions = []
        
        var unit = self.audioUnit
        
        do {
            propertyResourceData = try Data(contentsOf: presetURL, options: dataReadingOptions)
        } catch {
            printError("sampler unit load preset", error)
            return
        }
        
        loadPropertyList(propertyResourceData!)
        
        
        var tempDic: NSDictionary?
    }
    
    private func loadPropertyList(_ propertyResourceData: Data) {
        // convert property data to property list
        var presetPropertyList: CFPropertyList?
        var dataFormat: CFPropertyListFormat? = nil
        var error: CFError = CFErrorCreate(nil, "" as CFErrorDomain, 0, nil)
        let size = MemoryLayout.size(ofValue: CFError.self)
        
        
        
        
        //        presetPropertyList = CFPropertyListCreateWithData(kCFAllocatorDefault, propertyResourceData as CFData?, 0, &dataFormat!, errorRef)
    }
    
    //MARK: - Public
    
    
}
