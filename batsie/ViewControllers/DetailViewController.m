//
//  DetailViewController.m
//  batsie
//
//  Created by Leptos on 1/17/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController {
    NSArray<NSString *> *_rawSourceKeys;
    NSDictionary<NSString *, NSString *> *_rawSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.batteryDevice = _batteryDevice;
}

- (NSString *)_localizedStringForBool:(BOOL)b {
    return b ? @"True" : @"False";
}

- (void)setBatteryDevice:(BCBatteryDevice *)batteryDevice {
    _batteryDevice = batteryDevice;
    
    self.title = batteryDevice.name;
    self.imageView.image = batteryDevice.glyph;
    
    NSMutableDictionary<NSString *, NSString *> *source = [NSMutableDictionary dictionary];
    
    source[@"Name"] = batteryDevice.name;
    source[@"Identifier"] = batteryDevice.identifier;
    source[@"Match Identifier"] = batteryDevice.matchIdentifier;
    if (@available(iOS 9.3, *)) {
        source[@"Group Name"] = batteryDevice.groupName;
    }
    
    if (@available(iOS 11.4, *)) {
        source[@"Accessory Identifier"] = batteryDevice.accessoryIdentifier;
        source[@"Active battery saver mode"] = [self _localizedStringForBool:batteryDevice.batterySaverModeActive];
    }
    
    if (@available(iOS 10.0, *)) {
        source[@"Uses Approximates Percent Charge"] = [self _localizedStringForBool:batteryDevice.approximatesPercentCharge];
    }
    
    source[@"Percent Charge"] = @(batteryDevice.percentCharge).stringValue;
    source[@"Charging"] = [self _localizedStringForBool:batteryDevice.charging];
    
    if (@available(iOS 9.1, *)) {
        source[@"Low Battery"] = [self _localizedStringForBool:batteryDevice.lowBattery];
    }
    source[@"Fake"] = [self _localizedStringForBool:batteryDevice.fake];
    source[@"Internal"] = [self _localizedStringForBool:batteryDevice.internal];
    source[@"Connected"] = [self _localizedStringForBool:batteryDevice.connected];
    
    _rawSourceKeys = source.allKeys; /* Ideally this could be in some logical list */
    _rawSource = [source copy];
    
    if (self.viewLoaded)  {
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(section == 0);
    NSParameterAssert(tableView == self.tableView);
    return _rawSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(tableView == self.tableView);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    NSString *key = _rawSourceKeys[indexPath.row];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = _rawSource[key];
    
    return cell;
}

@end
