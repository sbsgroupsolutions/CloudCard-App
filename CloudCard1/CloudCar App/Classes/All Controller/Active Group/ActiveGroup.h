//
//  ActiveGroup.h
//  CloudCar App
//
//  Created by Admin on 15/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"
#import <AddressBook/AddressBook.h>
#import "UIImageView+WebCache.h"


@interface ActiveGroup :UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>  {
    MBProgressHUD *HUD;
    NSMutableArray * arrGroup;
    NSMutableArray * mArrAppContDetail1;
    NSMutableArray * arrCreategroup ;
    
    NSMutableArray * arrContact ;
    FIRDatabaseReference * commentsRef;
    __weak IBOutlet UIView *viewContact;
    IBOutlet UITableView*tblViewForFriends;
    NSMutableArray*arrForConnectFriends;
    NSArray*sortedArray;
    NSUserDefaults *def;
    NSMutableArray * arrimage, * arrCheckSelect ,* arrCheckgroup;
    NSMutableArray *arr2;
    NSMutableArray *image_array;
    BOOL search_flag;
    NSMutableString * str;
    NSMutableString *strLL;
    BOOL flagmanage;
    NSMutableArray * arrTailgate , * arrSearchFrdsList ;
    
}
- (IBAction)ActionDone:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgupload;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
- (IBAction)PostAction:(id)sender;
- (IBAction)BackAction:(id)sender;
-(void)drawData1:(NSString *)flagvalue;
@property (nonatomic, assign) id <ContactNumberDelegate> ContactNumberDelegate;
@property(strong,nonatomic)UINavigationController*navController;
@property(strong,nonatomic)NSString * strForCommingFrom;
@property(strong,nonatomic)NSString * strContactlist;

-(IBAction)actionForConnectBtn:(id)sender;

@end
