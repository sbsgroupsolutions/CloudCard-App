//
//  ViewController.m
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "ViewController1.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <Firebase.h>
@import Firebase;

@interface ViewController1 ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation ViewController1
@synthesize viewinner,viewloginbtn,Viewlogin;
@synthesize txtEmail,txtPassword;
@synthesize txtEmailid , txtPasswordLogin;
@synthesize StrManageLogin;
- (void)viewDidLoad {
    [super viewDidLoad];

    Viewlogin.layer.cornerRadius = 4.5;
    Viewlogin.layer.masksToBounds = YES;
    viewinner.layer.cornerRadius = 4.5;
    viewinner.layer.masksToBounds = YES;
    viewloginbtn.layer.cornerRadius = 4.5;
    viewloginbtn.layer.masksToBounds = YES;
    FlagLogin = NO;
    
    NSArray *fields = @[ txtEmailid,txtPasswordLogin];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    
    [self.keyboardControls setDelegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    //    [self setTextPhone:nil];
    //    [self setTextPassword:nil];
    [self setKeyboardControls:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnFrist:(id)sender {
}

- (void)viewDidAppear:(BOOL)animated {
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
     [self signedIn:user];
    } else if([StrManageLogin isEqualToString:@"Yes"]) {
    } else {
    }
}

- (IBAction)didRequestPasswordReset:(id)sender {
    UIAlertController *prompt =[UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Email:"  preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakPrompt = prompt;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UIAlertController *strongPrompt = weakPrompt;
    NSString *userInput = strongPrompt.textFields[0].text;
    if (!userInput.length) {
     return;
    }
    [[FIRAuth auth] sendPasswordResetWithEmail:userInput completion:^(NSError * _Nullable error) {
    if (error) {
    NSLog(@"%@", error.localizedDescription);
       return;
    } else {
        NSLog(@"%@");
    }
       }];
    }];
    [prompt addTextFieldWithConfigurationHandler:nil];
    [prompt addAction:okAction];
    [self presentViewController:prompt animated:YES completion:nil];
}

#pragma Sign Up

- (IBAction)ActionSendBtn:(id)sender {
    if(FlagLogin) {
       // _Viewlogin.hidden = YES;
       // _ViewWithoutLogin.hidden = NO;
        FlagLogin = NO;
    } else {
      //  _Viewlogin.hidden = NO;
      //  _ViewWithoutLogin.hidden = YES;
        FlagLogin = YES;
    }
  }

- (void)signedIn:(FIRUser *)user {

    NSString * userid = user.uid;
    useridCurrent = user.uid;

    NSString * displayName =user.displayName;
    NSString * email =user.email;
   // NSString * imageProfile =user.imageUrl;

   [AppState sharedInstance].signedIn = YES;
    [MeasurementHelper sendLoginEvent];
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    [VIP setObject:userid forKey:@"userid"];
    [VIP setObject:email forKey:@"email"];
    [VIP setObject:displayName forKey:@"displayName"];

    [AppState sharedInstance].displayName = user.displayName.length > 0 ? user.displayName : user.email;
    [AppState sharedInstance].photoUrl = user.photoURL;
    [AppState sharedInstance].signedIn = YES;
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL status = [firebaseAuth signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    Home *rootViewController = [[Home alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:YES];
    FIRUser *user1 = [FIRAuth auth].currentUser;
    NSString *name1 = user.displayName;
    NSString *email1 = user.email;
    NSURL *photoUrl1= user.photoURL;
    
    NSURL *photoUras= user.photoURL;
    [self CompFunct:userid];
    
}
-(void) CompFunct :(NSString *) usid{
    FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/"];
    // NSString *userID = [FIRAuth auth].currentUser.uid;
    [[ref child:@"users"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSDictionary *post = snapshot.value;
        
        NSString * ljlss =snapshot.value[@"fname"];
        // user *user = [[user alloc] initWithUsername:snapshot.value[@"username"]];
        NSString * cvxv =snapshot.value;
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

- (IBAction)ActionFacebook:(id)sender {
    FIRDatabaseReference *ref= [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/"];
    NSString *const read_actions = @"email";
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [loginManager logInWithReadPermissions:@[read_actions]
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
     if (error) {
                                           NSLog(@"Login Failed with error: %@", error.localizedDescription);
                                           
                                           Home *rootViewController = [[Home alloc] init];
                                           InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
                                           obj_HVC.topViewController =  rootViewController;
                                           [self.navigationController
                                            pushViewController:obj_HVC animated:YES];
                                       
                                       }
                                       else if (result.isCancelled) {
                                           NSLog(@"Login Failed due to Cancel");
                                       } else {
                                           if ([result.grantedPermissions containsObject:read_actions]) {
                                               NSLog(@"Permission granted");
                                               FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                                               NSLog(@"Credential%@",credential);
    [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error) {
        NSLog(@"user%@",user);
NSString *userid = user.uid;
NSString *providerID = user.providerID ;
NSString *email = user.email;
        NSString *sss = [FIRAuth auth]  ;
NSString *photoURL = user.photoURL ;
NSString *displayName = user.displayName;
NSMutableDictionary *providerData = user.providerData;
NSString *refreshToken = user.refreshToken;
NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
[VIP setObject:userid forKey:@"userid"];
[VIP setObject:email forKey:@"email"];
[VIP setObject:displayName forKey:@"displayName"];
[VIP setObject:providerID forKey:@"providerID"];
[VIP setObject:refreshToken forKey:@"refreshToken"];


        
//        FIRAuth *firebaseAuth = [FIRAuth auth];
//        NSError *signOutError;
//        BOOL status = [firebaseAuth signOut:&signOutError];
//        if (!status) {
//            NSLog(@"Error signing out: %@", signOutError);
//            return;
//        }
        [AppState sharedInstance].signedIn = false;
Home *rootViewController = [[Home alloc] init];
InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
                                                   obj_HVC.topViewController =  rootViewController;
                                                   [self.navigationController
                                                    pushViewController:obj_HVC animated:YES];
                                               }];

                                           }
                                       }
                                   }];
    
    
    
    
        
    
    
   /*
    
    FIRDatabaseReference *ref= [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/"];
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    [facebookLogin logInWithReadPermissions:@[@"email"]handler:^(FBSDKLoginManagerLoginResult *facebookResult, NSError *facebookError) {
        if (facebookError) {
            NSLog(@"Facebook login failed. Error: %@", facebookError);
        } else if (facebookResult.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
           // NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
            NSLog(@"Credential%@",credential);
            [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error) {
                NSLog(@"user%@",user);
                
                NSString *userid = user.uid;
                NSString *providerID = user.providerID ;
                NSString *email = user.email;
                NSString *photoURL = user.photoURL ;
                NSString *displayName = user.displayName;
                NSMutableDictionary *providerData = user.providerData;
                NSString *refreshToken = user.refreshToken;
                NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
                [VIP setObject:userid forKey:@"userid"];
                [VIP setObject:email forKey:@"email"];
                [VIP setObject:displayName forKey:@"displayName"];
                [VIP setObject:providerID forKey:@"providerID"];
                [VIP setObject:refreshToken forKey:@"refreshToken"];
                
                Home *rootViewController = [[Home alloc] init];
                InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
                obj_HVC.topViewController =  rootViewController;
                [self.navigationController
                 pushViewController:obj_HVC animated:YES];
            }];
        }
    }];
   */
}
-(void)Getuserdetail {
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"email,name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"email is %@", [result objectForKey:@"email"]);
             NSString * strfbemail = [result objectForKey:@"email"];
             NSString * strfbid = [result objectForKey:@"id"];
             NSString * strfbname = [result objectForKey:@"name"];
         } else {
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
}


- (IBAction)ActionNewSign:(id)sender {
    NewSignUp *rootViewController = [[NewSignUp alloc] init];
   [self.navigationController pushViewController:rootViewController animated:YES];
}

- (IBAction)ActionForgot:(id)sender {
    UIAlertController *prompt =
    [UIAlertController alertControllerWithTitle:nil
                                        message:@"Email:"
                                 preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakPrompt = prompt;
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   UIAlertController *strongPrompt = weakPrompt;
                                   NSString *userInput = strongPrompt.textFields[0].text;
                                   if (!userInput.length)
                                   {
                                       return;
                                   }
     [[FIRAuth auth] sendPasswordResetWithEmail:userInput completion:^(NSError * _Nullable error) {
       if (error) {
        NSLog(@"%@", error.localizedDescription);
       return;
       } else {
           UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Password reset link has been sent successfully please check your Email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
           [av show];
           [HUD hide:YES];
           return;
       }
         }];
                                   
                               }];
    [prompt addTextFieldWithConfigurationHandler:nil];
    [prompt addAction:okAction];
    [self presentViewController:prompt animated:YES completion:nil];
}
-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    // HUD.detailsLabelText = @"Registration..";
    HUD.square = YES;
    [HUD show:YES];
    
}

- (IBAction)ActionLogin:(id)sender {
    
    // Sign In with credentials.
    NSString *email = txtEmailid.text;
    NSString *password = txtPasswordLogin.text;
    
    
    BOOL isValidEmail = [JRTextHelper textIsValidEmailFormat:txtEmailid.text];
    if(!isValidEmail){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Valid email id!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    } else if(txtPasswordLogin.text == nil || [txtPasswordLogin.text isEqualToString:@""]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Password!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    } else {
    [self progressBar];
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                             if (error) {
                                 NSLog(@"%@", error.localizedDescription);
                                 UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                 [av show];
                                 [HUD hide:YES];
                                 return;
                                 return;
                             }
                             [self signedIn:user];
                         }];

    }
    
}

-(IBAction)hidekey:(id)sender {
    [sender resignFirstResponder];
}

-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtEmailid) {
        cursorPass = true;
        cursorPhone = false;
    } else if (textField == txtPasswordLogin) {
        cursorPhone = true;
        cursorPass = false;
    }
    [self.keyboardControls setActiveField:textField];
    [self animateTextField:txtPasswordLogin up:YES];
    [self animateTextField:txtEmailid up:YES];

}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:txtEmailid up:NO];
    [self animateTextField:txtPasswordLogin up:NO];
}

#pragma mark Keyboard Controls Delegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        view = field.superview.superview;
    } else {
        view = field.superview.superview.superview;
    }
    
    //[self.tableView scrollRectToVisible:view.frame animated:YES];
}


- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
        [self.view endEditing:YES];
}


@end
