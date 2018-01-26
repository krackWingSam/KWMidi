//
//  ViewController.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 19..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "ViewController.h"

#import "AudioController.h"
#import "FRMidiDeviceManager.h"

@interface ViewController () {
    IBOutlet NSTextField *tf_Note;
    IBOutlet NSTextField *tf_Velocity;
    
    AudioController *ac;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self testMidiDevices];
    
    ac = [[AudioController alloc] init];
    [ac initDefaultAudioUnits];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

-(void)testMidiDevices {
    [FRMidiDeviceManager getMidiDevices];
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


@end
