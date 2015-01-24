//
//  WSGameTableViewCell.m
//  Foosed
//
//  Created by Ramsel on 01/23/14.
//
//

#import "FSGameTableViewCell.h"

#define kFSGameCellHeight 100.0f

@interface FSGameTableViewCell ()

@property (nonatomic, strong) UIView* bgViewA;
@property (nonatomic, strong) UIView* bgViewB;


@end


@implementation FSGameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self setupViews];
    }
    
    return self;
}

- (void) setupViews {
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    // floatingBGView
    self.floatingBGView.layer.cornerRadius = 6.0f;
    
    // scoreLabel
    self.scoreALabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.scoreALabel.font.pointSize];
    self.scoreBLabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.scoreBLabel.font.pointSize];

    
    // teamLabel
    self.teamALabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.teamALabel.font.pointSize];
    self.teamBLabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.teamBLabel.font.pointSize];

    
    [self layoutIfNeeded];
}




+ (CGFloat) neededHeightForCell {
    return kFSGameCellHeight;
    
}


#pragma mark - Delegate method
//- (void)didTapUserButtonAction:(id)sender {
//
//    if (self.partnerCellDelegate && [self.partnerCellDelegate respondsToSelector:@selector(didTapUserImageForCell:)]) {
//        [self.partnerCellDelegate didTapUserImageForCell:self];
//    }
//}

@end
