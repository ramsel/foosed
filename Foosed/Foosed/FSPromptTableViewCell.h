//
//  WSPromptTableViewCell.h
//  WSPhoto
//
//  Created by Admin on 10/30/14.
//
//

#import <UIKit/UIKit.h>

@interface FSPromptTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* promptLabel;

+ (CGFloat)neededHeightForCell:(NSString*)text;

@end
