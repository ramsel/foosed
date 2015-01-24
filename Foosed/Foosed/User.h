//
//  User.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber* wins;


#pragma mark - Keys
+ (NSString *)usernameKey;
+ (NSString *)passwordKey;
+ (NSString *)emailKey;
+ (NSString *)winsKey;



#pragma mark - Logic
- (BOOL)isEqual:(PFObject*)object;

@end
