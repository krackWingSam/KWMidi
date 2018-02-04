//
//  MidiDeviceController.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "MidiDeviceController.h"

@implementation MidiDeviceController

+(NSArray *)getAllMidiDevices {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSArray *devicesDictionary = [KWMidiDeviceManager getUSBMidiDevices];
    for (NSDictionary *dic in devicesDictionary) {
        KWMidiDevice *device = [[KWMidiDevice alloc] initWithDictionary:dic];
        [tempArray addObject:device];
    }
    
    return [[NSArray alloc] initWithArray:tempArray];
}

@end
