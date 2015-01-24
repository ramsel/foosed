//
//  FSLoginViewController.m
//  Foosed
//
//  Created by Admin on 10/14/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSLoginViewController.h"
#import "DAKeyboardControl.h"

#import "FSSignupViewController.h"
#import "User.h"

@interface FSLoginViewController () <FSSignupViewControllerDelegate>


@end

@implementation FSLoginViewController

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.signupButton setBackgroundColor:[UIColor colorPurple]];
    [self.loginButton setBackgroundColor:[UIColor colorPurple]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Dismiss keyboard on scroll
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        /*
         Try not to call "self" inside this block (retain cycle).
         But if you do, make sure to remove DAKeyboardControl
         when you are done with the view controller by calling:
         [self.view removeKeyboardControl];
         */
    } constraintBasedActionHandler:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.transparentBGView.hidden = YES;

}

- (IBAction)didTapLoginButton:(id)sender {
    
    if (!self.usernameTextField.text || !self.passwordTextField.text) {
        
        // Show alert not entered
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please enter your username and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    NSError* error;
    
    User* user = (User*)[PFUser logInWithUsername:self.usernameTextField.text password:self.passwordTextField.text error:&error];
    
    // If an error
    if (!user) {        
        [self hasError:error];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(logInViewController:didLogInUser:)]) {
        [_delegate logInViewController:self didLogInUser:user];
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loginToSignup"])
    {
        FSSignupViewController *signupVC = [segue destinationViewController];
        
        signupVC.delegate = self;
    }
}


#pragma mark - JTSignupViewController Delegate 
- (void)signUpViewController:(FSSignupViewController *)signUpController didSignUpUser:(PFUser *)user {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        if (_delegate && [_delegate respondsToSelector:@selector(logInViewController:didSignUpUser:)]) {
            [_delegate logInViewController:self didSignUpUser:user];
        }
    }];
    
}

- (void)signUpViewController:(FSSignupViewController *)signUpController didTapBackButton:(id)sender {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
