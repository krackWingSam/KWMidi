//
//  FRAudioEngine.swift
//  FRAudioEngine
//
//  Created by Fermata 강상우 on 13/08/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import AVFoundation

class FRAudioEngine: NSObject {
    static let shared = FRAudioEngine()
    
    private let localEngine = AVAudioEngine()
    var input: AVAudioInputNode {
        get {
            return localEngine.inputNode
        }
    }
    var output: AVAudioOutputNode {
        get {
            return localEngine.outputNode
        }
    }
    var mixer: AVAudioMixerNode {
        get {
            return localEngine.mainMixerNode
        }
    }
    var format: AVAudioFormat {
        get {
            return localEngine.outputNode.outputFormat(forBus: 0)
        }
    }
    
    // MARK: Public
    func startEngine() {
        do {
            localEngine.prepare()
            try localEngine.start()
        } catch {
            print("start engine Error : ", error)
        }
    }
    
    func stopEngine() {
        localEngine.stop()
    }
    
    
    func attach(node: FRNode) {
        localEngine.attach(node.unit)
    }
    
    func attach(node: AVAudioNode) {
        localEngine.attach(node)
    }
    
    func detach(node: FRNode) {
        localEngine.detach(node.unit)
    }
    
    func detach(node: AVAudioNode) {
        localEngine.detach(node)
    }
    
    func connect(_ node: FRNode, to: FRNode, format: AVAudioFormat) {
        localEngine.connect(node.unit, to: to.unit, format: format)
    }
    
    func connect(_ node: AVAudioNode, to: AVAudioNode, format: AVAudioFormat) {
        localEngine.connect(node, to: to, format: format)
    }
    
    func connectFromInput(_ node: FRNode, format: AVAudioFormat) {
        let input = localEngine.inputNode
        localEngine.connect(input, to: node.unit, format: format)
    }
    
    func connectFromInput(_ node: AVAudioNode, format: AVAudioFormat) {
        let input = localEngine.inputNode
        localEngine.connect(input, to: node, format: format)
    }
    
    func connectToMixer(_ node: FRNode, mixerInputBus: Int, format: AVAudioFormat) {
        let mixer = localEngine.mainMixerNode
        localEngine.connect(node.unit, to: mixer, fromBus: 0, toBus: mixerInputBus, format: format)
    }
    
    func connectToMixer(_ node: AVAudioNode, mixerInputBus: Int, format: AVAudioFormat) {
        let mixer = localEngine.mainMixerNode
        localEngine.connect(node, to: mixer, fromBus: 0, toBus: mixerInputBus, format: format)
    }
}
