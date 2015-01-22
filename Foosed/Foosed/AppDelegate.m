//
//  AppDelegate.m
//  Foosed
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "AppDelegate.h"
#import "FSWelcomeViewController.h"
#import "FSLoginViewController.h"
#import "FSSignupViewController.h"

// Data
#import "User.h"

@interface AppDelegate () <FSLoginViewControllerDelegate>

@property (nonatomic, strong) FSWelcomeViewController* welcomeController;
@property (nonatomic, strong) UINavigationController* navController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    // Parse
    [self setupParse:launchOptions];
    
    
    // Appearance
    [self setupAppearance];


    
    // RootVC
    self.navController = (UINavigationController*)self.window.rootViewController;
    self.welcomeController = (FSWelcomeViewController*)[self.navController.viewControllers objectAtIndex:0];

    
    return YES;
}

- (void)setupParse:(NSDictionary *)launchOptions {
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"1PGjk8BrUPWvAA2odbPb31rbRX52TR8dSP3f5XPN"
                  clientKey:@"Z9qrrC0XxRWYKOhy3FAOHHrvqR6dB0AUKkRruxoC"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Register Parse data subclasses
    [User registerSubclass];
    
    // Automatic User
    [User enableAutomaticUser];
    
}



#pragma mark - Login/Signup
- (void)presentLoginViewControllerAnimated:(BOOL)animated withDismissButton:(BOOL)withDismissButton {
    [self.welcomeController performSegueWithIdentifier:@"welcomeToLogin" sender:nil];
}

- (void)userDidLogIn:(PFUser*)user {
    [self proceedToMainInterface:user];
}

- (void)userHasLoggedIn {
    [self proceedToMainInterface:[User currentUser]];
}

- (void)proceedToMainInterface:(PFUser *)user {
    
    // Present the main interface
    [self.welcomeController performSegueWithIdentifier:@"welcomeToMain" sender:nil];

}

#pragma mark Logout

- (void)logOut {
    
    // clear NSUserDefaults
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

    // Clear all caches
    [PFQuery clearAllCachedResults];
    
    // Log out
    [PFUser logOut];
    
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewControllerAnimated:YES withDismissButton:NO];
}

#pragma mark FSLoginViewController Delegate
- (void)logInViewController:(FSLoginViewController *)logInController didLogInUser:(PFUser *)user {
    
    [self.welcomeController.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [self userDidLogIn:user];
    }];
}



- (void)logInViewController:(FSLoginViewController *)logInController didSignUpUser:(PFUser *)user {
    
    [self.welcomeController.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [self userDidLogIn:user];
    }];
    
}

- (void)logInViewControllerDidCancelLogIn:(FSLoginViewController *)logInController {
    
}



#pragma mark - ()
- (void) setupAppearance {
    // Navigation bar appearance (background and title)
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20.0f], NSFontAttributeName, nil]];
    
    if([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]){ //iOS7
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorLightBeige]];
    }
    else {
        [[UINavigationBar appearance] setBackgroundColor:[UIColor colorLightBeige]];
        
    }
   }


@end
