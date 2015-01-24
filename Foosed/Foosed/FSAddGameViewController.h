//
//  FSAddGameViewController.h
//  Foosed
//
//  Created by Admin on 1/23/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseViewController.h"

@interface FSAddGameViewController : FSBaseViewController 

@property (weak, nonatomic) IBOutlet UILabel *scoreLabelA;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabelB;

@property (weak, nonatomic) IBOutlet UIStepper *stepperA;
@property (weak, nonatomic) IBOutlet UIStepper *stepperB;


@property (weak, nonatomic) IBOutlet UITextField *usernameTextFieldA;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextFieldB;

@property (weak, nonatomic) IBOutlet UIButton *pickUserButtonA;
@property (weak, nonatomic) IBOutlet UIButton *pickUserButtonB;
@property (weak, nonatomic) IBOutlet UIPickerView *userPickerA;
@property (weak, nonatomic) IBOutlet UIPickerView *userPickerB;

@property (weak, nonatomic) IBOutlet UIButton *addNewUserButtonA;
@property (weak, nonatomic) IBOutlet UIButton *addNewUserButtonB;

@property (weak, nonatomic) IBOutlet UIButton *footerButton;

- (IBAction)didTapAddExistingUserA:(id)sender;
- (IBAction)didTapAddExistingUserB:(id)sender;


- (IBAction)didTapAddNewUserA:(id)sender;
- (IBAction)didTapAddNewUserB:(id)sender;


- (IBAction)didTapFooterButton:(id)sender;

@end
