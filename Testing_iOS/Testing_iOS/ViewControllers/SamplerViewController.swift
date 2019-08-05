//
//  SamplerViewController.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class SamplerViewController: UIViewController {
    var ioUnit          : FRIOUnit?
    var mixerUnit       : FRMixerUnit?
    var samplerUnit     : FRSamplerUnit?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func initSamplerUnits() {
        ioUnit = FRIOUnit.init()
        
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
    
    
    //MARK: -
    @IBAction func action_InitSampler(_ sender: Any) {
        initSamplerUnits()
    }
    
    @IBAction func action_OnMidiSignal(_ sender: Any) {
        guard let sampler = samplerUnit else { return }
        sampler.onMidiSignal(72, velocity: 90)
    }
    
    @IBAction func action_OffMidiSignal(_ sender: Any) {
        guard let sampler = samplerUnit else { return }
        sampler.offMidiSignal(72, velocity: 90)
    }
}
