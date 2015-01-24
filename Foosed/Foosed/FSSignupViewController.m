//
//  FSSignupViewController.m
//  Foosed
//
//  Created by Admin on 10/14/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSSignupViewController.h"
#import "DAKeyboardControl.h"
#import "User.h"


@implementation FSSignupViewController


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.signupButton setBackgroundColor:[UIColor colorPurple]];
    [self.backToLoginButton setBackgroundColor:[UIColor colorLimeGreen]];

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

- (IBAction)didTapSignupButton:(id)sender {
    
    User* user = [User currentUser];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    user.email = self.emailTextField.text;
    
    if (!user.username || !user.password || !user.email) {
        
        // Show alert not entered
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"Please enter your username, password, and e-mail." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    NSError* error;
    
    [user signUp:&error];
    
    // If an error
    if (error) {
        [self hasError:error];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(signUpViewController:didSignUpUser:)]) {
        [_delegate signUpViewController:self didSignUpUser:user];
    }
}

- (IBAction)didTapBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
