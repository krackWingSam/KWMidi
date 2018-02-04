//
//  TestGroundViewController.m
//  TestGround
//
//  Created by askstory on 2018. 2. 4..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "TestGroundViewController.h"

#import "KWAudio.h"

@interface TestGroundViewController () {
    //for test sampler
    KWMixerUnit *mixerUnit;
    KWOutputUnit *outputUnit;
    KWSamplerUnit *samplerUnit;
    KWConverterUnit *outputConverterUnit;
}

@end

@implementation TestGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self testFunc];
}



#pragma mark - Tests
-(void)testFunc {
    //make test sampler
    [self testMakeMidiSampler];
    
    //make test midi device
    [self testMakeMidiDevice];
}

-(void)testMakeMidiSampler {
    mixerUnit = [[KWMixerUnit alloc] init];
    outputUnit = [[KWOutputUnit alloc] init];
    samplerUnit = [[KWSamplerUnit alloc] initWithPresetName:@"KDPiano"];
    
    [samplerUnit connectAudioUnit:mixerUnit withDestinationNumber:0];
    [mixerUnit connectAudioUnit:outputUnit withDestinationNumber:0];
    
    NSArray *array_AudioUnit = @[outputUnit, mixerUnit, samplerUnit];
    
    for (KWAudioUnit *unit in array_AudioUnit) {
        [unit initializeAudioUnit];
    }
    
    [mixerUnit setMixerOutputVolume:1.f];
    [mixerUnit setMixerVolume:1.f withChannel:0];
    [outputUnit setOutputVolume:1.f];
}

-(void)testMakeMidiDevice {
    
}

@end
