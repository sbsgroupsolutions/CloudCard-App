//
//  Home.m
//  CloudCar App
//
//  Created by Admin on 02/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"

@interface Home ()

@end

@implementation Home
@synthesize mapview,logi,lati;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
     NSString * displayName = [VIP objectForKey:@"displayName"];
   
    _lblName.text = [NSString stringWithFormat:@"Welcome(%@)",displayName];
    
    if([displayName isEqualToString:@""]) {
        ViewController *objFrdslist = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:objFrdslist animated:NO];
        
    } else {
        //        Home *objFrdslist = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
        //        [self.navigationController pushViewController:objFrdslist animated:NO];
        
    }
   // [self createData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnMenu:(id)sender {
//    SWRevealViewController *revealViewController =    self.revealViewController;
//    [revealViewController revealToggle:self];
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}


- (void) createData {
    arrLikelist = [NSMutableArray new];
    arrhomelist = [NSMutableArray new];
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"First Name";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Last Name";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"User Name";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Email";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Re-enter Email";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Password";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Re-enter Password";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Card Information";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Name Your Card";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Name on Card";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Card Number";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Exp.Date";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Security Number";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Add Another Card";
        [arrhomelist addObject:ob];
    }
    
    [_tblHome reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [arrhomelist count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    HomeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"HomeCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    self.tblHome.separatorStyle = UITableViewCellSeparatorStyleNone;
    ModelClass * obj = [arrhomelist objectAtIndex:indexPath.row];
//    NSString * myString = [NSString stringWithFormat:@"%@",obj.GroupName];
//    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:myString];
//    NSRange range = [myString rangeOfString:@"Member : "];
//    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
//    cell.lblname.attributedText = attString;
    
    NSString *redText =obj.GroupName;
    NSString *greenText = @"has checked into";
    NSString *purpleBoldText = @"Geo Tag";
    NSString *text = [NSString stringWithFormat:@"%@ %@ (%@)",
                      redText,greenText,purpleBoldText];
    NSDictionary *attribs = @{NSForegroundColorAttributeName: cell.lblname.textColor,
                                  NSFontAttributeName: cell.lblname.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
    // Red text attributes
    UIColor *redColor = [UIColor blackColor];
    NSRange redTextRange = [text rangeOfString:redText];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:redColor ,NSFontAttributeName:[UIFont fontWithName:@"Michroma" size:12.0f]} range:redTextRange];
    // Green text attributes
    UIColor *greenColor = [UIColor lightGrayColor];
    NSRange greenTextRange = [text rangeOfString:greenText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor,NSFontAttributeName:[UIFont fontWithName:@"Michroma" size:12.0f]}
                                range:greenTextRange];
    // Purple and bold text attributes
    UIColor *purpleColor = [UIColor blackColor];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:cell.lblname.font.pointSize];
    NSRange purpleBoldTextRange = [text rangeOfString:purpleBoldText];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
    [attributedText setAttributes:@{NSForegroundColorAttributeName:purpleColor,
                                        NSFontAttributeName:boldFont}
                                range:purpleBoldTextRange];
    cell.lblname.attributedText = attributedText;
    
    [cell.btnSay setTag:indexPath.row];
    [cell.btnSay addTarget:self action:@selector(Likew:) forControlEvents:UIControlEventTouchUpInside];

    [cell.ActionLike setTag:indexPath.row];
    [cell.ActionLike addTarget:self action:@selector(Like:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.ActionUnlike setTag:indexPath.row];
    [cell.ActionUnlike addTarget:self action:@selector(UnLike:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)LateGoFinal:(UIButton*)sender {
    ContactNo * obj = [[ContactNo alloc] init];
    [self.navigationController pushViewController:obj animated:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self CompFunct];
}

-(void) CompFunct {
    [self progressBar];
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    NSString * usserId = [VIP objectForKey:@"userid"];
    arrhomelist = [[NSMutableArray alloc]init];
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
             obj.groupPrimaryKey = [NSString stringWithFormat:@"%@",div];
             obj.groupUserid = [dict valueForKey:@"Adminuserid"];
             obj.GroupName  = [dict valueForKey:@"GroupName"];
             obj.MemberId = [dict valueForKey:@"MemberId"];
             obj.groupIcon = [dict valueForKey:@"GroupIcon"];
             string = [dict valueForKey:@"MemberId"];
             obj.status = [dict valueForKey:@"status"];
             [arrhomelist addObject:obj];
         }
         [_tblHome reloadData];
         if([arrhomelist count] == 0) {
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


-(void)UnLike:(id)sender {
    UIButton *abc=(UIButton *)sender;
    int i=abc.tag;
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    NSString * usserId = [VIP objectForKey:@"userid"];
    ModelClass * obj = [arrhomelist objectAtIndex:i];
    NSString *CommentUserID = [NSString stringWithFormat:@"%@",obj.groupUserid];
    NSString *PKUserID = [NSString stringWithFormat:@"%@",obj.groupPrimaryKey];

    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
    [[[ref queryOrderedByChild:@"FPrimarykeyGroup"]queryEqualToValue:PKUserID]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
         if (snapshot.value == [NSNull null]) {
             [self UnPutLikeCount:usserId :CommentUserID : PKUserID];
         } else {
             NSDictionary *post = snapshot.value;
             NSInteger  div1 = snapshot.childrenCount;
             NSString * divAutoincrId;
             NSString * stringstatus;
             for (FIRDataSnapshot *child in snapshot.children) {
                 divAutoincrId = child.key;
                 NSDictionary * dict1 = snapshot.value;
                 NSMutableArray * mutableArray1 = dict1[divAutoincrId];
                 NSMutableDictionary * dict = dict1[divAutoincrId];
                 ModelClass *obj = [[ModelClass alloc]init];
                 obj.LikeCount = [dict valueForKey:@"Like"];
                 stringstatus  = [dict valueForKey:@"Status"];
                 obj.likeUserIdFrom = [dict valueForKey:@"useridFrom"];
                 obj.likeUserIdTo = [dict valueForKey:@"useridTo"];
                 
                 [arrLikelist addObject:obj];
             }
             
             if([stringstatus isEqualToString:@"1"]) {
                 [self UpdateUnlike:usserId :CommentUserID :divAutoincrId];
                 
             } else {
            }
             
         }
     }];
    
}

-(void)Like:(id)sender {

    UIButton *abc=(UIButton *)sender;
    int i=abc.tag;
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    NSString * usserId = [VIP objectForKey:@"userid"];
    ModelClass * obj = [arrhomelist objectAtIndex:i];
    NSString *CommentUserID = [NSString stringWithFormat:@"%@",obj.groupUserid];
    NSString *PKUserID = [NSString stringWithFormat:@"%@",obj.groupPrimaryKey];

    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
     [[[ref queryOrderedByChild:@"FPrimarykeyGroup"]queryEqualToValue:PKUserID]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
         if (snapshot.value == [NSNull null]) {
             [self PutLikeCount:usserId :CommentUserID :PKUserID];
         } else {
             NSDictionary *post = snapshot.value;
             NSInteger  div1 = snapshot.childrenCount;
             NSString * divAutoincrId;
             NSString * stringstatus;
             for (FIRDataSnapshot *child in snapshot.children) {
                 divAutoincrId = child.key;
                 NSDictionary * dict1 = snapshot.value;
                 NSMutableArray * mutableArray1 = dict1[divAutoincrId];
                 NSMutableDictionary * dict = dict1[divAutoincrId];
                 ModelClass *obj = [[ModelClass alloc]init];
                 obj.LikeCount = [dict valueForKey:@"Like"];
                 stringstatus  = [dict valueForKey:@"Status"];
                 obj.likeUserIdFrom = [dict valueForKey:@"useridFrom"];
                 obj.likeUserIdTo = [dict valueForKey:@"useridTo"];
                 [arrLikelist addObject:obj];
             }
             if([stringstatus isEqualToString:@"1"]) {
             } else {
                 [self Updatelike:usserId :CommentUserID :divAutoincrId];
             }
         }
   }];
}

-(void)UpdateUnlike:(NSString*)useridFromid :(NSString *)usertoid :(NSString *)divAutoincrId{
    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
    FIRDatabaseReference *hopperRef = [ref childByAppendingPath: divAutoincrId];
    NSDictionary *nickname = @{
                               @"Like": @"2",@"Status": @"0"
                               };
    
    [hopperRef updateChildValues: nickname];
    
   /* [hopperRef updateChildValues:@{@"Like": @"2",@"Status": @"0"} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
            NSLog(@"Data could  be saved.");
            
            UIAlertController * alert =   [UIAlertController
                                           alertControllerWithTitle:@""
                                           message:@"Unliked"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:okAction];
            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            [vc presentViewController:alert animated:YES completion:nil];
            
            [HUD hide:YES];
            return;
        }
    }];
    
    */
}

-(void)Updatelike:(NSString*)useridFromid :(NSString *)usertoid :(NSString *)divAutoincrId{
    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
    FIRDatabaseReference *hopperRef = [ref childByAppendingPath: divAutoincrId];
    NSDictionary *nickname = @{
                               @"Like": @"1",@"Status": @"1"
                               };
    
    [hopperRef updateChildValues: nickname];
   /* [hopperRef updateChildValues:@{@"Like": @"1",@"Status": @"1"} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
            NSLog(@"Data could  be saved.");

            UIAlertController * alert =   [UIAlertController
                                           alertControllerWithTitle:@""
                                           message:@"Unliked"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:okAction];
            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            [vc presentViewController:alert animated:YES completion:nil];
            
            [HUD hide:YES];
            return;
        }
    }];

*/
}
-(void)UnPutLikeCount:(NSString*)useridFromid :(NSString *)usertoid :(NSString *)PKUserID {
    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
    [[ref childByAutoId] setValue:@{@"FPrimarykeyGroup" : PKUserID,@"useridTo" : usertoid, @"useridFrom" :useridFromid,@"Status" : @"0",@"Like" :@"0"} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
//            UIAlertController * alert =   [UIAlertController
//                                           alertControllerWithTitle:@""
//                                           message:@"Liked"
//                                           preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            }];
//            [alert addAction:okAction];
//            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//            [vc presentViewController:alert animated:YES completion:nil];
//            
//            [HUD hide:YES];
            return;
        }
    }];
    
}


