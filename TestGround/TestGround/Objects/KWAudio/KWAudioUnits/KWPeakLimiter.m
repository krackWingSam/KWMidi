//
//  FRPeakLimiter.m
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 20..
//  Copyright © 2016년 상우 강. All rights reserved.
//


//use peak limmter with preGain  

#import "KWPeakLimiter.h"

@implementation KWPeakLimiter

-(id)init {
    if (self = [super initWithType:kKWAudioUnitType_PeakLimiter]) {
        AudioUnit audioUnit = [self audioUnit];
        OSStatus err = noErr;
        err = AudioUnitSetParameter(audioUnit, kLimiterParam_PreGain, kAudioUnitScope_Global, 0, 20, 0);
        if (err)
            NSLog(@"limiter set pregain failed : %d", (int)err);
    }
    return self;
}

@end
