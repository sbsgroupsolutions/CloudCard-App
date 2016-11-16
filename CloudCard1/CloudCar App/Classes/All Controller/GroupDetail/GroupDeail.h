//
//  GroupDeail.h
//  CloudCar App
//
//  Created by Admin on 23/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"
#import "MyprofileOb.h"
#import "GroupDCell.h"

@interface GroupDeail : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrhomelist;
    
}
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (strong, nonatomic) IBOutlet UITableView *tblHome;
@property (nonatomic,strong) NSString * strMedMember;
@property (nonatomic,strong) NSString * strMedGroupname;
@property (nonatomic,strong) NSString * strMedGroupicon;

@end
