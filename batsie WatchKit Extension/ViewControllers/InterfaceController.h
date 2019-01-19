//
//  InterfaceController.h
//  batsie WatchKit Extension
//
//  Created by Leptos on 1/16/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

@import WatchKit;

@interface InterfaceController : WKInterfaceController

@property (strong, nonatomic) IBOutlet WKInterfaceTable *table;

- (void)reloadData;

@end
