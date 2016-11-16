//
//  ViewController.h
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"

@interface ViewController : UIViewController <UIAlertViewDelegate> {
  
}

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIButton *ActionSend;
- (IBAction)ActionSendBtn:(id)sender;
- (IBAction)ActionFacebook:(id)sender;
- (IBAction)ActionNewSign:(id)sender;
- (IBAction)ActionForgot:(id)sender;

@end

