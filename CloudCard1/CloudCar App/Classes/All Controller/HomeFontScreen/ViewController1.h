//
//  ViewController.h
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"
#import "MBProgressHUD.h"
#import "BSKeyboardControls.h"

@interface ViewController1 : UIViewController <UIAlertViewDelegate,UITextViewDelegate,BSKeyboardControlsDelegate> {
    BOOL FlagLogin;
    MBProgressHUD *HUD;
    NSString * useridCurrent;
    BOOL cursorPass,cursorPhone;

}
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (strong, nonatomic) IBOutlet UIView *viewloginbtn;
@property (strong, nonatomic) IBOutlet UIView *viewinner;
@property (strong, nonatomic) IBOutlet UITextField *txtPasswordLogin;
@property (strong, nonatomic) NSString * StrManageLogin;

@property (strong, nonatomic) IBOutlet UITextField *txtEmailid;
@property (strong, nonatomic) IBOutlet UIView *ViewWithoutLogin;

@property (strong, nonatomic) IBOutlet UIView *Viewlogin;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIButton *ActionSend;
- (IBAction)ActionSendBtn:(id)sender;
- (IBAction)ActionFacebook:(id)sender;
- (IBAction)ActionNewSign:(id)sender;
- (IBAction)ActionForgot:(id)sender;
- (IBAction)ActionLogin:(id)sender;
- (IBAction)ActionForgot:(id)sender;

@end

