//
//  FRConverterUnit.h
//  StudioRecording
//
//  Created by 상우 강 on 2016. 7. 26..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRAudioUnit.h"

typedef enum : NSUInteger {
    kFRConverterType_Input,
    kFRConverterType_Output,
} kFRConverterType;

@interface FRConverterUnit : FRAudioUnit

-(id)initWithType:(kFRConverterType)type;


@end
