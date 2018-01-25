    //
//  FRAudioUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRAudioUnit.h"

@implementation FRAudioUnit

-(id)initWithType:(kFRAudioUnitType)type {
    if (self = [super init]) {
        OSStatus err = noErr;
        
        _type = type;
        
        AudioComponentDescription desc;
        desc.componentManufacturer = kAudioUnitManufacturer_Apple;
        desc.componentFlags = 0;
        desc.componentFlagsMask = 0;
        
        switch (_type) {
            case kFRAudioUnitType_Output:
                desc.componentType = kAudioUnitType_Output;
                desc.componentSubType = kAudioUnitSubType_DefaultOutput;
                break;
                
            case kFRAudioUnitType_Mic:
                desc.componentType = kAudioUnitType_Output;
                desc.componentSubType = 'rioc';
                break;
                
            case kFRAudioUnitType_Mixer:
                desc.componentType = kAudioUnitType_Mixer;
                desc.componentSubType = kAudioUnitSubType_MultiChannelMixer;
                break;
                
            case kFRAudioUnitType_Sampler:
                desc.componentType = kAudioUnitType_MusicDevice;
                desc.componentSubType = kAudioUnitSubType_Sampler;
                break;
                
            case kFRAudioUnitType_EQ:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_NBandEQ;
                break;
                
            case kFRAudioUnitType_Reverb:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = 'rvb2';
                break;
                
            case kFRAudioUnitType_File:
                desc.componentType = kAudioUnitType_Generator;
                desc.componentSubType = kAudioUnitSubType_AudioFilePlayer;
                break;
                
            case kFRAudioUnitType_PeakLimiter:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_PeakLimiter;
                break;
                
            case kFRAudioUnitType_Compressor:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_DynamicsProcessor;
                break;
                
            case kFRAudioUnitType_Converter:
                desc.componentType = kAudioUnitType_FormatConverter;
                desc.componentSubType = kAudioUnitSubType_AUConverter;
                
            default:
                break;
        }
        
        AudioComponent comp = AudioComponentFindNext(NULL, &desc);
        err = AudioComponentInstanceNew(comp, &_audioUnit);
        if (err)
            NSLog(@"New Audio component instance failed : %d", (int)err);
        
        _isInit = NO;
    }
    
    return self;
}

-(void)connectAudioUnit:(FRAudioUnit *)unit withDestinationNumber:(UInt32)destinationNumber {
    OSStatus err = noErr;
    
    AudioUnit sourceUnit = _audioUnit;
    AudioUnit destUnit = [unit audioUnit];
    
    AudioUnitConnection connection = {};
    connection.sourceAudioUnit = sourceUnit;
    if (_type == kFRAudioUnitType_Mic)
        connection.sourceOutputNumber = 1;
    else
        connection.sourceOutputNumber = 0;
    connection.destInputNumber = destinationNumber;
    
    err = AudioUnitSetProperty(destUnit, kAudioUnitProperty_MakeConnection, kAudioUnitScope_Input, 0, &connection, sizeof(connection));
    if (err)
        NSLog(@"make audiounit connection failed : %d", (int)err);
}

-(void)initializeAudioUnit {
    if (_isInit)
        return;
    
    OSStatus err = noErr;
    AudioUnit audioUnit = [self audioUnit];
    err = AudioUnitInitialize(audioUnit);
    if (err)
        NSLog(@"Audio Unit initialized failed : %d", (int)err);
    else
        _isInit = YES;
}

-(void)uninitialize {
    OSStatus err = noErr;
    err = AudioUnitUninitialize(self.audioUnit);
    if (err)
        NSLog(@"audioUnit un initialize failed : %d", (int)err);
    else
        _isInit = NO;
}


@end
