//
//  Profile.h
//  CloudCar App
//
//  Created by Admin on 28/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"

@interface Profile : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrProlist;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tblProfile;
@property (strong, nonatomic) IBOutlet UIImageView *imgIcon;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtLast;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtstatus;
- (IBAction)ActionEditInfo:(id)sender;

@end
