//
//  Game.m
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "Game.h"

@implementation Game

@dynamic teamA;
@dynamic teamB;
@dynamic scoreA;
@dynamic scoreB;

+ (NSString*)parseClassName {
    return @"Game";
}

#pragma mark - Keys
+ (NSString *)teamAKey {
    return @"teamA";
}
+ (NSString *)teamBKey {
    return @"teamB";
}
+ (NSString *)scoreAKey {
    return @"scoreA";
}
+ (NSString *)scoreBKey {
    return @"scoreB";
}
@end
