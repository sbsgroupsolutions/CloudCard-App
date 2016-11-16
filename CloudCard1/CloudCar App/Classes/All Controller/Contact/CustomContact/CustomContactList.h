//
//  CustomContactList.h
//  Neighbourhood
//
//  Created by Deepak on 27/05/16.
//  Copyright © 2016 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomContactList : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblCDFName;
@property (strong, nonatomic) IBOutlet UIImageView *imgCDFUser;

@property (weak, nonatomic) IBOutlet UILabel *lblForName;
@property (weak, nonatomic) IBOutlet UIButton *btnForCheckUncheck;
@property (weak, nonatomic) IBOutlet UIButton *asyncImageProfile;
@end
