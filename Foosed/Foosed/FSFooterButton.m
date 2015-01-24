//
//  FSFooterView.m
//  Foosed
//
//  Created by Admin on 4/14/14.
//
//

#import "FSFooterButton.h"

#define kFooterButtonPadding 12.0f
#define kFooterButtonFontSize 24.0f
#define kFooterButtonHeight 74.0f



@interface FSFooterButton ()

@property (nonatomic, strong) UIButton* button;

@end

@implementation FSFooterButton


- (id)initWithText:(NSString*)text delegate:(id)aDelegate

{
    self = [super initWithFrame:[FSFooterButton rectForView]];
    if (self) {
        
        self.delegate = aDelegate;
        
        self.backgroundColor = [UIColor clearColor];

        [self setupButton:[FSFooterButton rectForView] text:text];
    }
    return self;
}

- (void) setupButton:(CGRect)viewFrame text:(NSString*)text {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kFooterButtonPadding,
                                    kFooterButtonPadding,
                                    viewFrame.size.width - (2*kFooterButtonPadding),
                                    viewFrame.size.height - (2*kFooterButtonPadding))];
    [button setBackgroundColor:[UIColor colorPurple]];
    [button addTarget:self action:@selector(didTapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setTitle:text forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont fontWithName:kMasterBoldFontName size:kFooterButtonFontSize]];
    [button.titleLabel setNumberOfLines:1];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [button.titleLabel setMinimumScaleFactor:0.7];
    button.layer.cornerRadius = 4.0f;
    button.clipsToBounds = YES;
    [self addSubview:button];
    self.button = button;
    
    self.isSelected = YES;
}

#pragma mark - WSStartConvoButtonView
- (void) setSelected:(BOOL)selected {
    
    if (selected) {
        [self.button setBackgroundColor:[UIColor colorBrightBlue]];
        _isSelected = YES;

    }
    else {
        [self.button setBackgroundColor:[UIColor lightGrayColor]];
        self.isSelected = NO;

    }
}

- (void) setText:(NSString*)text {

    [self.button setTitle:text forState:UIControlStateNormal];
    [self.button setTitle:text forState:UIControlStateHighlighted];
    [self.button setTitle:text forState:UIControlStateSelected];
    
}

+ (CGRect)rectForView {
    return CGRectMake(0.0f,
                      [UIScreen mainScreen].bounds.size.height - kFooterButtonHeight,
                      [UIScreen mainScreen].bounds.size.width,
                      kFooterButtonHeight);
}


#pragma mark - ()
- (void)didTapButtonAction:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(footerButtonView:didTapFooterButton:)]) {
        [self.delegate footerButtonView:self didTapFooterButton:button];
    }
}




@end
