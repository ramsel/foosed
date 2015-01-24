//
//  FSRankTableViewCell.m
//  Foosed
//
//  Created by Admin on 1/24/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSRankTableViewCell.h"

#define kFSRankCellHeight 74.0f


@implementation FSRankTableViewCell

- (void)awakeFromNib {

    [self setupViews];
}

- (void) setupViews {
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) neededHeightForCell {
    return kFSRankCellHeight;
    
}


@end
