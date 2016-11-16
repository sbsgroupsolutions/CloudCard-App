//
//  GroupMember.m
//  CloudCar App
//
//  Created by Admin on 23/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "GroupMember.h"

@interface GroupMember ()

@end

@implementation GroupMember
@synthesize strMember,arrGroupmember,strGroupname;
@synthesize lblHeader;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrGroupmember = [[NSMutableArray alloc]init];
    lblHeader.text = strGroupname;
    [self CreateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CreateData {
    NSArray* foo = [[NSArray alloc]init];
    foo = [strMember componentsSeparatedByString:@","];
    NSInteger num = [foo count]-1;

    for(int i = 0;i < [foo count];i++) {
        NSString* firstBit1 = [foo objectAtIndex:i];
        NSString *strUrl1 = [NSString stringWithFormat:@"https://cloudcard-1d03b.firebaseio.com/users/"];
        FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:strUrl1];
        [[[ref queryOrderedByChild:@"userid"]queryEqualToValue:firstBit1]
         observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
             NSLog(@"%@ Key %@ Value", snapshot.key,snapshot.value);
             NSString * div;
             for (FIRDataSnapshot *child in snapshot.children) {
             div = child.key;
             
             NSDictionary * dict1 = snapshot.value;
             NSMutableDictionary * dict = dict1[div];
             ModelClass *obj = [[ModelClass alloc]init];
                 obj.Mobileno = [dict valueForKey:@"Mobileno"];
                 obj.lstname = [dict valueForKey:@"lstname"];
                 obj.fname = [dict valueForKey:@"fname"];
                 obj.email = [dict valueForKey:@"email"];
                 [arrGroupmember addObject:obj];
             }
             if (num == i) {
                 [tblViewForFriends reloadData];
             }
             
         }];
    }
    [tblViewForFriends reloadData];

}
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrGroupmember.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId=@"cellId";
    GroupCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"GroupCell" owner:self options:nil];
        cell=[ar lastObject];
    }
    
        ModelClass * obj = [arrGroupmember objectAtIndex:indexPath.row];
        if(indexPath.row == 0) {
           cell.lblAdmin.hidden = NO;
        } else {
            cell.lblAdmin.hidden = YES;
        }
    
        cell.lblName.text=[NSString stringWithFormat:@"%@ %@",obj.fname,obj.lstname];
        cell.status.text= @"Active";//[NSString stringWithFormat:@"%@ %@",obj.fname,obj.lstname];

        cell.imgUser.layer.cornerRadius = cell.imgUser.frame.size.height/2;
        cell.imgUser.layer.borderWidth = 0.5;
        cell.imgUser.clipsToBounds = YES;
        cell.imgUser.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.imgUser.image = [UIImage imageNamed:@"user.png.png"];
    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)ActionActiveGroup:(id)sender {
}

- (IBAction)ActionHome:(id)sender {
}

- (IBAction)ActionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)ActionContact:(id)sender {
}

- (IBAction)ActionSetting:(id)sender {
}


@end
