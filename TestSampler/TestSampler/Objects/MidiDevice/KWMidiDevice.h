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

-(void)setup:(MIDIUniqueID)uniqueID withCallback:(void *)callback withProcRef:(id)procRef;

@end
