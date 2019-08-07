//
//  SamplerViewController.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class SamplerViewController: UIViewController {
    
    @IBOutlet weak var slider_Note: UISlider!
    @IBOutlet weak var slider_Velocity: UISlider!
    @IBOutlet weak var label_Note: UILabel!
    @IBOutlet weak var label_Velocity: UILabel!
    
    
    var ioUnit          : FROutputUnit?
    var mixerUnit       : FRMixerUnit?
    var samplerUnit     : FRSamplerUnit?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func initSamplerUnits() {
        ioUnit = FROutputUnit.init()
        
        samplerUnit = FRSamplerUnit.init("KDPiano")
        
        mixerUnit = FRMixerUnit.init()
        
        guard let sampler = samplerUnit,
              let mixer = mixerUnit,
              let io = ioUnit
            else { return }
        
        sampler.connectAudioUnit(mixer, 0)
        mixer.connectAudioUnit(io, 0)
        
        sampler.initializeAudioUnit()
        mixer.initializeAudioUnit()
        io.initializeAudioUnit()
        
        mixer.setMixerOutputVolume(1.0)
        mixer.setMixerVolume(1.0, channel: 0)
        
        io.setOutputVolume(volume: 1.0)
    }
    
    
    //MARK: - IBActions
    @IBAction func action_InitSampler(_ sender: Any) {
        initSamplerUnits()
    }
    
    @IBAction func action_OnMidiSignal(_ sender: Any) {
        guard let sampler = samplerUnit else { return }
        sampler.onMidiSignal(UInt32(slider_Note.value), velocity: UInt32(slider_Velocity.value))
    }
    
    @IBAction func action_OffMidiSignal(_ sender: Any) {
        guard let sampler = samplerUnit else { return }
        sampler.offMidiSignal(UInt32(slider_Note.value), velocity: UInt32(slider_Velocity.value))
    }
    
    @IBAction func action_VelocityValueChange(_ sender: UISlider) {
        label_Velocity.text = String(format: "%2.f", sender.value)
    }
    
    @IBAction func action_NoteValueChange(_ sender: UISlider) {
        label_Note.text = String(format: "%2.f", sender.value)
    }
}
