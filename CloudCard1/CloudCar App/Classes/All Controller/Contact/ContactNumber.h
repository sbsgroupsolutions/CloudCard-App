//
//  ViewForNeighborhood.h
//  Neighbourhood
//
//  Created by Manoj jonna on 17/03/16.
//  Copyright © 2016 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constant.h"
#import <AddressBook/AddressBook.h>

@protocol ContactNumberDelegate <NSObject>
-(void)drawData1:(NSString *)flagvalue;

@end
@interface ContactNumber : UIView <UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>  {
    
    __weak IBOutlet UIView *viewContact;
    IBOutlet UITableView*tblViewForFriends;
    NSMutableArray*arrForConnectFriends;
    NSArray*sortedArray;
    NSUserDefaults *def;
    NSMutableArray * arrimage, * arrCheckSelect;
    NSMutableArray *arr2;
    NSMutableArray *image_array;
    BOOL search_flag;
    NSMutableString * str;
    NSMutableString *strLL;
    BOOL flagmanage;
    NSMutableArray * arrTailgate , * arrSearchFrdsList ;
    
}
- (IBAction)PostAction:(id)sender;
- (IBAction)BackAction:(id)sender;
-(void)drawData1:(NSString *)flagvalue;
@property (nonatomic, assign) id <ContactNumberDelegate> ContactNumberDelegate;
@property(strong,nonatomic)UINavigationController*navController;
@property(strong,nonatomic)NSString*strForCommingFrom;
-(IBAction)actionForConnectBtn:(id)sender;


@end
