//
//  DeviceInformationViewController.m
//  TestGround
//
//  Created by askstory on 2018. 2. 4..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "DeviceInformationViewController.h"
#import "KWMidiDeviceManager.h"

@interface DeviceInformationViewController () {
    IBOutlet NSTextView *textView;
}

@end

@implementation DeviceInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDeviceInformations];
}

-(void)loadDeviceInformations {
    NSArray *devices = [KWMidiDeviceManager getUSBMidiDevices];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in devices) {
        if (![[dic objectForKey:@"offline"] boolValue])
            [tempArray addObject:dic];
    }
    NSString *value = @"there was no devices";
    if ([tempArray count] > 0)
        value = [NSString stringWithFormat:@"%@", tempArray];
    [textView setString:value];
}


#pragma mark - IBActions
-(IBAction)action_Refresh:(id)sender {
    [self loadDeviceInformations];
}

@end
