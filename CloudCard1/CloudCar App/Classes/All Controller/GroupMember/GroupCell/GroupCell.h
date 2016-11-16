//
//  GroupCell.h
//  CloudCar App
//
//  Created by Admin on 23/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantFinal.h"

@interface GroupCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgUser;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *lblAdmin;

@end
