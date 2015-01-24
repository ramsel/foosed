//
//  WSGameTableViewCell.h
//  Foosed
//
//  Created by Ramsel on 01/23/14.
//
//

#import "FSBaseInsetTableViewCell.h"



@protocol WSPartnersTableViewCellDelegate;


@interface FSGameTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *floatingBGView;

@property (weak, nonatomic) IBOutlet UILabel *scoreALabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreBLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamALabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBLabel;

@property (nonatomic, weak) id<WSPartnersTableViewCellDelegate> e;


+ (CGFloat) neededHeightForCell;

@end


/*!
 The protocol defines methods a delegate of a WSPartnersTableViewCell should implement.
 */
@protocol WSPartnersTableViewCellDelegate <NSObject>
@optional


// Tells delegate which buttons are tapped
- (void)didTapUserImageForCell:(FSGameTableViewCell *)partnerCell;

@end