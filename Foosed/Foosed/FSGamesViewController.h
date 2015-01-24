//
//  FSMainViewController.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSBaseTableViewController.h"

@interface FSGamesViewController : FSBaseTableViewController <FSBaseTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDate *lastRefresh;

@property (nonatomic, strong) NSArray* objects;

@property (nonatomic, strong) UIRefreshControl* refreshControl;


@end
