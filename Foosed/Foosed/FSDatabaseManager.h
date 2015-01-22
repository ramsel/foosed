//
//  FSDatabaseManager.h
//  Foosed
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSDatabaseManager : NSObject


#pragma mark - Reads
//+ (void)queryForCourses:(NSString*)workerType withCallback:(void(^)(NSArray* courses, NSError *error))callback;


#pragma mark - Creates
//+ (void)createUserCourse:(Course*)course user:(User*)user withCallback:(void(^)(UserCourse *course, NSError *error))callback;


#pragma mark - Updates
//+ (void)updateUserProfile:(PFUser*)user firstName:(NSString*)firstName lastName:(NSString*)lastName license:(NSString*)license position:(NSString*)position withCallback:(void(^)(BOOL succeeded, NSError *error))callback;
//
//- (void)update:(PFObject*)object withCallback:(void(^)(BOOL succeeded, NSError *error))callback;

#pragma mark - Utility
//+ (BOOL)user:(User*)user hasCourse:(Course*)course;



@end
