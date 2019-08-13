//
//  ReverbTestViewController.swift
//  FRAudioEngine
//
//  Created by exs-mobile 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class ReverbTestViewController: UIViewController {
//    let reverb = FRReverbNode()
    let reverb = AVAudioUnitReverb()

    @IBOutlet weak var label_DryWebMix: UILabel!
    @IBOutlet weak var label_Gain: UILabel!
    @IBOutlet weak var label_MinDelayTime: UILabel!
    @IBOutlet weak var label_MaxDelayTime: UILabel!
    @IBOutlet weak var label_DecayTimeAt0Hz: UILabel!
    @IBOutlet weak var label_DecayTimeAtNyquist: UILabel!
    @IBOutlet weak var label_RandomReflections: UILabel!
    
    var array_Label: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        array_Label = [label_DryWebMix, label_Gain, label_MinDelayTime, label_MaxDelayTime, label_DecayTimeAt0Hz, label_DecayTimeAtNyquist, label_RandomReflections]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initEngine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deinitEngine()
    }
    
    func initEngine() {
        let engine = FRAudioEngine.shared
        engine.stopEngine()
        
        let format = FRAudioEngine.shared.format
        engine.attach(node: reverb)
        reverb.wetDryMix = 100
        
        engine.connectFromInput(reverb, format: format)
        engine.connectToMixer(reverb, mixerInputBus: 0, format: format)
        engine.connect(engine.mixer, to: engine.output, format: format)
        
        engine.startEngine()
        
        
        FRAnalizeAudioUnit.analize(reverb.audioUnit)
    }
    
    func deinitEngine() {
        let engine = FRAudioEngine.shared
        engine.detach(node: reverb)
        engine.stopEngine()
    }
    
    
    @IBAction func action_SliderValueChange(_ sender: UISlider) {
        guard let param = FRReverbParamID(rawValue: UInt32(sender.tag)) else { return }
//        reverb.setReverbParamter(paramID: param, value: sender.value)
        let err = AudioUnitSetParameter(reverb.audioUnit, AudioUnitParameterID(sender.tag), kAudioUnitScope_Global, 0, sender.value, 0)
        if err != noErr {
            print("set reverb param error : ", err)
        }
        
        let label = array_Label[sender.tag]
        label.text = String(format:"%1.3f", sender.value)
    }

}
