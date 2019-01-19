//
//  BCBatteryDevice.h
//  batsie
//
//  Created by Leptos on 1/16/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

@import Foundation;

@class UIImage;

/* iOS versions checked against:
 * https://github.com/nst/iOS-Runtime-Headers/blob/HASH/PrivateFrameworks/BatteryCenter.framework/BCBatteryDevice.h
 * where HASH:
 *     9.0  : 9b00d90cdccdc95b8029441919bcfb7fb44c8816
 *     9.1  : 6a384f6a219be448de8714f263a4c212516d52b6
 *     9.3  : f92ec9a266a77e59a691ca35f4fba240d34eec91
 *     10.0 : cc2e15d329ea8a7b5c8808e1e46fb893ddd495ce
 *     11.4 : f53e3d01aceb4aab6ec2c37338d2df992d917536
 */

/** Not clear if these enums are API stable, given the "value from string" method names */

/* sourced from -[BCBatteryDeviceController _powerSourceStateFromPowerSourceStateString:] */
typedef NS_ENUM(NSInteger, BCBatteryDevicePowerSourceState) {
    BCBatteryDevicePowerSourceStateUnknown,
    BCBatteryDevicePowerSourceStateOffline, // Off Line
    BCBatteryDevicePowerSourceStateACPower, // AC Power
    BCBatteryDevicePowerSourceStateBattery, // Battery Power
};

/* sourced from -[BCBatteryDevice description] */
typedef NS_ENUM(NSInteger, BCBatteryDeviceVendor) {
    BCBatteryDeviceVendorUnknown, // Unknown
    BCBatteryDeviceVendorApple,   // Apple
    BCBatteryDeviceVendorBeats,   // Beats
};

/* sourced from -[BCBatteryDevice description] */
typedef NS_ENUM(NSUInteger, BCBatteryDeviceAccessoryCategory) {
    BCBatteryDeviceAccessoryCategoryUnknown,     // Unknown
    BCBatteryDeviceAccessoryCategorySpeaker,     // Speaker
    BCBatteryDeviceAccessoryCategoryHeadphone,   // Headphone
    BCBatteryDeviceAccessoryCategoryWatch,       // Watch
    BCBatteryDeviceAccessoryCategoryBatteryCase, // Battery Case
    BCBatteryDeviceAccessoryCategoryKeyboard,    // Keyboard
    BCBatteryDeviceAccessoryCategoryTrackpad,    // Trackpad
    BCBatteryDeviceAccessoryCategoryPencil,      // Pencil
};

/* sourced from -[BCBatteryDeviceController _partFromPowerSourcePartIdentifier:] */
typedef NS_OPTIONS(NSUInteger, BCBatteryDevicePart) {
    BCBatteryDevicePartNone,
    BCBatteryDevicePartLeft  = 1 << 0, // Left
    BCBatteryDevicePartRight = 1 << 1, // Right
    BCBatteryDevicePartCase  = 1 << 2, // Case
};

/* sourced from -[BCBatteryDeviceController _transportTypeFromPowerSourceTransportTypeString:] */
typedef NS_ENUM(NSInteger, BCBatteryDeviceTransportType) {
    BCBatteryDeviceTransportTypeUnknown         = 0,
    BCBatteryDeviceTransportTypeInternal        = 1, // Internal
    BCBatteryDeviceTransportTypeSerial          = 2, // Serial
    BCBatteryDeviceTransportTypeUSB             = 2, // USB
    BCBatteryDeviceTransportTypeAID             = 2, // AID
    BCBatteryDeviceTransportTypeBluetooth       = 3, // Bluetooth
    BCBatteryDeviceTransportTypeBluetoothLE     = 3, // Bluetooth LE
    BCBatteryDeviceTransportTypeInductiveInBand = 3, // Inductive In-Band
};

API_AVAILABLE(ios(9.0))
@interface BCBatteryDevice : NSObject <NSCopying, NSCoding> // NSSecureCoding in 11.4

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, readonly, copy) NSString *matchIdentifier;

@property (nonatomic, readonly) UIImage *glyph;

@property (nonatomic, copy) NSString *groupName API_AVAILABLE(ios(9.3));

@property (nonatomic) BCBatteryDeviceAccessoryCategory accessoryCategory API_AVAILABLE(ios(11.4));
@property (nonatomic, copy) NSString *accessoryIdentifier API_AVAILABLE(ios(11.4));

@property (nonatomic) BOOL approximatesPercentCharge API_AVAILABLE(ios(10.0));

@property (getter=isBatterySaverModeActive, nonatomic) BOOL batterySaverModeActive API_AVAILABLE(ios(11.4));

@property (nonatomic) NSInteger percentCharge;
@property (getter=isCharging, nonatomic) BOOL charging;
@property (getter=isConnected, nonatomic) BOOL connected;

@property (getter=isPowerSource, nonatomic) BOOL powerSource;
@property (nonatomic) BCBatteryDevicePowerSourceState powerSourceState;

@property (getter=isLowBattery, nonatomic) BOOL lowBattery API_AVAILABLE(ios(9.1));

@property (getter=isFake, nonatomic) BOOL fake;
@property (getter=isInternal, nonatomic) BOOL internal;

@property (nonatomic) BCBatteryDeviceTransportType transportType;
@property (nonatomic, readonly) BCBatteryDeviceVendor vendor;
@property (nonatomic, readonly) NSInteger productIdentifier;

@property (nonatomic) BCBatteryDevicePart parts API_AVAILABLE(ios(9.1));

@end
