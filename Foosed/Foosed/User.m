//
//  User.m
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "User.h"

@implementation User

@dynamic username;
@dynamic password;
@dynamic email;
@dynamic wins;

#pragma mark - Keys
+ (NSString *)usernameKey {
    return @"username";
}

+ (NSString *)passwordKey {
    return @"password";
}

+ (NSString *)emailKey {
    return @"email";
}

+ (NSString *)winsKey {
    return @"wins";
}



#pragma mark - Logic

- (BOOL)isEqual:(PFObject*)object {
    if ([object.objectId isEqualToString:self.objectId]) return YES;
    
    return NO;
}


@end

