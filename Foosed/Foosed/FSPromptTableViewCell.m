    //
//  WSPromptTableViewCell.m
//  WSPhoto
//
//  Created by Admin on 10/30/14.
//
//

#define kPromptCellFontSize 18.0f

#import "FSPromptTableViewCell.h"

@implementation FSPromptTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void) createSubviews {
    
    // promptLabel
    UILabel* promptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [promptLabel setBackgroundColor:[UIColor clearColor]];
    [promptLabel setFont:[UIFont fontWithName:kMasterBoldFontName size:kPromptCellFontSize]];
    [promptLabel setNumberOfLines:0];
    [promptLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [promptLabel setAdjustsFontSizeToFitWidth:YES];
    [promptLabel setTextColor:[UIColor blackColor]];
    [promptLabel setTextAlignment:NSTextAlignmentCenter];
    self.promptLabel = promptLabel;
    [self addSubview:self.promptLabel];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // promptLabel
    self.promptLabel.center = self.contentView.center;
    [self.promptLabel sizeToFit];
    
}

+ (CGRect)neededFrameForText:(NSString*)text
{
    UIFont* font = [UIFont fontWithName:kMasterBoldFontName size:kPromptCellFontSize];
    CGRect rect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)
                                                      options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];

    return rect;
}

+ (CGFloat)neededHeightForCell:(NSString*)text
{
    return [FSPromptTableViewCell neededFrameForText:text].size.height;
}


@end
