//
//  Game.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//


typedef enum {
    FSGameTeamA,
    FSGameTeamB,
    FSGameTeamNone
} FSGameTeamIndex;


@interface Game : PFObject <PFSubclassing>

@property (nonatomic, strong) NSArray *teamA;
@property (nonatomic, strong) NSArray *teamB;
@property (nonatomic, strong) NSNumber *scoreA;
@property (nonatomic, strong) NSNumber *scoreB;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *winners;
@property (nonatomic, assign) BOOL isDeleted;

- (instancetype)initWithZeroedScores;

#pragma mark - Keys
+ (NSString *)teamAKey;
+ (NSString *)teamBKey;
+ (NSString *)scoreAKey;
+ (NSString *)scoreBKey;
+ (NSString *)dateKey;
+ (NSString *)winnersKey;
+ (NSString *)isDeletedKey;


@end
