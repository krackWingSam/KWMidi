//
//  AudioController.h
//  TestSampler
//
//  Created by askstory on 2018. 1. 24..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KWAudioUnit/KWAudioUnit.h>

@interface AudioController : NSObject

-(void)initDefaultAudioUnits;

-(void)testMidiOn;
-(void)testMidiOff;

-(void)sendMidiOnWithNoteNumber:(UInt32)noteNumber withVelocity:(UInt32)velocity;
-(void)sendMidiOffWithNoteNumber:(UInt32)noteNumber withVelocity:(UInt32)velocity;

-(FRSamplerUnit *)getSamplerUnit;

@end
