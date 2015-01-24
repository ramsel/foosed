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

    
    // scoreLabel
    self.scoreALabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.scoreALabel.font.pointSize];
    self.scoreBLabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.scoreBLabel.font.pointSize];

    
    // teamLabel
    self.teamALabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.teamALabel.font.pointSize];
    self.teamBLabel.font = [UIFont fontWithName:kMasterBoldFontName size:self.teamBLabel.font.pointSize];

    
    [self layoutIfNeeded];
}


#pragma mark - Editing
- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask)
    {
        [self performSelector:@selector(setupDeleteButton) withObject:nil afterDelay:0.1];
    }
}

- (void)setupDeleteButton
{
    [self recurseToDeleteButtonInViews:[self subviews]];
}

- (void)recurseToDeleteButtonInViews:(NSArray *)subviews
{
    for (UIView *subview in subviews)
    {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationButton"]){
            UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            [deleteBtn setImage:[UIImage imageNamed:kFSDeleteButtonTrashIcon]];
            [[subview.subviews objectAtIndex:0] addSubview:deleteBtn];
            return;
        }
        if ([[subview subviews] count] > 0){
            [self recurseToDeleteButtonInViews:[subview subviews]];
        }
    }
    return;
}

#pragma mark - Static Layout
+ (CGFloat) neededHeightForCell {
    return kFSGameCellHeight;
    
}



@end
