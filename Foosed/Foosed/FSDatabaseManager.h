//
//  FSDatabaseManager.h
//  Foosed
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Game.h"

@interface FSDatabaseManager : NSObject


#pragma mark - Reads
+ (void)queryForGamesWithCallback:(void(^)(NSArray* objects, NSError *error))callback;
+ (void)queryForUsersWithCallback:(void(^)(NSArray* objects, NSError *error))callback;


#pragma mark - Creates
+ (void)saveObject:(PFObject*)object callback:(void(^)(BOOL succeeded, NSError *error))callback;


#pragma mark - Updates


#pragma mark - Utility



@end
