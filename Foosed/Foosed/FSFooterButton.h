//
//  FSFooterView.h
//  Foosed
//
//  Created by Ramsel on 4/14/14.
//
//

#import <UIKit/UIKit.h>

@protocol FSFooterButtonDelegate;


@interface FSFooterButton : UIView

@property (nonatomic, strong) UIButton* footerButton;

@property (nonatomic, assign) BOOL isSelected;

- (id)initWithText:(NSString*)text delegate:(id)aDelegate;

+ (CGRect)rectForView;

- (void) setSelected:(BOOL)selected;
- (void) setText:(NSString*)text;


/*! @name Delegate */
@property (nonatomic, weak) id<FSFooterButtonDelegate> delegate;

@end


@protocol FSFooterButtonDelegate <NSObject>

@required

- (void)footerButtonView:(FSFooterButton*)footerView didTapFooterButton:(UIButton *)button;

@end
