//
//  ViewController.m
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "ViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <Firebase.h>
@import Firebase;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation ViewController
@synthesize txtEmail,txtPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFrist:(id)sender {
}

- (void)viewDidAppear:(BOOL)animated {
    //FIRUser *user = [FIRAuth auth].currentUser;
    //if (user) {
       // [self signedIn:user];
   // }
}

- (IBAction)didTapSignIn:(id)sender {
    // Sign In with credentials.
    NSString *email = txtEmail.text;
    NSString *password = txtPassword.text;
    [[FIRAuth auth] signInWithEmail:email password:password
    completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
    if (error) {
       NSLog(@"%@", error.localizedDescription);
       return;
     }
    [self signedIn:user];
    }];
}

- (IBAction)didTapSignUp:(id)sender {
    NSString *email = txtEmail.text;
    NSString *password = txtPassword.text;
    [[FIRAuth auth] createUserWithEmail:email password:password
    completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
    if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
       }
     [self setDisplayName:user];
     }];
}

- (IBAction)didRequestPasswordReset:(id)sender {
    UIAlertController *prompt =[UIAlertController alertControllerWithTitle:nil
    message:@"Email:"  preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakPrompt = prompt;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
    style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UIAlertController *strongPrompt = weakPrompt;
    NSString *userInput = strongPrompt.textFields[0].text;
    if (!userInput.length) {
       return;
    }
    [[FIRAuth auth] sendPasswordResetWithEmail:userInput completion:^(NSError * _Nullable error) {
        if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
          }
        }];
     }];
    [prompt addTextFieldWithConfigurationHandler:nil];
    [prompt addAction:okAction];
    [self presentViewController:prompt animated:YES completion:nil];
}

#pragma Sign Up

- (IBAction)ActionSendBtn:(id)sender {
    NSString *email = txtEmail.text;
    NSString *password = txtPassword.text;
    [[FIRAuth auth] createUserWithEmail:email password:password
    completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
    if (error) {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesButton=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
         }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        return;
             }
        [self setDisplayName:user];
        }];
}

- (void)signedIn:(FIRUser *)user {
    [MeasurementHelper sendLoginEvent];
    
    [AppState sharedInstance].displayName = user.displayName.length > 0 ? user.displayName : user.email;
    [AppState sharedInstance].photoUrl = user.photoURL;
    [AppState sharedInstance].signedIn = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationKeysSignedIn object:nil userInfo:nil];
    [self performSegueWithIdentifier:SeguesSignInToFp sender:nil];
}

- (void)setDisplayName:(FIRUser *)user {
    FIRUserProfileChangeRequest *changeRequest =
    [user profileChangeRequest];
    // Use first part of email as the default display name
    changeRequest.displayName = [[user.email componentsSeparatedByString:@"@"] objectAtIndex:0];
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        [self signedIn:[FIRAuth auth].currentUser];
    }];
}

- (IBAction)ActionFacebook:(id)sender {
    
//    Home *objFrdslist = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
//    [self.navigationController pushViewController:objFrdslist animated:NO];
 
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
        
        Home *objFrdslist = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
        [self.navigationController pushViewController:objFrdslist animated:NO];

        
        NSString *userid = user.uid;
        NSString *providerID = user.providerID ;
        NSString *email = user.email;
        NSString *photoURL = user.photoURL ;
        NSString *displayName = user.displayName;
        NSMutableDictionary *providerData = user.providerData;
        
       // NSString *useridd = providerData[@"_userid"];
        NSString *refreshToken = user.refreshToken;

//        NSMutableDictionary *UserInfo = [[NSMutableDictionary alloc] init];
//        [UserInfo setObject:userid forKey:@"userid"];
//        [UserInfo setObject:email forKey:@"email"];
//        [UserInfo setObject:photoURL forKey:@"photoURL"];
//        [UserInfo setObject:displayName forKey:@"displayName"];
//        [UserInfo setObject:providerData forKey:@"providerData"];
//       // [UserInfo setObject:useridd forKey:@"useridd"];
//        [UserInfo setObject:providerID forKey:@"providerID"];
//        [UserInfo setObject:refreshToken forKey:@"refreshToken"];

        NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
        [VIP setObject:userid forKey:@"userid"];
        [VIP setObject:email forKey:@"email"];
        //[VIP setObject:photoURL forKey:@"photoURL"];
        [VIP setObject:displayName forKey:@"displayName"];
       // [VIP setObject:providerData forKey:@"providerData"];
        [VIP setObject:providerID forKey:@"providerID"];
        [VIP setObject:refreshToken forKey:@"refreshToken"];
        }];
     }
   }];

}
-(void)Getuserdetail{
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"email,name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"email is %@", [result objectForKey:@"email"]);
             NSString * strfbemail = [result objectForKey:@"email"];
             NSString * strfbid = [result objectForKey:@"id"];
             NSString * strfbname = [result objectForKey:@"name"];
            }
         else{
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
}


- (IBAction)ActionNewSign:(id)sender {
//    NewSignUp *obsign = [self.storyboard instantiateViewControllerWithIdentifier:@"NewSignUp"];
//    [self.navigationController pushViewController:obsign animated:YES];
//    
    NewSignUp *objFrdslist = [self.storyboard instantiateViewControllerWithIdentifier:@"NewSignUp"];
    [self.navigationController pushViewController:objFrdslist animated:NO];
}

- (IBAction)ActionForgot:(id)sender {
}
@end
