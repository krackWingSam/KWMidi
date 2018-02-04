//
//  KWMidiDevice.m
//  TestSampler
//
//  Created by askstory on 2018. 1. 26..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "KWMidiDevice.h"

@interface KWMidiDevice () {
}

@end


@implementation KWMidiDevice

-(id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        NSMutableArray *sources = [[NSMutableArray alloc] initWithArray:[self getSourcesInDictionary:dic]];
        NSDictionary *firstSource = [sources firstObject];
        [sources removeObject:firstSource];
        
        //prepare main device
        MIDIUniqueID uniqueID = [self getUniqueIDInSource:firstSource];
        [self prepareMidiDeviceWithUniqueID:uniqueID withMidiClient:_midiClient];
        
        //prepare sub devices
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in sources) {
            NSDictionary *subDeviceDic = @{@"entities":@{@"sources":dic}};
            KWMidiDevice *subDevice = [[KWMidiDevice alloc] initWithDictionary:subDeviceDic];
            [tempArray addObject:subDevice];
        }
        _subDevices = [[NSArray alloc] initWithArray:tempArray];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dic withCallback:(void *)callback withProcRef:(void *)procRef {
    if (self = [[KWMidiDevice alloc] initWithDictionary:dic]) {
        [self setCallback:callback];
        [self setProcRef:procRef];
        [self setupMidiDevice];
    }
    return self;
}


#pragma mark - private
-(NSArray *)getSourcesInDictionary:(NSDictionary *)dic {
    NSArray *entities = [dic objectForKey:@"entities"];
    NSArray *sources = [[entities firstObject] objectForKey:@"sources"];
    
    return sources;
}

-(MIDIUniqueID)getUniqueIDInSource:(NSDictionary *)source {
    MIDIUniqueID uniqueID = (MIDIUniqueID)[(NSNumber *)[source objectForKey:@"uniqueID"] integerValue];
    return uniqueID;
}

-(void)prepareMidiDeviceWithUniqueID:(MIDIUniqueID)uniqueID withMidiClient:(MIDIClientRef)clientRef {
    OSStatus result;
    
    result = MIDIClientCreate(CFSTR("MIDI client"), NULL, NULL, &clientRef);
    if (result != noErr) {
        NSLog(@"Error creating MIDI client: %d", (int)result);
        return;
    }
    _uniqueID = uniqueID;
}


#pragma mark - public
-(OSStatus)setupMidiDevice {
    OSStatus result;
    MIDIPortRef inputPort;
    result = MIDIInputPortCreate(_midiClient, CFSTR("Input"), _callback, _procRef, &inputPort);
    if (result)
        return result;
    
    MIDIObjectRef endPoint;
    MIDIObjectType foundObj;

    result = MIDIObjectFindByUniqueID(_uniqueID, &endPoint, &foundObj);
    if (result)
        return result;

    result = MIDIPortConnectSource(inputPort, endPoint, NULL);
    return result;
}



//-(void)setup:(MIDIUniqueID)uniqueID withCallback:(void *)callback withProcRef:(id)procRef {
//    OSStatus result;
//
//    result = MIDIClientCreate(CFSTR("MIDI client"), NULL, NULL, &midiClient);
//    if (result != noErr) {
//        NSLog(@"Error creating MIDI client: %d", (int)result);
//        return;
//    }
//
//    MIDIPortRef inputPort;
//    result = MIDIInputPortCreate(midiClient, CFSTR("Input"), callback, (__bridge void * _Nullable)(procRef), &inputPort);
//
//    MIDIObjectRef endPoint;
//    MIDIObjectType foundObj;
//
//    result = MIDIObjectFindByUniqueID(uniqueID, &endPoint, &foundObj);
//
//    result = MIDIPortConnectSource(inputPort, endPoint, NULL);
//}



@end
