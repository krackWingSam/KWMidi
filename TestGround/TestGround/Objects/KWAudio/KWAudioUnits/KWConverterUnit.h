//
//  FRConverterUnit.h
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 26..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "KWAudioUnit.h"

typedef enum : NSUInteger {
    kKWConverterType_Input,
    kKWConverterType_Output,
} kKWConverterType;

@interface KWConverterUnit : KWAudioUnit

-(id)initWithType:(kKWConverterType)type;


@end
