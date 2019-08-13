//
//  MixerTestViewController.swift
//  FRAudioEngine
//
//  Created by exs-mobile 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class MixerTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initEngine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deinitEngine()
    }
    
    func initEngine() {
        let engine = FRAudioEngine.shared
        engine.stopEngine()
        
        let format = engine.format
        engine.connectFromInput(engine.mixer, format: format)
        engine.connect(engine.mixer, to: engine.output, format: format)
        
        engine.startEngine()
    }
    
    func deinitEngine() {
        FRAudioEngine.shared.stopEngine()
    }
    
    
    @IBAction func action_SliderValueChange(_ sender: UISlider) {
        let value = sender.value
        print(value)
        FRAudioEngine.shared.mixer.outputVolume = value
    }
}
