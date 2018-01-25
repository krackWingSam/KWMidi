//
//  FRCompressor.m
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 26..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRCompressor.h"
#import "FRConverterUnit.h"

@interface FRCompressor () {
    
}

@end

@implementation FRCompressor

-(id)init {
    if (self = [super initWithType:kFRAudioUnitType_Compressor]) {
        //set compress setting
        [self setParameterWithID:0 withValue:-20];
        [self setParameterWithID:1 withValue:7.0f];
        [self setParameterWithID:2 withValue:2.00];
  //    [self setParameterWithID:3 withValue:-20];  //don't use this id
        [self setParameterWithID:4 withValue:0.0010];
        [self setParameterWithID:5 withValue:0.05];
        [self setParameterWithID:6 withValue:5];
    }
    return self;
}


-(void)setParameterWithID:(int)paramID withValue:(Float32)value {
    if (paramID == 3)
        NSLog(@"DO NOT USE THIS ID.");      //ERROR LOG
    
    OSStatus err = noErr;
    err = AudioUnitSetParameter(self.audioUnit, paramID, kAudioUnitScope_Global, 0, value, 0);
    if (err)
        NSLog(@"set param with value failed id : %d, error : %d", (int)paramID, (int)err);
}

@end
