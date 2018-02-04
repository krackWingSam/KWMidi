//
//  FRMidiDeviceManager.h
//  TestSampler
//
//  Created by askstory on 2018. 1. 25..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>
#import "KWMidiDevice.h"

@interface KWMidiDeviceManager : NSObject

+(NSArray *)getMidiDevices;
+(NSArray *)getUSBMidiDevices;
+(MIDIUniqueID)getFirstSourceUniqueIDWithDeviceDictionary:(NSDictionary *)dic;

@end
