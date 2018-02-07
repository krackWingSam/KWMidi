//
//  KWAudioUtility.m
//  TestGround
//
//  Created by askstory on 2018. 2. 4..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "KWAudioUtility.h"

@implementation KWAudioUtility

+(NSArray *)getAUPresetInMainBundle {
    NSArray *presets = [[NSBundle mainBundle] pathsForResourcesOfType:@"aupreset" inDirectory:nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSString *path in presets) {
        NSArray *separated = [path componentsSeparatedByString:@"/"];
        NSString *fullName = [separated lastObject];
        NSString *fileName = [[fullName componentsSeparatedByString:@"."] firstObject];
        [tempArray addObject:fileName];
    }
    
    return [[NSArray alloc] initWithArray:tempArray];
}

@end
