//
//  JTDatabaseManager.m
//  Foosed
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSDatabaseManager.h"
#import "FSCache.h"




@interface FSDatabaseManager ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;

- (void) beginBackgroundUpdateTask;
- (void) endBackgroundUpdateTask;

@end


@implementation FSDatabaseManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Reads
+ (void)queryForGamesWithCallback:(void(^)(NSArray* objects, NSError *error))callback {

    PFQuery* query = [PFQuery queryWithClassName:[Game parseClassName]];
    
    [query whereKey:[Game isDeletedKey] notEqualTo:[NSNumber numberWithBool:YES]];
    
    [query includeKey:[Game teamAKey]];
    [query includeKey:[Game teamBKey]];

    [query orderByDescending:@"createdAt"];
    
    [FSDatabaseManager query:query withCallback:^(NSArray *objects, NSError *error) {
        callback(objects,error);
    }];
}

+ (void)queryForUsersWithCallback:(void(^)(NSArray* objects, NSError *error))callback {
    
    // Check if cached
    if ([[FSCache sharedCache] allUsers]) {
        callback([[FSCache sharedCache] allUsers],nil);
        return;
    }

    
    PFQuery* query = [PFUser query];
    
    [query orderByDescending:[User winsKey]];
    
    [FSDatabaseManager query:query withCallback:^(NSArray *objects, NSError *error) {
        
        if (objects) [[FSCache sharedCache] setAllUsers:objects];

        callback(objects,error);
    }];
}



#pragma mark - Creates
+ (void)saveObject:(PFObject*)object callback:(void(^)(BOOL succeeded, NSError *error))callback {
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        callback(succeeded, error);
    }];
}

#pragma mark - Updates



#pragma mark - General
+ (void)query:(PFQuery*)query withCallback:(void(^)(NSArray* objects, NSError *error))callback {
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        callback(objects, error);
    }];
}




#pragma mark - Background Tasks
- (void) beginBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void) endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}





@end
