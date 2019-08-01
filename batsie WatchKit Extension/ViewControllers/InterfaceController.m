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


@implementation InterfaceController {
    BCBatteryDeviceController *_batteryDeviceController;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    /* these are all good
     * DYLD_ROOT_PATH
     * SIMULATOR_ROOT
     * IPHONE_SIMULATOR_ROOT
     */
    const char *root = getenv("DYLD_ROOT_PATH") ?: "";
    NSString *batteryPath = [@(root) stringByAppendingString:@"/System/Library/PrivateFrameworks/BatteryCenter.framework"];
    
    NSBundle *batteryBundle = [NSBundle bundleWithPath:batteryPath];
    NSError *loadErr = nil;
    if ([batteryBundle loadAndReturnError:&loadErr]) {
        _batteryDeviceController = [NSClassFromString(@"BCBatteryDeviceController") sharedInstance];
        NSString *notifName = _batteryDeviceController.connectedDevicesDidChangeNotificationName;
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(reloadData) name:notifName object:nil];
    } else {
        /* Show error in the UI? */
        NSLog(@"%@", loadErr);
    }
    
    [self reloadData];
}

- (void)reloadData {
    NSArray<BCBatteryDevice *> *models = _batteryDeviceController.connectedDevices;
    
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
