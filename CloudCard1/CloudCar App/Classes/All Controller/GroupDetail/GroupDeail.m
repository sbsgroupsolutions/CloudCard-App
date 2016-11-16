//
//  GroupDeail.m
//  CloudCar App
//
//  Created by Admin on 23/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "GroupDeail.h"

@interface GroupDeail ()

@end

@implementation GroupDeail
@synthesize tblHome;
@synthesize strMedMember,strMedGroupname,strMedGroupicon,lblHeader;
- (void)viewDidLoad {
    [super viewDidLoad];
    arrhomelist = [[NSMutableArray alloc]init];
    [self createData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) createData {
    arrhomelist = [NSMutableArray new];
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrhomelist addObject:ob];
    }
    [tblHome reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 292;

    } else {
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [arrhomelist count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        static NSString *cellId=@"GroupDCell";
        GroupDCell *cell1=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell1==nil) {
            NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"GroupDCell" owner:self options:nil];
            cell1=[ar lastObject];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;

        MyprofileOb *boj = [arrhomelist objectAtIndex:indexPath.row];
        
        cell1.lblName.text = strMedGroupname;
        lblHeader.text = strMedGroupname;

        NSURL *url = [NSURL URLWithString:strMedGroupicon];
        [cell1.imgIcon setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"GroupUser_group45x45.png"]];

        self.tblHome.separatorStyle = UITableViewCellSeparatorStyleNone;
        [cell1.btnmember setTag:indexPath.row];
        [cell1.btnmember addTarget:self action:@selector(MemberList:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.btnCard setTag:indexPath.row];
        [cell1.btnCard addTarget:self action:@selector(CardList:) forControlEvents:UIControlEventTouchUpInside];

        return cell1;

    } else {
        static NSString *simpleTableIdentifier = @"SimpleTableItem";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        MyprofileOb *boj = [arrhomelist objectAtIndex:indexPath.row];
        self.tblHome.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"custom" size:7.0f];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *myString = [NSString stringWithFormat:@"%@",boj.lblcategory];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
        NSRange range = [myString rangeOfString:@"GEO TAG 10 Minutes ago"];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        cell.textLabel.attributedText = attString;
        return cell;
    }
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)viewWillAppear:(BOOL)animated {
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
}
-(void)MemberList:(id)sender{
   
    GroupMember *Cobj = [[GroupMember alloc] init];
    Cobj.strMember = strMedMember;
    Cobj.strGroupname= strMedGroupname;
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  Cobj;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];

}

-(void)CardList:(id)sender{
    UIButton *abc=(UIButton *)sender;
    int i=abc.tag;
    
    
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


@end
