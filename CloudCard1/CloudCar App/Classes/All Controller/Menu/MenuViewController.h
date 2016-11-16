//
//  MenuViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"
#import "ECSlidingViewController.h"
@class HomeViewController;

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate> {
    CGRect screenSize;
    NSUserDefaults *obj_NSUD;
    int PrevScreen;
    IBOutlet UILabel *lblUserName;
}
- (IBAction)ActionProfile:(id)sender;
-(IBAction)homebtn:(id)sender;
-(IBAction)Loginbtn:(id)sender;
-(IBAction)Articlebtn:(id)sender;
-(IBAction)pdfbtn:(id)sender;
-(IBAction)youtubebtn:(id)sender;
-(IBAction)magazinebtn:(id)sender;
-(IBAction)contactbtn:(id)sender;
@property (nonatomic, retain)  HomeViewController *obj_HVC;
@property (nonatomic, retain) IBOutlet UITableView *tv;
- (IBAction)ActionSignUp:(id)sender;

@end
