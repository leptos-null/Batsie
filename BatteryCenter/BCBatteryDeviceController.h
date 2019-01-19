//
//  BCBatteryDeviceController.h
//  batsie
//
//  Created by Leptos on 1/16/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import "BCBatteryDevice.h"

API_AVAILABLE(ios(9.0))
@interface BCBatteryDeviceController : NSObject

@property (nonatomic, readonly) NSArray<BCBatteryDevice *> *connectedDevices;
@property (nonatomic, readonly) NSString *connectedDevicesDidChangeNotificationName;

+ (instancetype)sharedInstance;

/* not sure how the block works yet */
- (void)addDeviceChangeHandler:(void(^)(void))block withIdentifier:(NSString *)identifier;
- (void)removeDeviceChangeHandlerWithIdentifier:(NSString *)identifier;

@end
