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

@interface FSGamesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL reloading;


@end

@implementation FSGamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // clear bg
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor clearColor]];

    
    [self loadObjects];
}



#pragma mark - Data
- (void) loadObjects {
    
    User* player0 = [User new];
    player0.username = @"Amos";
    
    User* player1 = [User new];
    player1.username = @"Diego";
    
    Game* game0 = [Game new];
    game0.teamA = @[player0];
    game0.teamB = @[player1];
    game0.scoreA = [NSNumber numberWithInt:0];
    game0.scoreB = [NSNumber numberWithInt:3];
    
    Game* game1 = [Game new];
    game1.teamA = @[player0];
    game1.teamB = @[player1];
    game1.scoreA = [NSNumber numberWithInt:2];
    game1.scoreB = [NSNumber numberWithInt:3];
    
    self.objects = @[game0,game1];

    [self objectsDidLoad];

    
//    // Get the course object
//    [FSDatabaseManager queryForGamesWithCallback:^(NSArray *objects, NSError *error) {
//        if (error) {
//            [self hasError:error];
//            return;
//        }
//        
//        self.objects = objects;
//        
//        [self objectsDidLoad];
//        
//    }];
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
    
    Game* game = (Game*)self.objects[indexPath.row];
    
    NSString* teamANames = [FSUtility teamNamesStringForGame:game team:FSGameTeamA];
    NSString* teamBNames = [FSUtility teamNamesStringForGame:game team:FSGameTeamB];
    
    
    // scoreLabels
    cell.scoreALabel.text = [game.scoreA stringValue];
    cell.scoreBLabel.text = [game.scoreB stringValue];
    
    // teamLabels
    cell.teamALabel.text = teamANames;
    cell.teamBLabel.text = teamBNames;

    
    

//    cell.textLabel.text = [NSString stringWithFormat:@"%@", teamBNames];
//    cell.detailTextLabel.text =[NSString stringWithFormat:@"Team A: %@",teamANames];
    cell.tag = indexPath.row;
    
    return cell;
}




- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [aTableView cellForRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"toCertificate" sender:cell];
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    static NSString *CellIdentifier = @"completedSectionHeaderCell";
//    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (headerView == nil){
//        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
//    }
//    
//    switch (section) {
//        case JTWorkerTypeApplicator:
//            headerView.textLabel.text = [JTDatabaseManager workerString:JTWorkerTypeApplicator];
//            break;
//            
//        case JTWorkerTypeFieldRep:
//            headerView.textLabel.text = [JTDatabaseManager workerString:JTWorkerTypeFieldRep];
//            break;
//            
//        case JTWorkerTypeOperator:
//            headerView.textLabel.text = [JTDatabaseManager workerString:JTWorkerTypeOperator];
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    return headerView;
//
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return heightForSectionHeader;
//}




#pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    UITableViewCell* cell = (UITableViewCell*)sender;
//    
//    // Subdetails
//    if ([[segue identifier] isEqualToString:@"toCertificate"])
//    {
//        JTCertificateViewController *certVC = [segue destinationViewController];
//        
//        UserCourse* userCourse = (UserCourse*)self.objects[cell.tag];
//        certVC.userCourse = userCourse;
//    }
//    //}
//}

#pragma mark - FSBaseTableViewController Delegate
-(void) didPullRefresh {
    [self reloadObjects];
}





@end
