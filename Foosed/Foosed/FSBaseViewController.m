//
//  JTBaseViewController.m
//  Foosed
//
//  Created by Admin on 10/8/14.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSBaseViewController.h"

@implementation FSBaseViewController

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kFSBackgroundImage]]];
    
    
    // TransparentView over bgImage
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.transparentBGView = [[UIView alloc] initWithFrame:screenRect];
    self.transparentBGView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    [self.view addSubview:self.transparentBGView];
    [self.view sendSubviewToBack:self.transparentBGView];
    
    
}


#pragma mark - Navigation
- (void) backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ()
- (void)hasError:(NSError *)error {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[NSString stringWithFormat:@"%@ - %@",[error localizedDescription],[error localizedFailureReason]]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}


- (void)handleNetworkTimeout:(NSTimer *)aTimer {
    
    [aTimer invalidate];
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"No network connection." forKey:NSLocalizedDescriptionKey];
    NSError*error = [NSError errorWithDomain:@"network" code:200 userInfo:details];
    [self hasError:error];
    
}

@end
