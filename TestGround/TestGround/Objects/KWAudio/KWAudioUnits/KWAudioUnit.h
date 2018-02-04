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
    kKWAudioUnitType_Output,
    kKWAudioUnitType_Mic,
    kKWAudioUnitType_Mixer,
    kKWAudioUnitType_Sampler,
    kKWAudioUnitType_Reverb,
    kKWAudioUnitType_EQ,
    kKWAudioUnitType_File,
    kKWAudioUnitType_PeakLimiter,
    kKWAudioUnitType_Compressor,
    kKWAudioUnitType_Converter,
} kKWAudioUnitType;

@interface KWAudioUnit : NSObject

-(id)initWithType:(kKWAudioUnitType)type;
-(void)connectAudioUnit:(KWAudioUnit *)unit withDestinationNumber:(UInt32)destinationNumber;
-(void)initializeAudioUnit;
-(void)uninitialize;

@property (readonly)kKWAudioUnitType type;
@property (readonly)AudioUnit audioUnit;
@property (readonly)BOOL isInit;

@end
