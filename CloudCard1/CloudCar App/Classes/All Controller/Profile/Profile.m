//
//  Profile.m
//  CloudCar App
//
//  Created by Admin on 28/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "Profile.h"

@interface Profile ()

@end

@implementation Profile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)viewWillAppear:(BOOL)animated {
    arrProlist = [[NSMutableArray alloc]init];
    [self createData];
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
 }


- (IBAction)ActionEditInfo:(id)sender {
}

- (void) createData {
    arrProlist = [NSMutableArray new];
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"$ was purchased at GEO TAG 10 Minutes ago";
        [arrProlist addObject:ob];
    }
    [_tblProfile reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 50;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [arrProlist count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
            static NSString *simpleTableIdentifier = @"SimpleTableItem";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        MyprofileOb *boj = [arrProlist objectAtIndex:indexPath.row];
        self.tblProfile.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"custom" size:7.0f];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSString *myString = [NSString stringWithFormat:@"%@",boj.lblcategory];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
        NSRange range = [myString rangeOfString:@"GEO TAG 10 Minutes ago"];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        cell.textLabel.attributedText = attString;
        return cell;
    }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIView * footerView  = [[UIView alloc] init];
    [footerView setFrame:CGRectMake(0, 0, screenWidth, 110)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(0, 0, screenWidth, 4)];
        [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundColor:[UIColor colorWithRed:176 green:219 blue:240 alpha:1.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setFrame:CGRectMake(0, 6, screenWidth, 40)];
    [button1 setBackgroundColor:[UIColor colorWithRed:0.23 green:0.35 blue:0.60 alpha:1.0]];
    [button1 setTitle:@"Recent Activity" forState:UIControlStateNormal];

    [button1.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(0, 44, screenWidth, 4)];
    [button2 setBackgroundColor:[UIColor colorWithRed:176 green:219 blue:240 alpha:1.0]];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [footerView addSubview:button];
    [footerView addSubview:button1];
    [footerView addSubview:button2];
    return footerView;

    
}

@end
