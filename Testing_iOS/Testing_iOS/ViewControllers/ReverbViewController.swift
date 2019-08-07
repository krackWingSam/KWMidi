//
//  ReverbViewController.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class ReverbViewController: UIViewController {
    
    @IBOutlet weak var slider_DryWetMix: UISlider!
    @IBOutlet weak var slider_Gain: UISlider!
    @IBOutlet weak var slider_MinDelayTime: UISlider!
    @IBOutlet weak var slider_MaxDelayTime: UISlider!
    @IBOutlet weak var slider_DecayTimeAt0Hz: UISlider!
    @IBOutlet weak var slider_DecayTimeAtNyquist: UISlider!
    @IBOutlet weak var slider_RandomReflections: UISlider!
    
    @IBOutlet weak var label_DryWetMix: UILabel!
    @IBOutlet weak var label_Gain: UILabel!
    @IBOutlet weak var label_MinDelayTime: UILabel!
    @IBOutlet weak var label_MaxDelayTime: UILabel!
    @IBOutlet weak var label_DecayTimeAt0Hz: UILabel!
    @IBOutlet weak var label_DecayTimeAtNyquist: UILabel!
    @IBOutlet weak var label_RandomReflections: UILabel!
    
    var outputUnit      : FROutputUnit?
    var inputUnit       : FRMicUnit?
    var mixerUnit       : FRMixerUnit?
    var converterUnit   : FRConverterUnit?
    var reverbUnit      : FRReverbUnit?
    var arrayLabel      : [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrayLabel = [label_DryWetMix, label_Gain, label_MinDelayTime, label_MaxDelayTime, label_DecayTimeAt0Hz, label_DecayTimeAtNyquist, label_RandomReflections]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deinitAudioUnits()
    }
    
    func initAudioUnits() {
        outputUnit = FROutputUnit.init()
        inputUnit = FRMicUnit.init()
        mixerUnit = FRMixerUnit.init()
        reverbUnit = FRReverbUnit.init()
        
        guard let output = outputUnit,
              let input = inputUnit,
              let mixer = mixerUnit,
              let reverb = reverbUnit
            else { return }
        
        input.connectAudioUnit(reverb, 0)
        reverb.connectAudioUnit(mixer, 0)
        mixer.connectAudioUnit(output, 0)
        
        input.initializeAudioUnit()
        reverb.initializeAudioUnit()
        mixer.initializeAudioUnit()
        output.initializeAudioUnit()
        
        mixer.setMixerOutputVolume(1.0)
        mixer.setMixerVolume(1.0, channel: 0)
        
        output.setOutputVolume(volume: 1.0)
    }
    
    func deinitAudioUnits() {
        inputUnit?.unInitializeAudioUnit()
        outputUnit?.unInitializeAudioUnit()
        reverbUnit?.unInitializeAudioUnit()
        mixerUnit?.unInitializeAudioUnit()
    }
    
    
    //MARK: - IBActions
    @IBAction func action_InitAudioUnit(_ sender: Any) {
        initAudioUnits()
    }

    @IBAction func action_Slider(_ sender: UISlider) {
        let tag = sender.tag
        guard let paramID = FRReverbParamID.init(rawValue: UInt32(tag)) else { return }
        reverbUnit?.setReverbParamter(paramID: paramID, value: sender.value)
        
        let label = arrayLabel[tag]
        label.text = String(format: "%1.1f", sender.value)
    }
}