-(void)PutLikeCount:(NSString*)useridFromid :(NSString *)usertoid :(NSString *)PKUserID {
    FIRDatabaseReference * ref;
    ref = [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/LikeTable"];
    [[ref childByAutoId] setValue:@{@"FPrimarykeyGroup" : PKUserID,@"useridTo" : usertoid, @"useridFrom" :useridFromid,@"Status" : @"1",@"Like" :@"1"} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
//           UIAlertController * alert =   [UIAlertController
//                                           alertControllerWithTitle:@""
//                                           message:@"Liked"
//                                           preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            }];
//            [alert addAction:okAction];
//            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//            [vc presentViewController:alert animated:YES completion:nil];
//            
//            [HUD hide:YES];
//            return;
        }
    }];

}
    
/*
    [[f childByAutoId] setValue:@{@"useridTo" : CommentUserID, @"useridFrom" :usserId,@"Status" : @"1",@"Like" :@"1"} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
            UIAlertController * alert =   [UIAlertController
                                           alertControllerWithTitle:@""
                                           message:@"Group Create Successfully"
                                           preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            [alert addAction:okAction];
            UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            [vc presentViewController:alert animated:YES completion:nil];
            
            [HUD hide:YES];
            return;
        }
    }];
 */
//}

-(void)progressBar {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [HUD show:YES];
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)ActionPlus:(id)sender {
    CreateGroup *rootViewController = [[CreateGroup alloc] init];
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

@end
