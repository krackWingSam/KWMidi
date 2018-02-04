//
//  KWAudioUnit.m
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "KWAudioUnit.h"

@implementation KWAudioUnit

-(id)initWithType:(kKWAudioUnitType)type {
    if (self = [super init]) {
        OSStatus err = noErr;
        
        _type = type;
        
        AudioComponentDescription desc;
        desc.componentManufacturer = kAudioUnitManufacturer_Apple;
        desc.componentFlags = 0;
        desc.componentFlagsMask = 0;
        
        switch (_type) {
            case kKWAudioUnitType_Output:
                desc.componentType = kAudioUnitType_Output;
                desc.componentSubType = kAudioUnitSubType_DefaultOutput;
                break;
                
            case kKWAudioUnitType_Mic:
                desc.componentType = kAudioUnitType_Output;
                desc.componentSubType = 'rioc';
                break;
                
            case kKWAudioUnitType_Mixer:
                desc.componentType = kAudioUnitType_Mixer;
                desc.componentSubType = kAudioUnitSubType_MultiChannelMixer;
                break;
                
            case kKWAudioUnitType_Sampler:
                desc.componentType = kAudioUnitType_MusicDevice;
                desc.componentSubType = kAudioUnitSubType_Sampler;
                break;
                
            case kKWAudioUnitType_EQ:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_NBandEQ;
                break;
                
            case kKWAudioUnitType_Reverb:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = 'rvb2';
                break;
                
            case kKWAudioUnitType_File:
                desc.componentType = kAudioUnitType_Generator;
                desc.componentSubType = kAudioUnitSubType_AudioFilePlayer;
                break;
                
            case kKWAudioUnitType_PeakLimiter:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_PeakLimiter;
                break;
                
            case kKWAudioUnitType_Compressor:
                desc.componentType = kAudioUnitType_Effect;
                desc.componentSubType = kAudioUnitSubType_DynamicsProcessor;
                break;
                
            case kKWAudioUnitType_Converter:
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

-(void)connectAudioUnit:(KWAudioUnit *)unit withDestinationNumber:(UInt32)destinationNumber {
    OSStatus err = noErr;
    
    AudioUnit sourceUnit = _audioUnit;
    AudioUnit destUnit = [unit audioUnit];
    
    AudioUnitConnection connection = {};
    connection.sourceAudioUnit = sourceUnit;
    if (_type == kKWAudioUnitType_Mic)
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
