//
//  Game.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//


typedef enum {
    FSGameTeamA,
    FSGameTeamB
} FSGameTeamIndex;


@interface Game : PFObject <PFSubclassing>

@property (nonatomic, strong) NSArray *teamA;
@property (nonatomic, strong) NSArray *teamB;
@property (nonatomic, strong) NSNumber *scoreA;
@property (nonatomic, strong) NSNumber *scoreB;

#pragma mark - Keys
+ (NSString *)teamAKey;
+ (NSString *)teamBKey;
+ (NSString *)scoreAKey;
+ (NSString *)scoreBKey;


@end
