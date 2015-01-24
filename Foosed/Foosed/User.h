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




#pragma mark - Keys
+ (NSString *)usernameKey;
+ (NSString *)passwordKey;
+ (NSString *)emailKey;



#pragma mark - Logic
+ (User*)currentUser;

@end
