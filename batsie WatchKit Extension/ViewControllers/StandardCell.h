//
//  StandardCell.h
//  batsie WatchKit Extension
//
//  Created by Leptos on 1/17/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

@import WatchKit;

@interface StandardCell : NSObject

@property (strong, nonatomic) IBOutlet WKInterfaceImage *imageView;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *detailLabel;

@end
