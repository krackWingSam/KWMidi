//
//  KWMidiDevice.h
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMIDI/CoreMIDI.h>

@interface KWMidiDevice : NSObject

-(id)initWithDictionary:(NSDictionary *)dic;
-(id)initWithDictionary:(NSDictionary *)dic withCallback:(void *)callback withProcRef:(void *)procRef;

-(OSStatus)setupMidiDevice;


@property (readonly) NSDictionary *deviceDic;
@property (readonly) NSArray *subDevices;
@property (readonly) MIDIUniqueID uniqueID;
@property (readonly) MIDIClientRef midiClient;
@property void *procRef;
@property void *callback;

@end
