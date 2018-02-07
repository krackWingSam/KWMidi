//
//  AddChannelViewController.m
//  TestGround
//
//  Created by askstory on 2018. 2. 4..
//  Copyright © 2018년 Fermata. All rights reserved.
//

#import "AddChannelViewController.h"
#import "KWAudio.h"
#import "KWMidiDeviceManager.h"

@interface AddChannelViewController () <NSTableViewDelegate, NSTableViewDataSource> {
    IBOutlet NSTableView *table_Device;
    IBOutlet NSTableView *table_Sampler;
    
    IBOutlet NSTextField *tf_Channel;
    IBOutlet NSTextField *tf_Device;
    IBOutlet NSTextField *tf_Sampler;
    
    //tableview data array
    NSArray *devices;
    NSArray *samplers;
}

@end

@implementation AddChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self getDeviceArray];
    [self getSamplerArray];
}

-(void)getDeviceArray {
    devices = [KWMidiDeviceManager getUSBMidiDevices];
    
    [table_Device reloadData];
}

-(void)getSamplerArray {
    samplers = [KWAudioUtility getAUPresetInMainBundle];
    
    [table_Sampler reloadData];
}


#pragma mark - NSTableViewDelegate
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tableView = [notification object];
    
    if (tableView == table_Device)
        [tf_Device setStringValue:[[devices objectAtIndex:[table_Device selectedRow]] objectForKey:@"name"]];
    else if (tableView == table_Sampler)
        [tf_Sampler setStringValue:[samplers objectAtIndex:[table_Sampler selectedRow]]];
}



#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSInteger value = 0;
    
    if (tableView == table_Device) {
        NSArray *devices = [KWMidiDeviceManager getUSBMidiDevices];
        value = [devices count];
    }
    else if (tableView == table_Sampler) {
        NSArray *samplers = [KWAudioUtility getAUPresetInMainBundle];
        value = [samplers count];
    }
    return value;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row; {
    NSString *identifier = @"";
    NSTextFieldCell *cell;
    
    if (tableView == table_Device)
        identifier = @"Device";
    else if (tableView == table_Sampler)
        identifier = @"Sampler";
    
    cell = [self makeTableCellViewWithTableView:tableView WithIdentifier:identifier];
    
    if (tableView == table_Device) {
        NSDictionary *dic = [devices objectAtIndex:row];
        NSString *value = [[NSString alloc] initWithString:[dic objectForKey:@"name"]];
        [cell setStringValue:value];
    }
    else if (tableView == table_Sampler) {
        NSString *value = [samplers objectAtIndex:row];
        [cell setStringValue:value];
    }
    
    return cell;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSLog(@"");
}

-(NSTextFieldCell *)makeTableCellViewWithTableView:(NSTableView *)tableView WithIdentifier:(NSString *)identifier {
    NSTextFieldCell *cell = (NSTextFieldCell *)[tableView makeViewWithIdentifier:identifier owner:nil];
    if (!cell) {
        cell = [[NSTextFieldCell alloc] init];
        [cell setIdentifier:identifier];
    }
    
    return cell;
}



#pragma mark - IBActions
-(IBAction)action_Cancel:(id)sender {
    [self.view.window close];
}

-(IBAction)action_Confirm:(id)sender {
    if ([[tf_Channel stringValue] isEqualToString:@""] || [[tf_Channel stringValue] length] == 0) {
        NSLog(@"Alert! should fill the channel name");
        return;
    }
    
}


@end
