//
//  FSSignupViewController.h
//  Foosed
//
//  Created by Admin on 10/14/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTextField.h"
#import "FSBaseViewController.h"
#import "FSMainButton.h"


@protocol FSSignupViewControllerDelegate;

@interface FSSignupViewController : FSBaseViewController

@property (weak, nonatomic) IBOutlet FSMainButton *signupButton;
@property (weak, nonatomic) IBOutlet FSMainButton *backToLoginButton;
@property (weak, nonatomic) IBOutlet FSTextField *usernameTextField;
@property (weak, nonatomic) IBOutlet FSTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet FSTextField *emailTextField;

- (IBAction)didTapSignupButton:(id)sender;
- (IBAction)didTapBackButton:(id)sender;

/*! @name Delegate */
@property (nonatomic, weak) id<FSSignupViewControllerDelegate> delegate;

@end


@class User;

@protocol FSSignupViewControllerDelegate <NSObject>
@required

- (void)signUpViewController:(FSSignupViewController *)signUpController didSignUpUser:(User *)user;
- (void)signUpViewController:(FSSignupViewController *)signUpController didTapBackButton:(id)sender;

@end
