//
//  FRMixerUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRMixerUnit.h"



@interface FRMixerUnit () {
    
}

@end

@implementation FRMixerUnit

-(id)init {
    if (self = [super initWithType:kFRAudioUnitType_Mixer]) {
        OSStatus err = noErr;
        
        UInt32 busCount = MIXER_MAX_CHANNEL;
        UInt32 size = sizeof(busCount);
        AudioUnit audioUnit = [self audioUnit];
        err = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_ElementCount, kAudioUnitScope_Input, 0, &busCount, size);
        if (err)
            NSLog(@"Mixer set MaximumChannel failed : %d", (int)err);
        
        [self setMixerVolume:0 withChannel:0];
    }
    return self;
}


-(void)setMixerVolume:(Float32)volume withChannel:(UInt32)channelNum {
    OSStatus err = noErr;
    AudioUnit audioUnit = [self audioUnit];
    err = AudioUnitSetParameter(audioUnit, kMultiChannelMixerParam_Volume, kAudioUnitScope_Input, channelNum, volume, 0);
    if (err)
        NSLog(@"mixer volume set failed : %d", (int)err);
}

-(void)setMixerOutputVolume:(Float32)volume {
    OSStatus err = noErr;
    err = AudioUnitSetParameter(self.audioUnit, kMultiChannelMixerParam_Volume, kAudioUnitScope_Output, 0, volume, 0);
    if (err)
        NSLog(@"mixer output volume set failed : %d", (int)err);
}

-(float)getMixerVolumeWithChannelNumber:(UInt32)channel {
    float returnValue = 0;
    OSStatus err = noErr;
    err = AudioUnitGetParameter(self.audioUnit, kMultiChannelMixerParam_Volume, kAudioUnitScope_Input, channel, &returnValue);
    if (err)
        NSLog(@"get mixer volume failed : %d", (int)err);
    return returnValue;
}

@end