//
//  WSBaseTwoViewController.m
//  WSPhoto
//
//  Created by Admin on 4/15/14.
//
//

#import "FSBaseTableViewController.h"



@interface FSBaseTableViewController ()

@property (assign) UITableViewStyle tableViewStyle;



@end

@implementation FSBaseTableViewController

#pragma mark - Init
- (id)initWithTableViewStyle:(UITableViewStyle)tableViewStyle
{
    self = [super init];
    if (self) {
        self.tableViewStyle = tableViewStyle;
        
        // Setup table view programatically
        CGFloat windowHeight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat windowWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat scrollContentHeight = windowHeight - navBarHeight - statusBarHeight;
        CGSize scrollContentSize = CGSizeMake(windowWidth, scrollContentHeight);
        
        UITableViewStyle tableViewStyle = self.tableViewStyle;
        UITableView* aTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,
                                                                                self.view.bounds.origin.y,
                                                                                scrollContentSize.width,
                                                                                scrollContentSize.height) style:tableViewStyle];
        
        self.tableView = aTableView;
        [self.tableView setAllowsSelection:YES];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:self.tableView];

    }
    return self;
}


- (NSArray*) objects
{
    if (!_objects){
        
        _objects = [NSArray new];
    }
    return _objects;
}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:NO];
    }
}


#pragma mark - Refresh Control
- (void)setupRefreshView {
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    self.refreshControl = refreshControl;
}


- (void) refresh:(UIRefreshControl *)refreshControl {
    // Refresh table here...
    [self didPullRefresh];
    
    self.reloading = YES;
    
    [refreshControl endRefreshing];
}


#pragma mark - Delegate
-(void) didPullRefresh {
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(didPullRefresh)]) {
        [self.tableViewDelegate didPullRefresh];
    }
}



@end
