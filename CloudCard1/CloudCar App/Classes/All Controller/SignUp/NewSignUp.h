//
//  NewSignUp.h
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//
#import "BSKeyboardControls.h"

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"
#import "MBProgressHUD.h"

@interface NewSignUp : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BSKeyboardControlsDelegate> {
    MBProgressHUD *HUD;
    NSURL * downloadURL;
    NSString *base64String;
    NSMutableArray * arrSignlist;
    NSInteger indexpathmanage;
    BOOL Flagindex;
    BOOL Flagindexsec;
    UITextField *txtName;
    UIImage *tempImage;
    NSString * imgUserUpload;
    NSString *fname,*lstname,*username,*email,*password,*reemail,*repassword, *carinfo, *nameyourcard,*nameoncard,*carno,*exdate,*secuityno,*Addothercard,*go,*mobileno;
    NSString  *carinfo1, *nameyourcard1,*nameoncard1,*carno1,*exdate1,*secuityno1;
    NSString  *carinfo2, *nameyourcard2,*nameoncard2,*carno2,*exdate2,*secuityno2;
    IBOutlet UIScrollView *SCROLLVIEW;
    IBOutlet UIImageView *imgUser;
    NSData *imageData; UIImage *img_Event;
    NSURL *ImgURL;
    NSMutableArray *fields ;
    BOOL cursorPass,cursorPhone;
 
}
- (IBAction)ActionUploadimage:(id)sender;
- (IBAction)ActionBack:(id)sender;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@property (nonatomic, assign) id currentResponder;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) NSString *strTablemanage;


@property (strong, nonatomic) IBOutlet UITableView *tblSign;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@end
