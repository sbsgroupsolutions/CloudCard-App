//
//  CreateGroup.h
//  CloudCar App
//
//  Created by Admin on 07/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//
#import "ConstantFinal.h"
#import <UIKit/UIKit.h>

@interface CreateGroup : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    MBProgressHUD *HUD;
    NSMutableArray * arrCreategroup;
    NSMutableArray * arrContactlist;
    NSString *base64String;
    UIImage *tempImage;
    NSString * imgUserUpload;
    IBOutlet UIImageView *imgUser;
    NSData *imageData;
    UIImage *img_Event;
    NSURL *ImgURL;

}
@property (strong, nonatomic) IBOutlet UIButton *btncard;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong , nonatomic) NSString * strmanagecont;
@property (strong , nonatomic) NSString * GroupNameCurName;
@property (strong , nonatomic) NSString * imgGroupCurrent;
@property (strong, nonatomic) NSData *imageDataClorn;


@property (strong , nonatomic) NSMutableArray * arrContactgroup;
@property (strong, nonatomic) IBOutlet UITableView *tblCreate;
@property (strong, nonatomic) IBOutlet UIImageView *imggroup;
- (IBAction)ActionCardAdd:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtgroup;
- (IBAction)ActionAddMember:(id)sender;
- (IBAction)ActionCard:(id)sender;
- (IBAction)ActionHome:(id)sender;
- (IBAction)ActionActiveGroup:(id)sender;
- (IBAction)ActionFrdList:(id)sender;
- (IBAction)ActionSetting:(id)sender;
- (IBAction)ActionGroupIcon:(id)sender;

@end
