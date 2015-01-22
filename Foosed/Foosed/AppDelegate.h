//
//  AppDelegate.h
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)presentLoginViewControllerAnimated:(BOOL)animated withDismissButton:(BOOL)withDismissButton;
- (void)userHasLoggedIn;
- (void)logOut;


@end

