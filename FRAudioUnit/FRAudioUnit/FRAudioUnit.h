//
//  FRAudioUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

typedef enum : NSUInteger {
    kFRAudioUnitType_Output,
    kFRAudioUnitType_Mic,
    kFRAudioUnitType_Mixer,
    kFRAudioUnitType_Sampler,
    kFRAudioUnitType_Reverb,
    kFRAudioUnitType_EQ,
    kFRAudioUnitType_File,
    kFRAudioUnitType_PeakLimiter,
    kFRAudioUnitType_Compressor,
    kFRAudioUnitType_Converter,
} kFRAudioUnitType;

@interface FRAudioUnit : NSObject

-(id)initWithType:(kFRAudioUnitType)type;
-(void)connectAudioUnit:(FRAudioUnit *)unit withDestinationNumber:(UInt32)destinationNumber;
-(void)initializeAudioUnit;
-(void)uninitialize;

@property (readonly)kFRAudioUnitType type;
@property (readonly)AudioUnit audioUnit;
@property (readonly)BOOL isInit;

@end
