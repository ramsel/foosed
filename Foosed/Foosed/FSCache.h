//
//  FSCache.h
//  Foosed
//
//  Created by Admin on 1/23/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Game.h"

@interface FSCache : NSObject

+ (id)sharedCache;

- (void)clear;

#pragma mark - App
- (NSArray*)allUsers;
- (void)setAllUsers:(NSArray*)users;

@end
