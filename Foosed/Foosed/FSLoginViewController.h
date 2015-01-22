//
//  FSLoginViewController.h
//  Foosed
//
//  Created by Admin on 10/14/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"
#import "FSTextField.h"
#import "FSMainButton.h"

@protocol FSLoginViewControllerDelegate;

@interface FSLoginViewController : FSBaseViewController 
@property (weak, nonatomic) IBOutlet FSMainButton *signupButton;
@property (weak, nonatomic) IBOutlet FSMainButton *loginButton;
@property (weak, nonatomic) IBOutlet FSTextField *usernameTextField;
@property (weak, nonatomic) IBOutlet FSTextField *passwordTextField;

- (IBAction)didTapLoginButton:(id)sender;

/*! @name Delegate */
@property (nonatomic, strong) id<FSLoginViewControllerDelegate> delegate;

@end



@protocol FSLoginViewControllerDelegate <NSObject>
@required

- (void)logInViewController:(FSLoginViewController *)logInController didLogInUser:(PFUser *)user;
- (void)logInViewController:(FSLoginViewController *)logInController didSignUpUser:(PFUser *)user;

- (void)logInViewControllerDidCancelLogIn:(FSLoginViewController *)logInController;

@end