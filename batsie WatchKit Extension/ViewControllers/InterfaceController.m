//
//  InterfaceController.m
//  batsie WatchKit Extension
//
//  Created by Leptos on 1/16/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import "InterfaceController.h"
#import "StandardCell.h"

#import "../../BatteryCenter/BCBatteryDeviceController.h"

#if TARGET_OS_SIMULATOR
#   define SYSTEM_RUNTIME_ROOT "/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/watchOS.simruntime/Contents/Resources/RuntimeRoot"
#else
#   define SYSTEM_RUNTIME_ROOT ""
#endif

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSBundle *batteryBundle = [NSBundle bundleWithPath:@(SYSTEM_RUNTIME_ROOT "/System/Library/PrivateFrameworks/BatteryCenter.framework")];
    NSError *loadErr = nil;
    if (![batteryBundle loadAndReturnError:&loadErr]) {
        NSLog(@"%@", loadErr);
    }
    BCBatteryDeviceController *batteryDeviceController = [NSClassFromString(@"BCBatteryDeviceController") sharedInstance];
    
    NSString *notifName = batteryDeviceController.connectedDevicesDidChangeNotificationName;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reloadData) name:notifName object:nil];
    
    [self reloadData];
}

- (void)reloadData {
    BCBatteryDeviceController *batteryDeviceController = [NSClassFromString(@"BCBatteryDeviceController") sharedInstance];
    NSArray<BCBatteryDevice *> *models = batteryDeviceController.connectedDevices;
    
    [self.table setNumberOfRows:models.count withRowType:@"BatteryInfo"];
    [models enumerateObjectsUsingBlock:^(BCBatteryDevice *model, NSUInteger idx, BOOL *stop) {
        StandardCell *cell = [self.table rowControllerAtIndex:idx];
        cell.imageView.image = model.glyph;
        cell.titleLabel.text = model.name;
        cell.detailLabel.text = [NSString stringWithFormat:@"%@%@%%", model.approximatesPercentCharge ? @"~ " : @"", @(model.percentCharge)];
        cell.detailLabel.textColor = model.charging ? UIColor.greenColor : (model.lowBattery ? UIColor.redColor : UIColor.whiteColor);
    }];
}

- (void)willActivate {
    [super willActivate];
    
    [self reloadData];
}

@end
