//
//  FRMidiDeviceManager.h
//  TestSampler
//
//  Created by askstory on 2018. 1. 25..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRMidiDeviceManager : NSObject

+(void)getMidiDevices;

-(void)setupMidi;

@end
