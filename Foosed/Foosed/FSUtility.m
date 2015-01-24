//
//  FSUtility.m
//  Foosed
//
//  Created by Admin on 1/23/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSUtility.h"
#import "Game.h"
#import "User.h"

@implementation FSUtility

#pragma mark - Game
+ (NSString*)teamNamesStringForGame:(Game*)game team:(FSGameTeamIndex)teamIndex {
    
    NSArray* team;
    
    if (teamIndex == FSGameTeamA) {
        team = game.teamA;
    }
    else {
        team = game.teamB;
    }
    
    __block NSMutableString* teamName = [@"" mutableCopy];
    
    [team enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        if (![obj isKindOfClass:[User class]]) return;
        
        User* user = (User*)obj;
        
        [teamName appendString:user.username];
        
        if (idx > 0) [teamName appendString:@" + "]; // don't need to append on first name
    }];
    
    return teamName;
}

@end
