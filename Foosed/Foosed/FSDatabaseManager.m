//
//  JTDatabaseManager.m
//  Foosed
//
//  Created by Admin on 7/7/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSDatabaseManager.h"
#import "User.h"



@interface FSDatabaseManager ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;

- (void) beginBackgroundUpdateTask;
- (void) endBackgroundUpdateTask;

@end


@implementation FSDatabaseManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//#pragma mark - Reads
//
//+ (void)queryForCourses:(NSString*)workerType withCallback:(void(^)(NSArray* courses, NSError *error))callback {
//
//    PFQuery* coursesQuery = [PFQuery queryWithClassName:[Course parseClassName]];
//    [coursesQuery whereKey:[Course workerTypeKey] equalTo:workerType];
//    
//    [coursesQuery orderByAscending:[Course tagKey]];
//    
//    [coursesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        callback(objects, error);
//    }];
//}
//
//
//#pragma mark - Creates
//+ (void)createUserCourse:(Course*)course user:(User*)user withCallback:(void(^)(UserCourse *course, NSError *error))callback {
//    
//    // Create the userCourse object
//    UserCourse* userCourse = [UserCourse object];
//    userCourse.course = course;
//    userCourse.user = user;
//    userCourse.status = [NSNumber numberWithInt:JTCourseStatusStarted];
//    userCourse.timePassed = [NSNumber numberWithFloat:0.0f];
//    
//    [userCourse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        
//      
//        __block UserCourseSet* userCourseSet;
//        
//        // Check for UserCourseSet for this workerType/categoryType combo -- Create a userCourseSet object if none
//        PFQuery* userCourseSetQuery = [PFQuery queryWithClassName:[UserCourseSet parseClassName]];
//        [userCourseSetQuery whereKey:[UserCourseSet workerTypeKey] equalTo:course.workerType];
//        [userCourseSetQuery whereKey:[UserCourseSet categoryTypeKey] equalTo:course.categoryType];
//         
//        [userCourseSetQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//            
//            NSLog(@"object = %@",object);
//            NSLog(@"error = %@",error);
//
//            
//            // Add to existing set
//            if (object) {
//                
//                userCourseSet = (UserCourseSet*)object;
//                [userCourseSet addObject:userCourse forKey:[UserCourseSet userCoursesKey]];
//                
//            }
//            
//            // Create new set
//            else {
//                
//                // Create the userCourse object
//                userCourseSet = [UserCourseSet object];
//                userCourseSet.categoryType = course.categoryType;
//                userCourseSet.user = user;
//                userCourseSet.workerType =  course.workerType;
//                
//                NSArray* userCoursesArray = [NSArray arrayWithObject:userCourse];
//                userCourseSet.userCourses = userCoursesArray;
//                
//            }
//            
//            // Now save it
//            [userCourseSet saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                
//                // Add the Course to the User
//                NSMutableArray* coursesForUser = [user.courses mutableCopy];
//                
//                if (!coursesForUser) {
//                    coursesForUser = [NSMutableArray new];
//                }
//                
//                [coursesForUser addObject:course];
//                user.courses = coursesForUser;
//                
//                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    callback(userCourse, error);
//                }];
//
//            }];
//
//        }];
//    }];
//}
//
//#pragma mark - Updates
//+ (void)updateUserProfile:(User*)user firstName:(NSString*)firstName lastName:(NSString*)lastName license:(NSString*)license position:(NSString*)position withCallback:(void(^)(BOOL succeeded, NSError *error))callback {
//    
//    user.firstName = firstName;
//    user.lastName = lastName;
//    user.license = license;
//    user.position = position;
//    
////    [user setObject:firstName forKey:[User firstNameKey]];
////    [user setObject:lastName forKey:[User lastNameKey]];
////    [user setObject:license forKey:[User licenseKey]];
////    [user setObject:position forKey:[User positionKey]];
//    
//    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        callback(succeeded,error);
//    }];
//}
//
////- (void)updateUserCourseAsPassed:(UserCourse*)userCourse  withCallback:(void(^)(BOOL succeeded, NSError *error))callback {
////
////    // Do this in a background task to make sure it saves if called in applicationDidEnterBackground
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        
////        [self beginBackgroundUpdateTask];
////        
////        userCourse.timePassed = time;
////        
////        [userCourse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
////            callback(succeeded,error);
////            
////            [self endBackgroundUpdateTask];
////        }];
////    });
////}
//
//- (void)update:(PFObject*)object withCallback:(void(^)(BOOL succeeded, NSError *error))callback {
//    // Do this in a background task to make sure it saves if called in applicationDidEnterBackground
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [self beginBackgroundUpdateTask];
//        
//        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            callback(succeeded,error);
//            
//            [self endBackgroundUpdateTask];
//        }];
//    });
//
//}
//
//#pragma mark - Utility
//+ (BOOL)user:(User*)user hasCourse:(Course*)course {
//        
//    
//    
//    __block BOOL hasCourse = NO;
//    
//    NSArray* courses = user.courses;
//    
//    [courses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        
//        Course* courseUser = (Course*)obj;
//        
//        if ([course.objectId isEqualToString:courseUser.objectId]) {
//            hasCourse = YES;
//            *stop = YES;
//        }
//    }];
//  
//    return hasCourse;
//    
//}



#pragma mark - Background Tasks
- (void) beginBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void) endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}





@end
