//
//  ContactNo.m
//  CloudCar App
//
//  Created by Admin on 05/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "ActiveGroup.h"

@interface ActiveGroup ()

@end

@implementation ActiveGroup
@synthesize ContactNumberDelegate;
@synthesize strForCommingFrom;
@synthesize strContactlist;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CompFunct];

    arrGroup = [[NSMutableArray alloc]init];
    strLL =[[NSMutableString alloc] init];
    arrCheckSelect = [NSMutableArray new];
    arrCheckgroup = [NSMutableArray new];
    [tblViewForFriends setDelegate:self];
    [tblViewForFriends setDataSource:self];
    
    tblViewForFriends.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    arrForConnectFriends=[[NSMutableArray alloc] init];
    arrForConnectFriends=[[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
    arrGroup = [[NSMutableArray alloc]init];
    arrContact = [[NSMutableArray alloc]init];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PostAction:(id)sender {
}

- (IBAction)BackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)drawData1:(NSString *)flagvalue {
    
}

- (IBAction)ActionHOme:(id)sender {
    Home *rootViewController = [[Home alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionGroupuser:(id)sender {
    ActiveGroup *rootViewController = [[ActiveGroup alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionInvited:(id)sender {

    ContactNo *rootViewController = [[ContactNo alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionSetting:(id)sender {
    Setting *rootViewController = [[Setting alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

#pragma mark phone contacts method:-----

-(void) CompFunct {
    [self progressBar];
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    NSString * usserId = [VIP objectForKey:@"userid"];
    mArrAppContDetail1 = [[NSMutableArray alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"https://cloudcard-1d03b.firebaseio.com/GroupCreateTable"];
    FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:strUrl];
    [[[ref queryOrderedByChild:@"Adminuserid"]queryEqualToValue:usserId]
         observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {

        NSDictionary *post = snapshot.value;
        NSInteger  div1 = snapshot.childrenCount;
        NSString * div;
        NSString *string;
        for (FIRDataSnapshot *child in snapshot.children) {
            div = child.key;
            NSDictionary * dict1 = snapshot.value;
            NSMutableArray * mutableArray1 = dict1[div];
            NSMutableDictionary * dict = dict1[div];
            ModelClass *obj = [[ModelClass alloc]init];
            obj.groupUserid = [dict valueForKey:@"Adminuserid"];
            obj.GroupName  = [dict valueForKey:@"GroupName"];
            obj.MemberId = [dict valueForKey:@"MemberId"];
            obj.groupIcon = [dict valueForKey:@"GroupIcon"];
            string = [dict valueForKey:@"MemberId"];
            obj.status = [dict valueForKey:@"status"];
            [mArrAppContDetail1 addObject:obj];
        }
        [tblViewForFriends reloadData];
            if([mArrAppContDetail1 count] == 0) {
                UIAlertController * alert =   [UIAlertController
                                              alertControllerWithTitle:@""
                                              message:@"No Group Available"
                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                }];
                [alert addAction:okAction];
                UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                [vc presentViewController:alert animated:YES completion:nil];
            } else {
            }
    }];
    [HUD hide:YES];

}

-(void)progressBar {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [HUD show:YES];
}

#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mArrAppContDetail1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId=@"cellId";
    CustomContactList *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"CustomContactList" owner:self options:nil];
        cell=[ar lastObject];
    }
        ModelClass * obj = [mArrAppContDetail1 objectAtIndex:indexPath.row];
        cell.imgCDFUser.hidden = NO;
        cell.lblCDFName.hidden = NO;
        cell.lblForName.hidden = YES;
        cell.imgCDFUser.layer.cornerRadius = cell.imgCDFUser.frame.size.height/2;
        cell.imgCDFUser.layer.borderWidth = 0.5;
        cell.imgCDFUser.clipsToBounds = YES;
        cell.imgCDFUser.layer.borderColor = [UIColor whiteColor].CGColor;
        NSString * imgelink = [NSString stringWithFormat:@"%@",obj.groupIcon];

    NSURL *url = [NSURL URLWithString:imgelink];
    [cell.imgCDFUser setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"user.png"]];
          [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
       NSString *myString = [NSString stringWithFormat:@"%@",obj.GroupName];
       NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
      NSRange range = [myString rangeOfString:@"Member : "];
      [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
     cell.lblCDFName.attributedText = attString;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelClass * obj = [mArrAppContDetail1 objectAtIndex:indexPath.row];
    NSString *myString = [NSString stringWithFormat:@"%@",obj.GroupName];
    NSString *myString1 = [NSString stringWithFormat:@"%@",obj.MemberId];
    NSString * imgeicon = [NSString stringWithFormat:@"%@",obj.groupIcon];
    
    GroupDeail *Cobj = [[GroupDeail alloc] init];
    Cobj.strMedMember = myString1;
    Cobj.strMedGroupname= myString;
    Cobj.strMedGroupicon= imgeicon;
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  Cobj;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
   }

-(void) Group {
}

/*
 NSString *strUrl1 = [NSString stringWithFormat:@"https://cloudcard-1d03b.firebaseio.com/users"];
 FIRDatabaseReference *ref1 = [[FIRDatabase database] referenceFromURL:strUrl1];
 [[ref1 queryOrderedByChild:string]
 observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
 
 NSLog(@"%@ was %@ meters tall", snapshot.key, snapshot.value[@"height"]);
 }];
 

 */
- (IBAction)ActionDone:(id)sender {
    if([strContactlist isEqualToString:@"Yes"]) {
        NSMutableArray * arrConDetail = [[NSMutableArray alloc]init];
        for (int i =0 ; i < [arrGroup count]; i++) {
            NSDictionary * dict = [arrGroup objectAtIndex:i];
            if ([dict  isEqual: @"0"]) {
            } else {
                [arrConDetail addObject:dict];
            }
            
        }
        
        CreateGroup *rootViewController = [[CreateGroup alloc] init];
        rootViewController.arrContactgroup = arrConDetail;
        rootViewController.strmanagecont = @"YES";
        InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_HVC.topViewController =  rootViewController;
        [self.navigationController
         pushViewController:obj_HVC animated:NO];
        
    } else {
        
    }
    // [self.navigationController popViewControllerAnimated:NO];
    
}
@end
