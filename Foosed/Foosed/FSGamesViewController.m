//
//  FSMainViewController.m
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSGamesViewController.h"
#import "FSGameTableViewCell.h"
#import "FSUtility.h"
#import "User.h"
#import "Game.h"
#import "MBProgressHUD.h"


#define kNavBarMenuButtonDim 22.0f


@interface FSGamesViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FSGamesViewController

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WSNotifDidAddGame object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;

    
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
    
    // HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Games";
    
    // If more than 5 seconds pass since we post a comment, stop waiting for the server to respond
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(handleNetworkTimeout:) userInfo:nil repeats:NO];
    
    
    // Get all games
    [FSDatabaseManager queryForGamesWithCallback:^(NSArray *objects, NSError *error) {
        
        [hud hide:YES];
        [timer invalidate];
        
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
    
    [self.tableView reloadData];
}


#pragma mark - UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
        
    return self.objects.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FSGameTableViewCell neededHeightForCell];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"gameCell";
    
    FSGameTableViewCell *cell = (FSGameTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.tag = indexPath.row;
    
    
    Game* game = (Game*)self.objects[indexPath.row];
    
    NSString* teamANames = [FSUtility teamNamesStringForGame:game team:FSGameTeamA];
    NSString* teamBNames = [FSUtility teamNamesStringForGame:game team:FSGameTeamB];
    
    
    // scoreLabels
    cell.scoreALabel.text = [game.scoreA stringValue];
    cell.scoreBLabel.text = [game.scoreB stringValue];
    
    // teamLabels
    cell.teamALabel.text = teamANames;
    cell.teamBLabel.text = teamBNames;

    

    
    return cell;
}




- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [aTableView cellForRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"toCertificate" sender:cell];
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.row < self.objects.count) {
         // DB - Delete
         Game* game = (Game*)self.objects[indexPath.row];
         game.isDeleted = YES;
         [FSDatabaseManager saveObject:game callback:^(BOOL succeeded, NSError *error) { }];
         
         
         // Remove from self.objects
         NSMutableArray* mutableObjects = [self.objects mutableCopy];
        [mutableObjects removeObjectAtIndex:indexPath.row];
         self.objects = mutableObjects;
         
         [self.tableView reloadData];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    UITableViewCell* cell = (UITableViewCell*)sender;
    
    // Subdetails
    if ([[segue identifier] isEqualToString:@"gamesToAdd"])
    {
        
    }
}


#pragma mark - NSNotification
- (void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddGame:) name:WSNotifDidAddGame object:nil];
}

- (void)didAddGame:(NSNotification*)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    Game *game = (Game*)[userInfo objectForKey:WSNotifDidAddGameObjectKey];
    if (![game isKindOfClass:[Game class]]) return;
    
    // Add to objects
    NSMutableArray* mutableObjects = [self.objects mutableCopy];
    [mutableObjects addObject:game];
    self.objects = mutableObjects;
    
    [self.tableView reloadData];
}

#pragma mark - FSBaseTableViewController Delegate
-(void) didPullRefresh {
    [self reloadObjects];
}




#pragma mark - IBActions
- (IBAction)didTapFooterButton:(id)sender {
    [self performSegueWithIdentifier:@"gamesToAdd" sender:self];
}
@end
