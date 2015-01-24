//
//  WSBaseInsetTableViewCell.m
//  WSPhoto
//
//  Created by Admin on 4/14/14.
//
//

#import "FSBaseInsetTableViewCell.h"

#define kBaseInsetCellHoriInset 6.0f
#define kBaseInsetCellVertInset 4.0f


@interface FSBaseInsetTableViewCell ()


@property (nonatomic, assign) CGFloat horiInset;
@property (nonatomic, assign) CGFloat vertInset;

@end

@implementation FSBaseInsetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self createView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self createView];
    }
    
    return self;
}


- (void) createView{
    
    self.horiInset = kBaseInsetCellHoriInset;
    self.vertInset = kBaseInsetCellVertInset;

    self.bgView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 6.0f;
    self.bgView.clipsToBounds = YES;
    [self.bgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addSubview:self.bgView];
    [self.contentView sendSubviewToBack:self.bgView];

}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    

    CGRect bgViewFrame = CGRectMake(self.horiInset,
                                    self.vertInset,
                                    screenWidth - (self.horiInset*2),
                                    self.frame.size.height - (self.vertInset*2));
    
    self.bgView.frame = bgViewFrame;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Setters
- (void)setInsetBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundView.backgroundColor = backgroundColor;
    [self layoutIfNeeded];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.backgroundView.layer.cornerRadius = cornerRadius;
    [self layoutIfNeeded];
}

- (void)setHoriInset:(CGFloat)horiInset {
    _horiInset = horiInset;
    [self layoutIfNeeded];
}

- (void)setVertInset:(CGFloat)vertInset {
    _vertInset = vertInset;
    [self layoutIfNeeded];
}

@end
