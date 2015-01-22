//
//  FSMainButton.m
//  Foosed
//
//  Created by Admin on 10/6/14.
//  Copyright (c) 2014 Ramsel. All rights reserved.
//

#import "FSMainButton.h"
#import <QuartzCore/QuartzCore.h>

#define mainButtonWidth 4.0f

@interface FSMainButton ()

@property (nonatomic, strong,readonly) UIColor* defaultColor;

@property (nonatomic, strong) CALayer* sublayer;

@end

@implementation FSMainButton

- (void) awakeFromNib {
    
    [super awakeFromNib];

    
    // Add sublayer
    self.layer.cornerRadius = 6.0f;
    self.layer.borderWidth = mainButtonWidth;
    self.layer.borderColor = [[UIColor colorWithWhite:1.0f alpha:0.3f] CGColor];
    CALayer *sub = [CALayer new];
    sub.frame = CGRectInset(self.bounds, mainButtonWidth, mainButtonWidth);
    sub.backgroundColor = self.defaultColor.CGColor;
    self.sublayer = sub;
    [self.layer addSublayer:self.sublayer];
    
    
    // Set font
    self.titleLabel.font = [UIFont fontWithName:kMasterDemiBoldFontName size:kFSMainButtonFontSize];
    self.titleLabel.textColor = [UIColor blueColor];

}

#pragma mark - Setters/Getters
- (UIColor*)defaultColor {
    return [UIColor grayColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.sublayer.backgroundColor = backgroundColor.CGColor;
}



@end
