//
//  AudioController.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 24..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "AudioController.h"

@interface AudioController () {
    FRMixerUnit *mixerUnit;
    FROutputUnit *outputUnit;
    FRSamplerUnit *samplerUnit;
    FRConverterUnit *outputConverterUnit;
    
    NSArray *array_AudioUnit;
}
@end


@implementation AudioController

-(void)initDefaultAudioUnits {
    mixerUnit = [[FRMixerUnit alloc] init];
    outputUnit = [[FROutputUnit alloc] init];
    samplerUnit = [[FRSamplerUnit alloc] initWithPresetName:@"KDPiano"];
    
    [samplerUnit connectAudioUnit:mixerUnit withDestinationNumber:0];
    [mixerUnit connectAudioUnit:outputUnit withDestinationNumber:0];
    
    array_AudioUnit = @[outputUnit, mixerUnit, samplerUnit];
    
    for (FRAudioUnit *unit in array_AudioUnit) {
        [unit initializeAudioUnit];
    }
    
    [mixerUnit setMixerOutputVolume:1.f];
    [mixerUnit setMixerVolume:1.f withChannel:0];
    [outputUnit setOutputVolume:1.f];
}

-(void)testMidiOn {
    [samplerUnit testMidiSignal_start];
}

-(void)testMidiOff {
    [samplerUnit testMidiSignal_End];
}

-(void)sendMidiOnWithNoteNumber:(UInt32)noteNumber withVelocity:(UInt32)velocity {
    [samplerUnit onMidiSignal:noteNumber withVelocity:velocity];
}

-(void)sendMidiOffWithNoteNumber:(UInt32)noteNumber withVelocity:(UInt32)velocity {
    [samplerUnit offMidiSignal:noteNumber withVelocity:velocity];
}

@end
