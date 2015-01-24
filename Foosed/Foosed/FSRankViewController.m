//
//  FSRankViewController.m
//  Foosed
//
//  Created by Admin on 1/24/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSRankViewController.h"
#import "FSRankTableViewCell.h"
#import "User.h"

@interface FSRankViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FSRankViewController

- (void)dealloc {

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.accessibilityLabel = @"Back Button";
    backButton.frame = CGRectMake( 0.0f, 0.0f, kNavBarBackButtonDim, kNavBarBackButtonDim);
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:kFSBackButtonWhiteIcon] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:kFSBackButtonWhiteIcon] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // clear bg
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    [self loadObjects];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self registerForNotifications];
}



#pragma mark - Data
- (void) loadObjects {
    
    // Get all games
    [FSDatabaseManager queryForUsersWithCallback:^(NSArray *objects, NSError *error) {
        if (error) {
            [self hasError:error];
            return;
        }
        
        self.objects = objects;
        
        [self objectsDidLoad];
        
    }];
}


- (void) reloadObjects {
    
    // Clear the table
    self.objects = nil;
    
    // Reload
    [self loadObjects];
}



- (void) objectsDidLoad {
    
    self.objects = [self sortUsersByWins:self.objects];
    
    [self.tableView reloadData];
}


- (NSArray*) sortUsersByWins:(NSArray*)users {
    
    NSArray* sortedArray = [users sortedArrayUsingComparator:^(id obj1, id obj2){
        
        if ([obj1 isKindOfClass:[User class]] && [obj2 isKindOfClass:[User class]]) {
            
            User *userA = obj1;
            User *userB = obj2;
            
            if (!userA || !userB) return (NSComparisonResult)NSOrderedSame;
        
            if (userA.wins > userB.wins) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if (userA.wins < userB.wins) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return sortedArray;
}

#pragma mark - UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"rankCell";
    
    FSRankTableViewCell *cell = (FSRankTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.tag = indexPath.row;
    
    
    User* user = (User*)self.objects[indexPath.row];
    
    cell.usernameLabel.text = user.username;
    
    NSNumber* wins = user.wins;
    if (!wins) wins = [NSNumber numberWithInt:0];
    cell.winsLabel.text = [wins stringValue];

    
    return cell;
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}


#pragma mark - Navigation



#pragma mark - NSNotification
- (void) registerForNotifications {
  
}



#pragma mark - FSBaseTableViewController Delegate
-(void) didPullRefresh {
    [self reloadObjects];
}



@end

