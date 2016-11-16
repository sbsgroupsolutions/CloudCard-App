//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.

#import "MenuViewController.h"
#import "InitialSlidingViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) CGFloat peekLeftAmount;
@property (nonatomic, assign) CGFloat peekRightAmount;
@property (nonatomic, strong) NSArray *arr_Images;

@end

@implementation MenuViewController
@synthesize menuItems,arr_Images;
@synthesize peekRightAmount;
@synthesize tv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    screenSize = [[UIScreen mainScreen]bounds];
    obj_NSUD =[NSUserDefaults standardUserDefaults];
    self = [super initWithNibName:@"MenuViewController_568" bundle:nil];
    return self;
}

- (void)awakeFromNib {
  self.menuItems = [NSArray arrayWithObjects:@"Home",@"Setting",@"Support",nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//    [panGesture setMinimumNumberOfTouches:1];
//    [panGesture setMaximumNumberOfTouches:1];
//    [self.view addGestureRecognizer:panGesture];
//    panGesture = nil;

    
    unsigned rgbValue = 0;
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    NSString * displayName = [VIP objectForKey:@"displayName"];
    lblUserName.text = [NSString stringWithFormat:@"%@",displayName];
    NSScanner *scanner1 = [NSScanner scannerWithString:@"#8049e5"];
    [scanner1 setScanLocation:1]; // bypass '#' character
    [scanner1 scanHexInt:&rgbValue];
    self.view.backgroundColor =[UIColor clearColor];
    self.peekRightAmount = 40.0f;
    obj_NSUD =[NSUserDefaults standardUserDefaults];

  [self.slidingViewController setAnchorRightRevealAmount:200.0f];
  self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    if ([obj_NSUD boolForKey:@"Is LogIn"]) {
         self.menuItems = [NSArray arrayWithObjects:@"Home",@"Setting",@"Support",nil];
    }
    else{
         self.menuItems = [NSArray arrayWithObjects:@"Home",@"Setting",@"Support",nil];
    }
    arr_Images = [NSArray arrayWithObjects:@"Support_Icon20x20.png",@"Support_Menu_icon20x20.png",@"Support_Icon20x20-1.png",nil];
}

-(void)handlePanGesture:(id)sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
//    Home *obj_HVC=[[Home alloc]initWithNibName:@"Home" bundle:nil];
//    
//    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
//    
//    obj_ISVC.topViewController = obj_HVC;
//    [self.navigationController pushViewController:obj_ISVC animated:YES];
//
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        //firstX = [[sender view] center].x;
       // firstY = [[sender view] center].y;
    }
   // translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY+translatedPoint.y);
    [[sender view] setCenter:translatedPoint];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    unsigned rgbValue = 0;
    
    NSScanner *scanner1 = [NSScanner scannerWithString:@"#8049e5"];
    [scanner1 setScanLocation:1]; // bypass '#' character
    [scanner1 scanHexInt:&rgbValue];
    //tableView.backgroundColor=[UIColor lightGrayColor];
   
     tableView.separatorColor=[UIColor whiteColor];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
    [cell setBackgroundColor:[UIColor clearColor]];
   // cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.75 green:0.79 blue:0.81 alpha:1.0];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.font=[UIFont fontWithName:@"Michroma" size:16];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    NSString *str=[self.arr_Images objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:str];
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *newTopViewController = [[UIViewController alloc] init];
    
    if (indexPath.row==0) {
        setBackgroundColor:[UIColor colorWithRed:0.502 green:0.286 blue:0.898 alpha:1];;
      
        Home *obj_HVC=[[Home alloc]initWithNibName:@"Home" bundle:nil];
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:YES];
    } else if (indexPath.row==1) {
        
        Setting *obj_HVC=[[Setting alloc]initWithNibName:@"Setting" bundle:nil];
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:YES];
        
    } else if (indexPath.row==2) {
        
        
        Support *obj_HVC=[[Support alloc]initWithNibName:@"Support" bundle:nil];
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:YES];
      }

    else if (indexPath.row==3) {
        
           }   else if (indexPath.row==4) {
        
        
      
        
    }   else if (indexPath.row==5) {
        
       }
    else if (indexPath.row==6) {
        
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Do you want to logout?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
//        
//        [alert show];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Voulez-vous vraiment vous déconnecter ?" message:@"" delegate:self cancelButtonTitle:@"Yes"otherButtonTitles:@"No", nil];
        [alert setTag:12];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 12) {    // it's the Error alert
        if (buttonIndex == 0) {     // and they clicked OK.
            
//        LoginViewController *obj_HVC1=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//         
//        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
//            
//        obj_ISVC.topViewController = obj_HVC1;
//        [self.navigationController pushViewController:obj_ISVC animated:YES];
            
        }
        if (buttonIndex==1) {
           
        }
    }
    
}


- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == tableView.numberOfSections - 0) {
        return [UIView new];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == tableView.numberOfSections - 0) {
        return 1;
    }
    return 0;
}

- (IBAction)revealRecharge:(id)sender
{
   // self.obj_RVC =[[RechargeViewController alloc] initWithNibName:@"RechargeViewController" bundle:nil];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = self.obj_HVC;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];

}

- (IBAction)revealBillPayments:(id)sender {
   // self.obj_BPVC =[[BillPaymentsViewController alloc] initWithNibName:@"BillPaymentsViewController" bundle:nil];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = self.obj_HVC;
       // self.slidingViewController.topViewController = self.obj_HVC;
       
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}


- (IBAction)ActionSignUp:(id)sender {
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    [VIP setObject:nil forKey:@"userid"];
    [VIP setObject:nil forKey:@"email"];
    //[VIP setObject:nil forKey:@"photoURL"];
    [VIP setObject:nil forKey:@"displayName"];
    // [VIP setObject:nil forKey:@"providerData"];
    [VIP setObject:nil forKey:@"providerID"];
    [VIP setObject:nil forKey:@"refreshToken"];
    
    
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    BOOL status = [firebaseAuth signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    [AppState sharedInstance].signedIn = false;
    //[//self dismissViewControllerAnimated:YES completion:nil];
    
    ViewController1 *obj_HVC=[[ViewController1 alloc]initWithNibName:@"ViewController1" bundle:nil];
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    obj_ISVC.topViewController = obj_HVC;
    [self.navigationController pushViewController:obj_ISVC animated:YES];
    
}
- (IBAction)ActionProfile:(id)sender {
    Profile *objPro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    obj_ISVC.topViewController = objPro;
    [self.navigationController pushViewController:obj_ISVC animated:YES];
}
@end
