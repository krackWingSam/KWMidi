//
//  AUTestViewController.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 07/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation
import AudioUnit

class AUTestViewController: UIViewController {

    var audioEngine : AVAudioEngine!
    
    var samplerUnit : AVAudioUnit?
    var mixerUnit   : AVAudioUnit?
    var ioUnit      : AVAudioUnit?
    var mixerNode   : AVAudioNode?
    var ioNode      : AVAudioNode?
    
    @IBOutlet weak var label_Velocity: UILabel!
    @IBOutlet weak var label_Note: UILabel!
    @IBOutlet weak var slider_Velocity: UISlider!
    @IBOutlet weak var slider_Note: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func test() {
        
        initAudioUnits()
    }
    
    func initAudioUnits() {
        // init audio engine
        audioEngine = AVAudioEngine()
        
        
        mixerNode = audioEngine.mainMixerNode
        ioNode = audioEngine.outputNode
        
        var samplerCD = AudioComponentDescription()
        samplerCD.componentType = kAudioUnitType_MusicDevice
        samplerCD.componentSubType = kAudioUnitSubType_Sampler
        samplerCD.componentManufacturer = kAudioUnitManufacturer_Apple
        samplerCD.componentFlags = 0
        samplerCD.componentFlagsMask = 0
        
        AVAudioUnit.instantiate(with: samplerCD, options: [], completionHandler: { (unit, error) in
            guard let audioUnit = unit?.audioUnit else { print("asdfasdfasdf"); return }
            var propertyList = FRAUPresetLoader.loadPreset(presetName: "KDPiano")
            let size = MemoryLayout.size(ofValue: propertyList)
            let err = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &propertyList, UInt32(size))
            print("set audio property for sampler preset", err)
            
            self.samplerUnit = unit
            print(unit)
            print(error)
            self.tryToAttachAudioUnits()
        })
    }
    
    func tryToAttachAudioUnits() {
        guard let samplerUnit = samplerUnit,
              let mixerNode = mixerNode,
              let ioNode = ioNode
            else {
                return
        }
        
//        audioEngine.attach(ioNode)
//        audioEngine.attach(mixerNode)
        audioEngine.attach(samplerUnit)
        
        let format = ioNode.outputFormat(forBus: 0)
        audioEngine.connect(samplerUnit, to: mixerNode, format: format)
        audioEngine.connect(mixerNode, to: ioNode, format: format)
        
        do {
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            print(error)
        }
    }
    
    
    
    @IBAction func action_StartTest(_ sender: Any) {
        test()
    }
    
    @IBAction func action_MidiOn(_ sender: Any) {
        var err = noErr
        let noteCommand = 0x9 << 4 | 0
        
        guard let unit = samplerUnit?.audioUnit else { return }
        err = MusicDeviceMIDIEvent(unit, UInt32(noteCommand), UInt32(slider_Note.value), UInt32(slider_Velocity.value), 0)
        if err != noErr {
            print("on midi signal in sampler", " ### ", err)
        }
    }
    
    @IBAction func action_MidiOff(_ sender: Any) {
        var err = noErr
        let noteCommand = 0x8 << 4 | 0
        
        guard let unit = samplerUnit?.audioUnit else { return }
        err = MusicDeviceMIDIEvent(unit, UInt32(noteCommand), UInt32(slider_Note.value), UInt32(slider_Velocity.value), 0)
        if err != noErr {
            print("off midi signal in sampler", " ### ", err)
        }
    }
    
    @IBAction func action_Velocity(_ sender: UISlider) {
        label_Velocity.text = String(format: "%2.2f", sender.value)
    }
    
    @IBAction func action_Note(_ sender: UISlider) {
        label_Note.text = String(format: "%2.2f", sender.value)
    }

}
