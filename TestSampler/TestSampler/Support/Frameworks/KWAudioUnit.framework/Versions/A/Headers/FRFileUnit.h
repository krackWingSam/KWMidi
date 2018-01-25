//
//  FRFileUnit.h
//  IpodExport
//
//  Created by 상우 강 on 2016. 6. 7..
//  Copyright © 2016년 상우 강. All rights reserved.
//

#import "FRAudioUnit.h"

@interface FRFileUnit : FRAudioUnit

/*
 *  return file length
 */
-(float)loadFileWithURL:(NSURL *)url;

-(void)playWithTime:(float)time;
-(void)pause;
-(void)stop;

-(float)getCurrentTime;

-(BOOL)isPlay;

@end
