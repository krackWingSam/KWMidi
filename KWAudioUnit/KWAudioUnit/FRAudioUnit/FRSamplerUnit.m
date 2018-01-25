//
//  FRSamplerUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//


//for midi sampler. use AUPreset
//preset must include main bundle
#import "FRSamplerUnit.h"

@interface FRSamplerUnit () {
    NSString *presetName;
}

@end

@implementation FRSamplerUnit
-(id)initWithPresetName:(NSString *)_presetName {
    if (self = [super initWithType:kFRAudioUnitType_Sampler]) {
        presetName = _presetName;
        [self loadPreset];
    }
    return self;
}

-(void)loadPreset {
    OSStatus err = noErr;
    NSString *presetPath = [[NSBundle mainBundle] pathForResource:presetName ofType:@"aupreset"];
    NSURL* presetURL = [NSURL fileURLWithPath:presetPath];
    NSData *propertyResourceData;
    NSDataReadingOptions DataReadingOptions = 0;
    NSError *errorCode;
    AudioUnit unit = [self audioUnit];
    
    propertyResourceData = [NSData dataWithContentsOfURL:presetURL options:DataReadingOptions error:&errorCode];
    
    CFPropertyListRef presetPropertyList;
    CFPropertyListFormat dataFormat;
    CFErrorRef errorRef;
    
    if (errorCode)
        NSLog(@"load preset error : %@", errorCode);
    else {
        presetPropertyList = CFPropertyListCreateWithData (
                                                           kCFAllocatorDefault,
                                                           (__bridge CFDataRef)propertyResourceData,
                                                           kCFPropertyListImmutable,
                                                           &dataFormat,
                                                           &errorRef
                                                           );
        
    NSDictionary *tempDic;
    if ([(__bridge id)presetPropertyList isKindOfClass:[NSDictionary class]])
        tempDic = (__bridge NSDictionary*)presetPropertyList;
    
    NSMutableDictionary *editDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    NSMutableDictionary *fileRefDic = [editDic objectForKey:@"file-references"];
    NSMutableDictionary *newFileRefDic = [[NSMutableDictionary alloc] init];
    
    //this line for replace % charactor
    for (NSString *key in fileRefDic) {
        NSString *strValue = [fileRefDic objectForKey:key];
        NSString *value = [strValue stringByReplacingOccurrencesOfString:@".caf" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
        NSString *newValue = [[NSBundle mainBundle] pathForResource:value ofType:@"caf"];
        if (newValue == nil) {
            //TODO: error handling
        }
        
        [newFileRefDic setObject:newValue forKey:key];
    }
    
    [editDic removeObjectForKey:@"file-references"];
    [editDic setObject:newFileRefDic forKey:@"file-references"];
    
    NSDictionary *newDic = [[NSDictionary alloc] initWithDictionary:editDic];
    editDic = nil;
    tempDic = nil;
    
    presetPropertyList = (__bridge CFPropertyListRef)newDic;
    UInt32 size = sizeof(presetPropertyList);
    
    if (presetPropertyList != 0) {
        err = AudioUnitSetProperty(unit, kAudioUnitProperty_ClassInfo, kAudioUnitScope_Global, 0, &presetPropertyList, size);
            if (err)
                NSLog(@"samplerUnit property list set failed : %d", (int)err);
            else
                NSLog(@"load preset complete : sampler-%@", presetName);
        }
    }
}

-(void)uninitialize {
    //do nothing
}

-(void)onMidiSignal:(UInt32)noteNumber withVelocity:(UInt32)velocity {
    OSStatus result = noErr;
    AudioUnit sampler = [self audioUnit];
    
    UInt32 noteCommand = 	0x9 << 4 | 0;
    result = MusicDeviceMIDIEvent(sampler, noteCommand, noteNumber, velocity, 0);
    if (result)
        NSLog(@"note command error : noteNumber - %d, code : %d", (unsigned int)noteNumber, (int)result);
}

-(void)offMidiSignal:(UInt32)noteNumber withVelocity:(UInt32)velocity {
    OSStatus result = noErr;
    AudioUnit sampler = [self audioUnit];
    
    UInt32 noteCommand = 	0x8 << 4 | 0;
    result = MusicDeviceMIDIEvent(sampler, noteCommand, noteNumber, velocity, 0);
    if (result)
        NSLog(@"note command error : noteNumber - %d, code : %d", (unsigned int)noteNumber, (int)result);
}

-(void)testMidiSignal_start {
    AudioUnit sampler = [self audioUnit];
    UInt32 noteCommand = 	0x9 << 4 | 0;
    OSStatus result = MusicDeviceMIDIEvent(sampler, noteCommand, 49, 127, 0);
    result = MusicDeviceMIDIEvent(sampler, noteCommand, 52, 127, 0);
    result = MusicDeviceMIDIEvent(sampler, noteCommand, 56, 127, 0);
    result = MusicDeviceMIDIEvent(sampler, noteCommand, 59, 127, 0);
    result = MusicDeviceMIDIEvent(sampler, noteCommand, 63, 127, 0);
    NSLog(@"test");
}

-(void)testMidiSignal_End {
    AudioUnit sampler = [self audioUnit];
    UInt32 noteCommand = 	0x8 << 4 | 0;
    MusicDeviceMIDIEvent(sampler, noteCommand, 49, 127, 0);
    MusicDeviceMIDIEvent(sampler, noteCommand, 52, 127, 0);
    MusicDeviceMIDIEvent(sampler, noteCommand, 56, 127, 0);
    MusicDeviceMIDIEvent(sampler, noteCommand, 59, 127, 0);
    MusicDeviceMIDIEvent(sampler, noteCommand, 63, 127, 0);
    NSLog(@"test");
}

@end
