//
//  FSWelcomeViewController.m
//  Foosed
//
//  Created by Ramsel.
//

#import "FSWelcomeViewController.h"
#import "FSLoginViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface FSWelcomeViewController ()



@end

@implementation FSWelcomeViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // View Stuffs
    UIImageView* backgroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    [self.view addSubview:backgroudImageView];
    [self.view sendSubviewToBack:backgroudImageView];
   
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
    // If not logged in, present login view controller
    if ([self presentLoginViewController]
        && [appDel respondsToSelector:@selector(presentLoginViewControllerAnimated:withDismissButton:)]) {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO withDismissButton:NO];
        return;
    }
    
    else {
        
        // Or else just start the app if everything checks out
        if ([appDel respondsToSelector:@selector(userHasLoggedIn)]) {
            [appDel userHasLoggedIn];
        }
    }
    
    
    
    // Refresh current user with server side data -- checks if user is still valid and so on
    if ([User currentUser]) {
    
        [[User currentUser] fetchInBackgroundWithTarget:self selector:@selector(refreshCurrentUserCallbackWithResult:error:)];
        
    }
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"welcomeToLogin"])
    {
        FSLoginViewController *loginVC = [segue destinationViewController];        
        loginVC.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    }
}


#pragma mark - ()
- (BOOL)presentLoginViewController {
    
    if (![User currentUser] || [PFAnonymousUtils isLinkedWithUser:[User currentUser]]) {
    
        return YES;
    }

    return NO;
}



- (void)refreshCurrentUserCallbackWithResult:(PFObject *)refreshedObject error:(NSError *)error {
    
    // A kPFErrorObjectNotFound error on currentUser refresh signals a deleted user
    if (error && error.code == kPFErrorObjectNotFound) {
        NSLog(@"User does not exist.");
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] logOut];
        return;
    }
}



@end
