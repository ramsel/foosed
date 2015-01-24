//
//  WSBaseInsetTableViewCell.h
//  WSPhoto
//
//  Created by Admin on 4/14/14.
//
//

#import <UIKit/UIKit.h>

@interface FSBaseInsetTableViewCell : UITableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height;

@property (nonatomic, strong) UIView* bgView;

#pragma - Setters
- (void)setInsetBackgroundColor:(UIColor *)backgroundColor;
- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setHoriInset:(CGFloat)horiInset;
- (void)setVertInset:(CGFloat)vertInset;

@end
