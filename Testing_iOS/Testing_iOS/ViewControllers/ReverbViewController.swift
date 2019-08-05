//
//  ReverbViewController.swift
//  Testing_iOS
//
//  Created by exs-mobile 강상우 on 05/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class ReverbViewController: UIViewController {
    var ioUnit          : FRIOUnit?
    var mixerUnit       : FRMixerUnit?
    var converterUnit   : FRConverterUnit?
    var reverbUnit      : FRReverbUnit?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initAudioUnits() {
        ioUnit = FRIOUnit.init(useMic: true)
        mixerUnit = FRMixerUnit.init()
        reverbUnit = FRReverbUnit.init()
        
        guard let io = ioUnit,
              let mixer = mixerUnit,
              let reverb = reverbUnit
            else { return }
        
        io.connectAudioUnit(reverb, 0)
        reverb.connectAudioUnit(mixer, 0)
        mixer.connectAudioUnit(io, 0)
        
        io.initializeAudioUnit()
        reverb.initializeAudioUnit()
        mixer.initializeAudioUnit()
        
        mixer.setMixerOutputVolume(1.0)
        mixer.setMixerVolume(1.0, channel: 0)
        
        io.setOutputVolume(volume: 1.0)
    }
    
    
    @IBAction func action_InitAudioUnit(_ sender: Any) {
        initAudioUnits()
    }

}
