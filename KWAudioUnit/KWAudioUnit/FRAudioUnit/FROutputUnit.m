//
//  FROutputUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FROutputUnit.h"

@implementation FROutputUnit

-(id)init {
    if (self = [super initWithType:kFRAudioUnitType_Output]) {

    }
    return self;
}

-(void)initializeAudioUnit {
    [super initializeAudioUnit];
    AudioUnit audioUnit = [self audioUnit];
    OSStatus err = AudioOutputUnitStart(audioUnit);
    if (err)
        NSLog(@"outputUnit start failed : %d", (int)err);
}

-(void)uninitialize {
    OSStatus err = noErr;
    err = AudioOutputUnitStop(self.audioUnit);
    if (err)
        NSLog(@"output unit stop failed : %d", (int)err);
}

-(void)setOutputVolume:(float)volume {
    OSStatus err;
    err = AudioUnitSetParameter(self.audioUnit, kHALOutputParam_Volume, kAudioUnitScope_Output, 0, volume, 0);
    if (err)
        NSLog(@"audio unit set param for output volume : %d", (int)err);
}

@end
