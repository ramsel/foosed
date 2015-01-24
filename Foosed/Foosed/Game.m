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
@dynamic date;
@dynamic winners;
@dynamic isDeleted;

+ (NSString*)parseClassName {
    return @"Game";
}

- (instancetype)initWithZeroedScores {
    
    self = [super init];
    if (self) {
        self.scoreA = [NSNumber numberWithInt:0];
        self.scoreB = [NSNumber numberWithInt:0];
    }
    return self;
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
+ (NSString *)dateKey {
    return @"date";
}
+ (NSString *)winnersKey {
    return @"winners";
}
+ (NSString *)isDeletedKey {
    return @"isDeleted";
}

@end
