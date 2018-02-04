//
//  FRMixerUnit.h
//  TestCase_AudioController
//
//  Created by 상우 강 on 2016. 5. 27..
//  Copyright © 2016년 상우 강. All rights reserved.
//


#define MIXER_MAX_CHANNEL 30
#define MIXER_AUDIO_CHANNEL 1

#import "KWAudioUnit.h"

@interface KWMixerUnit : KWAudioUnit

-(void)setMixerVolume:(Float32)volume withChannel:(UInt32)channel;
-(void)setMixerOutputVolume:(Float32)volume;

-(float)getMixerVolumeWithChannelNumber:(UInt32)channel;

@end
