//
//  GroupMember.h
//  CloudCar App
//
//  Created by Admin on 23/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"

@interface GroupMember : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView*tblViewForFriends;
    NSMutableArray*arrForConnectFriends;
}
- (IBAction)ActionContact:(id)sender;
- (IBAction)ActionSetting:(id)sender;
- (IBAction)ActionActiveGroup:(id)sender;
- (IBAction)ActionHome:(id)sender;
- (IBAction)ActionBack:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (nonatomic,strong) NSString * strMember;
@property (nonatomic,strong) NSString * strGroupname;

@property (nonatomic,strong) NSMutableArray * arrGroupmember;
@end
