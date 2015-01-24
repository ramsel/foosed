//
//  FSAddGameViewController.m
//  Foosed
//
//  Created by Admin on 1/23/15.
//  Copyright (c) 2015 Ramsel. All rights reserved.
//

#import "FSAddGameViewController.h"
#import "FSUtility.h"
#import "DAKeyboardControl.h"
#import "MBProgressHUD.h"

@interface FSAddGameViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSArray* users;

@property (nonatomic, strong) Game* game;


@end

@implementation FSAddGameViewController

#pragma mark - Init

- (NSArray*) users
{
    if (!_users){
        
        _users = [NSArray new];
    }
    return _users;
}



#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.accessibilityLabel = @"Back Button";
    backButton.frame = CGRectMake( 0.0f, 0.0f, kNavBarBackButtonDim, kNavBarBackButtonDim);
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:kFSBackButtonWhiteIcon] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:kFSBackButtonWhiteIcon] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];


    
    // Dismiss keyboard on scroll
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
   
    } constraintBasedActionHandler:nil];
    

    
    // Init game
    Game* game = [[Game alloc] initWithZeroedScores];
    self.game = game;

   
    [self loadUsers];

}


#pragma mark - Data
- (void) loadUsers {
    
    // HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Users";
    
    // If more than 5 seconds pass since we post a comment, stop waiting for the server to respond
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(handleNetworkTimeout:) userInfo:nil repeats:NO];

    
    // Get all user
    [FSDatabaseManager queryForUsersWithCallback:^(NSArray *objects, NSError *error) {
        
        [hud hide:YES];
        [timer invalidate];

        if (error) {
            [self hasError:error];
            return;
        }
        
        // Show alert if no users
        if (objects.count < 1) {
                NSMutableDictionary* details = [NSMutableDictionary dictionary];
                [details setValue:@"There are no users. Please add one." forKey:NSLocalizedDescriptionKey];
                NSError*error = [NSError errorWithDomain:@"users" code:200 userInfo:details];
                [self hasError:error];
                return;
        }

        self.users = objects;

        [self objectsDidLoad];

    }];
}



- (void) objectsDidLoad {

    // Picker
    self.userPickerA.dataSource = self;
    self.userPickerA.delegate = self;
    
    self.userPickerB.dataSource = self;
    self.userPickerB.delegate = self;
    
    
    // Steppers
    [self.stepperA addTarget:self
                       action:@selector(stepperDidStep:)
            forControlEvents:UIControlEventValueChanged];
    
    [self.stepperB addTarget:self
                      action:@selector(stepperDidStep:)
            forControlEvents:UIControlEventValueChanged];

}

- (void)addUser:(NSString*)username teamIndex:(FSGameTeamIndex)teamIndex{
    
    User* user = [self getExistingUserWithName:username];

    // Add User to Game
    if (teamIndex == FSGameTeamA) {
        [self.game addUniqueObject:user forKey:[Game teamAKey]];
    }
    else {
        [self.game addUniqueObject:user forKey:[Game teamBKey]];
    }
    

}


- (User*)getExistingUserWithName:(NSString*)username {
    
    __block User* foundUser;
    
    [self.users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        User* userToCheck = (User*)obj;
        if ([userToCheck.username isEqualToString:username]) {
            foundUser = userToCheck;
            *stop = YES;
        }
    }];
    
    return foundUser;
}

- (void)checkForCompletion {
    
    // Check that all data is entered
    if (
        self.game.teamA.count < 1 ||
        self.game.teamB.count < 1
        ) {
        return;
    }
    
    self.footerButton.hidden = NO;
    
}

- (void)saveGame {
    
    // disable footerButton
    self.footerButton.userInteractionEnabled = NO;
    
    
    // HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Saving";

    
    // calculate winner
    FSGameTeamIndex winners = [FSUtility calculateWinners:self.game];
    self.game.winners = [NSNumber numberWithInt:winners];
    

    
    [FSDatabaseManager saveObject:self.game callback:^(BOOL succeeded, NSError *error) {
        
        [hud hide:YES];
        self.footerButton.userInteractionEnabled = YES;
        
        if (error) {
            [self hasError:error];
            return;
        }
        
        // Send a notif to
        NSDictionary *userInfo = @{WSNotifDidAddGameObjectKey: self.game};
        [[NSNotificationCenter defaultCenter] postNotificationName:WSNotifDidAddGame object:self userInfo:userInfo];
        
        
        // increment winners count
        if (winners == FSGameTeamA) {
            [self incrementWinners:self.game.teamA];
        }
        else if (winners == FSGameTeamB) {
            [self incrementWinners:self.game.teamB];
        }
        
        // dismiss
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}


- (void) incrementWinners:(NSArray*)winners {
    
    [winners enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        User* user = (User*)obj;
        
        [user incrementKey:[User winsKey]];
        [FSDatabaseManager saveObject:user callback:^(BOOL succeeded, NSError *error) {}];
    }];
    
}


#pragma mark - PickerView
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.users.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    User* user = self.users[row];
    
    return user.username;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    User* user = (User*)[self.users objectAtIndex:row];
    if (!user) return;
    
    pickerView.hidden = YES;
    
    // Add User to Game
    if (pickerView.tag == 0) {
        NSArray* teamA = @[user];
        self.game.teamA = teamA;
        self.usernameTextFieldA.text = user.username;

    }
    else {
        NSArray* teamB = @[user];
        self.game.teamB = teamB;
        self.usernameTextFieldB.text = user.username;
    }
    
    [self checkForCompletion];
    
}

#pragma - UIStepper
- (void)stepperDidStep:(UIStepper *)sender {
    
    if([sender isKindOfClass:[UIStepper class]]) {
        double value = [(UIStepper *)sender value];
        
        if (sender.tag == FSGameTeamA) {
            self.game.scoreA = [NSNumber numberWithDouble:value];
            self.scoreLabelA.text = [@(value) stringValue];
        }
        else {
            self.game.scoreB = [NSNumber numberWithDouble:value];
            self.scoreLabelB.text = [@(value) stringValue];
        }
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // Check for empty field
    if (textField.text.length < 1) return;
    
    // Check if user exists
    if (![self getExistingUserWithName:textField.text]) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"That user does not exist" forKey:NSLocalizedDescriptionKey];
        NSError*error = [NSError errorWithDomain:@"users" code:200 userInfo:details];
        [self hasError:error];
        
        // clear field
        textField.text = nil;
        return;
    }
    

    [self addUser:textField.text teamIndex:(FSGameTeamIndex)textField.tag];
    
    [self checkForCompletion];
}



#pragma mark - Actions
- (IBAction)didTapAddExistingUserA:(id)sender {
    self.userPickerA.hidden = NO;
}

- (IBAction)didTapAddExistingUserB:(id)sender {
    self.userPickerB.hidden = NO;

}

- (IBAction)didTapAddNewUserA:(id)sender {
    [self.usernameTextFieldA becomeFirstResponder];
    
}

- (IBAction)didTapAddNewUserB:(id)sender {
    [self.usernameTextFieldB becomeFirstResponder];
}

- (IBAction)didTapFooterButton:(id)sender {
    
    [self saveGame];
    
}




@end
