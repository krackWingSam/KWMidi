//
//  KWMidiDevice.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "KWMidiDevice.h"

@interface KWMidiDevice () {
    MIDIClientRef midiClient;
}

@end


@implementation KWMidiDevice

-(void)setup:(MIDIUniqueID)uniqueID withCallback:(void *)callback withProcRef:(id)procRef {
    OSStatus result;
    
    result = MIDIClientCreate(CFSTR("MIDI client"), NULL, NULL, &midiClient);
    if (result != noErr) {
        NSLog(@"Error creating MIDI client: %d", (int)result);
        return;
    }
    
    MIDIPortRef inputPort;
    result = MIDIInputPortCreate(midiClient, CFSTR("Input"), callback, (__bridge void * _Nullable)(procRef), &inputPort);
    
    MIDIObjectRef endPoint;
    MIDIObjectType foundObj;
    
    result = MIDIObjectFindByUniqueID(uniqueID, &endPoint, &foundObj);
    
    result = MIDIPortConnectSource(inputPort, endPoint, NULL);
}



@end
