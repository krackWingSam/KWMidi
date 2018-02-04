//
//  MidiDeviceController.h
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KWMidiDeviceManager.h"

@interface MidiDeviceController : NSObject

+(NSArray *)getAllMidiDevices;

@end
