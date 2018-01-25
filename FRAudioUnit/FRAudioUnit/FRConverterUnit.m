//
//  FRConverterUnit.m
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 26..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRConverterUnit.h"

@implementation FRConverterUnit

-(id)init {
    if (self = [super initWithType:kFRAudioUnitType_Converter]) {
        
    }
    return self;
}

-(id)initWithType:(kFRConverterType)type {
    if (self = [self init]) {
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
        
        if (type == kFRConverterType_Input) {
            err = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &ioFormat, sizeof(ioFormat));
            if (err)
                NSLog(@"converter streamformat input set failed : %d", (int)err);
        }
        else if (type == kFRConverterType_Output) {
            AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 1, &ioFormat, sizeof(ioFormat));
            if (err)
                NSLog(@"converter streamformat output set failed : %d", (int) err);
        }
    }
    return self;
}

@end
