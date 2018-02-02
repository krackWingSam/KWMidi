//
//  ViewController.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 19..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "ViewController.h"

#import "AudioController.h"
#import "MidiDeviceController.h"

@interface ViewController () {
    IBOutlet NSTextField *tf_Note;
    IBOutlet NSTextField *tf_Velocity;
    
    AudioController *ac;
    FRSamplerUnit *samplerUnit;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    ac = [[AudioController alloc] init];
    [ac initDefaultAudioUnits];
    samplerUnit = [ac getSamplerUnit];
    
    [self testMidiDevices];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(void)testMidiDevices {
    [MidiDeviceController getFirstDeviceWithCallback:midiInputCallback withSamplerUnit:samplerUnit];
}


#pragma - mark IBActions
-(IBAction)action_MidiTest:(id)sender {
    [ac testMidiOn];
}

-(IBAction)action_NoteON:(id)sender {
    UInt32 note = (UInt32)[[NSNumber numberWithInt:[tf_Note.stringValue intValue]] intValue];
    UInt32 velocity = (UInt32)[[NSNumber numberWithInt:[tf_Velocity.stringValue intValue]] intValue];
    
    [ac sendMidiOnWithNoteNumber:note withVelocity:velocity];
}

-(IBAction)action_NoteOff:(id)sender {
    UInt32 note = (UInt32)[[NSNumber numberWithInt:[tf_Note.stringValue intValue]] intValue];
    UInt32 velocity = (UInt32)[[NSNumber numberWithInt:[tf_Velocity.stringValue intValue]] intValue];
    
    [ac sendMidiOffWithNoteNumber:note withVelocity:velocity];
}



#pragma - mark callback
static void midiInputCallback (const MIDIPacketList *list, void *procRef, void *srcRef) {
    for (int i=0 ; i<list->numPackets ; i++) {
        MIDIPacket packet = list->packet[i];
        
        NSLog(@"prog : %d \t noteNumber : %d \t velocity : %d", packet.data[0], packet.data[1], packet.data[2]);
        
        if (packet.data[0] == 159)
            [(__bridge FRSamplerUnit *)procRef onMidiSignal:packet.data[1] withVelocity:packet.data[2]];
        else if (packet.data[0] == 191);
    }
}


@end
