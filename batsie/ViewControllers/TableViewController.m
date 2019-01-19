//
//  TableViewController.m
//  batsie
//
//  Created by Leptos on 1/16/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"

#import "../../BatteryCenter/BCBatteryDeviceController.h"

#if TARGET_OS_SIMULATOR
#   define SYSTEM_RUNTIME_ROOT "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot"
#else
#   define SYSTEM_RUNTIME_ROOT ""
#endif

@implementation TableViewController {
    BCBatteryDeviceController *_batteryDeviceController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *batteryBundle = [NSBundle bundleWithPath:@(SYSTEM_RUNTIME_ROOT "/System/Library/PrivateFrameworks/BatteryCenter.framework")];
    NSError *loadErr = nil;
    if ([batteryBundle loadAndReturnError:&loadErr]) {
        _batteryDeviceController = [NSClassFromString(@"BCBatteryDeviceController") sharedInstance];
        NSString *notifName = _batteryDeviceController.connectedDevicesDidChangeNotificationName;
        [NSNotificationCenter.defaultCenter addObserver:self.tableView selector:@selector(reloadData) name:notifName object:nil];
    } else {
        /* Show error with UIAlertViewController? */
        NSLog(@"%@", loadErr);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(section == 0);
    NSParameterAssert(tableView == self.tableView);
    return _batteryDeviceController.connectedDevices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(tableView == self.tableView);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BatteryCell"];
    BCBatteryDevice *model = _batteryDeviceController.connectedDevices[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%%", model.approximatesPercentCharge ? @"~ " : @"",  @(model.percentCharge)];
    cell.detailTextLabel.textColor = model.charging ? UIColor.greenColor : (model.lowBattery ? UIColor.redColor : UIColor.whiteColor);
    cell.imageView.image = model.glyph;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(tableView == self.tableView);
    
    DetailViewController *detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    detailController.batteryDevice = _batteryDeviceController.connectedDevices[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
