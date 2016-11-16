//
//  Constant.h
//  HealthOnPhone
//
//  Created by Akhilesh Mourya on 10/13/14.
//  Copyright (c) 2014 Akhilesh Mourya. All rights reserved.
//

#define _AlertView_With_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertView_WithOut_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}


#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define KeyboardHeight 140



#import "ECSlidingViewController.h"
#import "InitialSlidingViewController.h"
#import "MenuViewController.h"
#import "ModelClass.h"
#import "AppDelegate.h"
#import "AppState.h"
#import "Constants.h"
#import "MeasurementHelper.h"
#import "ConstantFinal.h"
#import "NewSignUp.h"
#import "Home.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ContactNumber.h"
#import "CreateGroup.h"
#import "ContactNo.h"
#import "Setting.h"
#import "Support.h"
#import "ActiveGroup.h"
#import "GroupMember.h"
#import "GroupDeail.h"
#import "GroupCell.h"
#import "Profile.h"
#import "CardAdd.h"


#import <GoogleSignIn/GoogleSignIn.h>
@class GIDSignInButton;

#import "JRTextHelper.h"
#import "MBProgressHUD.h"

#import "MyprofileOb.h"

#import "HomeCellTableViewCell.h"
#import "CustomContactList.h"
#import "HeaderFb.h"
#import "SignUpCell.h"
#import "SignupSecond.h"
#import "Footer.h"
#import "GroupCell.h"
#import "CustomPdf.h"

#import <Firebase.h>
#import <Firebase/Firebase.h>

#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
