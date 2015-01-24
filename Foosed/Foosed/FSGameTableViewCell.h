//
//  WSGameTableViewCell.h
//  Foosed
//
//  Created by Ramsel on 01/23/14.
//
//

#import "FSBaseInsetTableViewCell.h"

@interface FSGameTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *scoreALabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreBLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamALabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBLabel;

+ (CGFloat) neededHeightForCell;

@end


