//
//  FRCompressor.h
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 26..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "KWAudioUnit.h"

@interface KWCompressor : KWAudioUnit

-(void)setParameterWithID:(int)paramID withValue:(Float32)value;

@end
