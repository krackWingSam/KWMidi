//
//  FRReverbUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRAudioUnit.h"

typedef enum : NSUInteger {
    FRReverbParamID_DriWetMix           = 0,
    FRReverbParamID_Gain                = 1,
    FRReverbParamID_MinDelayTime        = 2,
    FRReverbParamID_MaxDelayTime        = 3,
    FRReverbParamID_DecayTimeAt0Hz      = 4,
    FRReverbParamID_DecayTimeAtNyquist  = 5,
    FRReverbParamID_RandomReflections   = 6,
} FRReverbParamID;

@interface FRReverbUnit : FRAudioUnit

-(void)setReverbParameter:(FRReverbParamID)paramID withValue:(Float32)value;

@end
