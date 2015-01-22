//
//  WSBaseTwoViewController.h
//  WSPhoto
//
//  Created by Admin on 4/15/14.
//
//

#import "FSBaseViewController.h"

@interface FSBaseTableViewController : FSBaseViewController {
    BOOL reloading;
}

@property (nonatomic, strong) NSDate *lastRefresh;

@property (nonatomic, strong) NSArray* objects;

@property (nonatomic, strong) UIRefreshControl* refreshControl;


@end
