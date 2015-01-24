//
//  FSRankTableViewCell.h
//  Foosed
//
//  Created by Admin on 1/24/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSRankTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;


+ (CGFloat) neededHeightForCell;

@end

