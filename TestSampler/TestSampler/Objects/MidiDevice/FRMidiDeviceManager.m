//
//  FRMidiDeviceManager.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 25..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "FRMidiDeviceManager.h"
#import <CoreMIDI/CoreMIDI.h>

@interface FRMidiDeviceManager () {
    
}

@end


@implementation FRMidiDeviceManager

+(void)getMidiDevices {
    ItemCount numOfDevices = MIDIGetNumberOfDevices();
    
    for (int i = 0; i < numOfDevices; i++) {
        MIDIDeviceRef midiDevice = MIDIGetDevice(i);
        NSDictionary *midiProperties;
        
        MIDIObjectGetProperties(midiDevice, (CFPropertyListRef *)midiProperties, YES);
        NSLog(@"Midi properties: %d \n %@", i, midiProperties);
    }
}

-(void)setupMidi {
    
    MIDIClientRef midiClient;
    
    OSStatus result;
    
    result = MIDIClientCreate(CFSTR("MIDI client"), NULL, NULL, &midiClient);
    if (result != noErr) {
        NSLog(@"Error creating MIDI client: %d", (int)result);
        return;
    }
    
    MIDIPortRef inputPort;
    result = MIDIInputPortCreate(midiClient, CFSTR("Input"), midiInputCallback, NULL, &inputPort);
    
    
    return;
}


#pragma - mark callback
static void midiInputCallback (const MIDIPacketList *list, void *procRef, void *srcRef) {
    NSLog(@"midiInputCallback was called");
}

@end
