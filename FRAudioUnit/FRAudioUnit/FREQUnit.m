//
//  FREQUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FREQUnit.h"

@implementation FREQUnit

-(id)init {
    if (self = [super initWithType:kFRAudioUnitType_EQ]) {
        OSStatus err = noErr;
        
        AudioStreamBasicDescription ioFormat = {};
        ioFormat.mSampleRate = 44100;
        ioFormat.mFormatID = kAudioFormatLinearPCM;
        ioFormat.mFormatFlags = 41;
        ioFormat.mBytesPerPacket = 4;
        ioFormat.mFramesPerPacket = 1;
        ioFormat.mBytesPerFrame = 4;
        ioFormat.mChannelsPerFrame = 1;
        ioFormat.mBitsPerChannel = 32;
        ioFormat.mReserved = 0;
        
        AudioUnit audioUnit = [self audioUnit];
        
        err = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &ioFormat, sizeof(ioFormat));
        if (err)
            NSLog(@"micUnit streamformat input set failed : %d", (int)err);
        
        AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 1, &ioFormat, sizeof(ioFormat));
        if (err)
            NSLog(@"micUnit streamformat output set failed : %d", (int) err);
        
        err = AudioUnitSetParameter(audioUnit, kAUNBandEQParam_BypassBand, kAudioUnitScope_Global, 0, 0, 0);
        if (err)
            NSLog(@"set bypass band set true failed : %d", (int)err);
    }
    return self;
}

-(void)setEQGain:(float)gainValue {
    OSStatus err = noErr;
    AudioUnit audioUnit = [self audioUnit];
    err = AudioUnitSetParameter(audioUnit, kAUNBandEQParam_Gain, kAudioUnitScope_Global, 0, gainValue, 0);
    if (err)
        NSLog(@"eq set gain failed : %d", (int)err);
}

@end
