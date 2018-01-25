//
//  FRSamplerUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRAudioUnit.h"

@interface FRSamplerUnit : FRAudioUnit

-(id)initWithPresetName:(NSString *)presetName;

-(void)onMidiSignal:(UInt32)noteNumber withVelocity:(UInt32)velocity;
-(void)offMidiSignal:(UInt32)noteNumber withVelocity:(UInt32)velocity;

-(void)testMidiSignal_start;
-(void)testMidiSignal_End;

@end
