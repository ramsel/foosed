//
//  WSBaseTwoViewController.h
//  WSPhoto
//
//  Created by Admin on 4/15/14.
//
//

#import "FSBaseViewController.h"

@protocol FSBaseTableViewControllerDelegate;

@interface FSBaseTableViewController : FSBaseViewController {
    BOOL reloading;
}

@property (nonatomic, strong) NSDate *lastRefresh;

@property (nonatomic, strong) NSArray* objects;

@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (nonatomic, weak) UITableView* tableView;

- (id)initWithTableViewStyle:(UITableViewStyle)tableViewStyle;


@property (nonatomic, weak) id<FSBaseTableViewControllerDelegate> tableViewDelegate;

@end


@protocol FSBaseTableViewControllerDelegate <NSObject>

@required

-(void) didPullRefresh;

@end
