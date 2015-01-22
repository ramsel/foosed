//
//  User.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>


@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *email;




#pragma mark - Keys
+ (NSString *)usernameKey;
+ (NSString *)passwordKey;
+ (NSString *)emailKey;



#pragma mark - Logic
+ (User*)currentUser;

@end
