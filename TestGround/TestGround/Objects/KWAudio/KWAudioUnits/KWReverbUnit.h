//
//  FRReverbUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "KWAudioUnit.h"

typedef enum : NSUInteger {
    KWReverbParamID_DriWetMix           = 0,
    KWReverbParamID_Gain                = 1,
    KWReverbParamID_MinDelayTime        = 2,
    KWReverbParamID_MaxDelayTime        = 3,
    KWReverbParamID_DecayTimeAt0Hz      = 4,
    KWReverbParamID_DecayTimeAtNyquist  = 5,
    KWReverbParamID_RandomReflections   = 6,
} KWReverbParamID;

@interface KWReverbUnit : KWAudioUnit

-(void)setReverbParameter:(KWReverbParamID)paramID withValue:(Float32)value;

@end
