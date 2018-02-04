//
//  FRFileUnit.m
//  IpodExport
//
//  Created by 상우 강 on 2016. 6. 7..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "KWFileUnit.h"

typedef enum : NSUInteger {
    kKWFileUnitStatus_FileNonReady,
    kKWFileUnitStatus_Stop,
    kKWFileUnitStatus_Pause,
    kKWFileUnitStatus_Play,
} kKWFileUnitStatus;

@interface KWFileUnit () {
    AudioFileID fileID;
    AudioStreamBasicDescription inputFormat;
    
    NSURL *currentURL;
    
    ScheduledAudioFileRegion rgn;
    AudioTimeStamp lastTimeStamp;
    kKWFileUnitStatus status;
    
    OSStatus loadStatus;
    
    BOOL isPlay;
}

@end



@implementation KWFileUnit

-(id)init {
    if (self = [super initWithType:kKWAudioUnitType_File]) {
        
    }
    return self;
}

-(float)loadFileWithURL:(NSURL *)url {
    currentURL = url;
    
    OSStatus err = noErr;
    CFURLRef fileURL = (__bridge CFURLRef)url;
    
    err = AudioFileOpenURL(fileURL, kAudioFileReadPermission, 0, &fileID);
    if (err)
        NSLog(@"Audio File Open failed : %d", (int)err);

    UInt32 propSize = sizeof(inputFormat);
    err = AudioFileGetProperty(fileID, kAudioFilePropertyDataFormat, &propSize, &inputFormat);
    if (err)
        NSLog(@"get propsize in inputFile failed : %d", (int)err);
    
    err = AudioUnitSetProperty(self.audioUnit, kAudioUnitProperty_ScheduledFileIDs, kAudioUnitScope_Global, 0, &fileID, sizeof(fileID));
    if (err)
        NSLog(@"set scheduled file id failed : %d", (int)err);
    
    lastTimeStamp.mSampleTime = -1;
    
    
    Float64 ioData;
    propSize = sizeof(ioData);
    err = AudioFileGetProperty(fileID, kAudioFilePropertyEstimatedDuration, &propSize, &ioData);
    if (err)
        NSLog(@"get file Length failed : %d", (int)err);
    
    float returnValue = ioData;
    
    status = kKWFileUnitStatus_Stop;
    
    return returnValue;
}

-(void)playWithTime:(float)time {
    switch (status) {
        case kKWFileUnitStatus_Play:
        case kKWFileUnitStatus_Pause:
            return;
            break;
            
        case kKWFileUnitStatus_Stop:
            [self loadFileWithURL:currentURL];
            break;
            
        default:
            break;
    }
    
    
    
    OSStatus err = noErr;
    
    UInt64 nPackets;
    UInt32 propsize = sizeof(nPackets);
    err = AudioFileGetProperty(fileID, kAudioFilePropertyAudioDataPacketCount, &propsize, &nPackets);
    if (err)
        NSLog(@"get packet count failed : %d", (int)err);
    
    
    rgn.mTimeStamp.mFlags = kAudioTimeStampSampleTimeValid;
    rgn.mTimeStamp.mSampleTime = 0;
    rgn.mCompletionProc = NULL;
    rgn.mCompletionProcUserData = NULL;
    rgn.mAudioFile = fileID;
    rgn.mLoopCount = 0;
    rgn.mStartFrame = time * 44100;
    rgn.mFramesToPlay = (UInt32)(nPackets * inputFormat.mFramesPerPacket);
    
    err = AudioUnitSetProperty(self.audioUnit, kAudioUnitProperty_ScheduledFileRegion, kAudioUnitScope_Global, 0,&rgn, sizeof(rgn));
    if (err)
        NSLog(@"set scheduled file region failed : %d", (int)err);
    
    UInt32 defaultVal = 0;
    err = AudioUnitSetProperty(self.audioUnit, kAudioUnitProperty_ScheduledFilePrime, kAudioUnitScope_Global, 0, &defaultVal, sizeof(defaultVal));
    if (err)
        NSLog(@"audio file Prime scheduled failed : %d", (int)err);
    
    // tell the file player AU when to start playing (-1 sample time means next render cycle)
    lastTimeStamp.mFlags = kAudioTimeStampSampleTimeValid;
    err = AudioUnitSetProperty(self.audioUnit, kAudioUnitProperty_ScheduleStartTimeStamp, kAudioUnitScope_Global, 0, &lastTimeStamp, sizeof(lastTimeStamp));
    if (err)
        NSLog(@"audioUnit set property for start time stamp failed : %d", (int)err);
    
    
    status = kKWFileUnitStatus_Play;
}

-(void)pause {
    
}

-(void)stop {
    OSStatus err = noErr;
    err = AudioUnitReset(self.audioUnit, kAudioUnitScope_Global, 0);
    if (err)
        NSLog(@"reset file unit failed : %d", (int)err);
    
    status = kKWFileUnitStatus_Stop;
}


-(float)getCurrentTime {
    float returnValue = 0;
    OSStatus err = noErr;
    
    AudioTimeStamp currentTimeStamp = {};
    UInt32 size = sizeof(currentTimeStamp);
    err = AudioUnitGetProperty(self.audioUnit,
                               kAudioUnitProperty_CurrentPlayTime, kAudioUnitScope_Global, 0, &currentTimeStamp, &size);
    if (err)
        NSLog(@"audio unit get property - current play time failed : %d", (int)err);
    
    returnValue = currentTimeStamp.mSampleTime / 44100;
//    NSLog(@"current file time : %0.2f", returnValue);
    
    return returnValue;
}

-(BOOL)isPlay {
    if (status == kKWFileUnitStatus_Play)
        return  YES;
    else
        return NO;
}

@end
