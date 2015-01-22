//
//  WSBaseTwoViewController.m
//  WSPhoto
//
//  Created by Admin on 4/15/14.
//
//

#import "FSBaseTableViewController.h"



@interface FSBaseTableViewController () 


@end

@implementation FSBaseTableViewController



- (NSArray*) objects
{
    if (!_objects){
        
        _objects = [NSArray new];
    }
    return _objects;
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:NO];
    }
}


#pragma mark - Setters







@end
