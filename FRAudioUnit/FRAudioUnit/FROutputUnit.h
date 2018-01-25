//
//  FROutputUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#define DEFAULT_SAMPLATE 44100

#import "FRAudioUnit.h"

@interface FROutputUnit : FRAudioUnit

-(void)setOutputVolume:(float)volume;

@end
