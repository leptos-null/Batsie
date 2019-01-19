//
//  DetailViewController.h
//  batsie
//
//  Created by Leptos on 1/17/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

@import UIKit;

#import "../../BatteryCenter/BCBatteryDevice.h"

@interface DetailViewController : UIViewController <UITableViewDataSource>

@property (strong, nonatomic) BCBatteryDevice *batteryDevice;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
