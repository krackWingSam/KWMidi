//
//  MidiDeviceController.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "MidiDeviceController.h"

@implementation MidiDeviceController

+(KWMidiDevice *)getFirstDeviceWithCallback:(void *)callback withSamplerUnit:(id)samplerUnit {
    NSArray *devices = [KWMidiDeviceManager getUSBMidiDevices];
    NSDictionary *firstDic = [devices firstObject];
    
    KWMidiDevice *device = [[KWMidiDevice alloc] init];
    MIDIUniqueID uniqueID = [KWMidiDeviceManager getFirstSourceUniqueIDWithDeviceDictionary:firstDic];
    [device setup:uniqueID withCallback:callback withProcRef:samplerUnit];
    
    return device;
}

@end
