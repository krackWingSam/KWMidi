//
//  FRMidiDeviceManager.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 25..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "KWMidiDeviceManager.h"

@interface KWMidiDeviceManager () {
    
}

@end


@implementation KWMidiDeviceManager

+(NSArray *)getMidiDevices {
    ItemCount numOfDevices = MIDIGetNumberOfDevices();
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];;
    
    for (int i = 0; i < numOfDevices; i++) {
        MIDIDeviceRef midiDevice = MIDIGetDevice(i);
//        NSDictionary *midiProperties;
        CFPropertyListRef properties = NULL;
        
        MIDIObjectGetProperties(midiDevice, &properties, YES);
        [tempArray addObject:(__bridge id _Nonnull)(properties)];
    }
    return [[NSArray alloc] initWithArray:tempArray];
}

+(NSArray *)getUSBMidiDevices {
    NSArray *devices = [KWMidiDeviceManager getMidiDevices];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (int i=0 ; i<devices.count ; i++) {
        NSDictionary *tempDic = [devices objectAtIndex:i];
        if ([tempDic objectForKey:@"USBLocationID"] != nil)
            [tempArray addObject:tempDic];
    }
    
    return [[NSArray alloc] initWithArray:tempArray];
}

+(MIDIUniqueID)getFirstSourceUniqueIDWithDeviceDictionary:(NSDictionary *)dic {
    NSArray *entities = [dic objectForKey:@"entities"];
    NSArray *sources = [[entities firstObject] objectForKey:@"sources"];
    MIDIUniqueID uniqueID = (MIDIUniqueID)[(NSNumber *)[[sources firstObject] objectForKey:@"uniqueID"] integerValue];
    
    return uniqueID;
}


@end
