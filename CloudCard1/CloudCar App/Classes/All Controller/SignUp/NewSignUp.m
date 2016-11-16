//
//  NewSignUp.m
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "NewSignUp.h"

@interface NewSignUp ()

@end

@implementation NewSignUp
@synthesize currentResponder;
@synthesize tblSign,imgProfile,strTablemanage;
@synthesize txtName;

- (void)viewDidLoad {
    [super viewDidLoad];
    Flagindex = YES;
    Flagindexsec= YES;
    [self createData];
    
     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //    [self setTextPhone:nil];
    //    [self setTextPassword:nil];
    [self setKeyboardControls:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createData {
    arrSignlist = [NSMutableArray new];
    fields= [NSMutableArray new];
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"First Name";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Last Name";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"User Name";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Mobile No";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Email";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Re-enter Email";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Password";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Re-enter Password";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Card Information";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Name Your Card";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Name on Card";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Card Number";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Exp.Date";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Security Number";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"Add Another Card";
        [arrSignlist addObject:ob];
        [fields addObject:ob];

    }
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    
    [self.keyboardControls setDelegate:self];

    [tblSign reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [arrSignlist count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString * simpleTableIdentifier = @"SimpleTableCell";
    //
    //        SignUpCell * cell = (SignUpCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //        if (cell == nil) {
    //            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
    //            cell = [nib objectAtIndex:0];
    //        }
    
    static NSString *CellIdentifier = @"Cell";
    
    SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    MyprofileOb * ob = arrSignlist[indexPath.row];
    indexpathmanage = indexPath.row;
    strTablemanage = ob.lblcategory;
    cell.txtName.delegate = self;
    cell.txtName.tag = indexPath.row;
    cell.btnaddcard.hidden = YES;
    
    
    // *email,*password,*reemail,*repassword, *carinfo, *nameyourcard,*nameoncard,*carno,*exdate,*secuityno,*Addothercard,*go;
    if(indexPath.row==0) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=fname;
    } else if(indexPath.row==1) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=lstname;
    }else if(indexPath.row==2) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=username;
    } else if(indexPath.row==3) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=mobileno;
    }  else if(indexPath.row==4) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=email;
    } else if(indexPath.row==5) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=reemail;
    } else if(indexPath.row==6) {
        cell.txtName.secureTextEntry=YES;
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=password;
    } else if(indexPath.row==7) {
        cell.txtName.secureTextEntry=YES;
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=repassword;
    }
    
    else if(indexPath.row==9) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameyourcard;
    } else if(indexPath.row==10) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameoncard;
    } else if(indexPath.row==11) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=carno;
    } else if(indexPath.row==12) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=exdate;
    } else if(indexPath.row==13) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=secuityno;
    }
    
    else if(indexPath.row==15) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameyourcard1;
    } else if(indexPath.row==16) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameoncard1;
    } else if(indexPath.row==17) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=carno1;
    }else if(indexPath.row==18) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=exdate1;
    } else if(indexPath.row==19) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=secuityno1;
    }
    
    else if(indexPath.row==21) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameyourcard2;
    } else if(indexPath.row==22) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=nameoncard2;
    } else if(indexPath.row==23) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=carno2;
    } else if(indexPath.row==24) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=exdate2;
    } else if(indexPath.row==25) {
        cell.txtName.tag=indexPath.row;
        cell.txtName.text=secuityno1;
    }
    
    
    if(indexPath.row == 20 || indexPath.row == 14 || indexPath.row == 8) {
        cell.btnaddcard.tag = indexPath.row;
        
        cell.btnaddcard.hidden = NO;
        cell.txtName.hidden = NO;
        cell.txtName.placeholder = @"";
        cell.txtName.userInteractionEnabled = YES;
        //cell.txtName.delegate = self;
        cell.txtName.returnKeyType = UIReturnKeyDone;
        cell.txtName.clearButtonMode = UITextFieldViewModeWhileEditing;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.btnaddcard setTitleColor:[UIColor colorWithRed:0.40 green:0.73 blue:0.98 alpha:1.0] forState:UIControlStateNormal];
        [cell.btnaddcard setTitle:ob.lblcategory forState:UIControlStateNormal];
        [cell.btnaddcard addTarget:self action:@selector(AddOtherCard:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        cell.btnaddcard.hidden = YES;
        cell.txtName.hidden = NO;
        cell.txtName.placeholder = ob.lblcategory;
        cell.txtName.userInteractionEnabled = YES;
        //cell.txtName.delegate = self;
        cell.txtName.returnKeyType = UIReturnKeyDone;
        cell.txtName.clearButtonMode = UITextFieldViewModeWhileEditing;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width/2;
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth1 = screenWidth/3;
    CGFloat screenWidth2 = screenWidth1*4;

    
    UIView * footerView  = [[UIView alloc] init];
    //create the button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(screenWidth1, 3, screenWidth2, 40)];
    //set title, font size and font color
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:@"Let's Go!" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //set action of the button
    [button addTarget:self action:@selector(LateGoFinal:)
     forControlEvents:UIControlEventTouchUpInside];
    //add the button to the view
    [footerView addSubview:button];
    return footerView;
}

-(void)AddOtherCard:(id)sender {
    
    UIButton * abc = (UIButton *)sender;
    int i = abc.tag;
    if(i == 14) {
        if(Flagindex) {
            Flagindex = NO;
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Name Your Card";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Name on Card";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Card Number";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Exp. Date";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Security Number";
                [arrSignlist addObject:ob];
            }{
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Add Another Card";
                [arrSignlist addObject:ob];
            }
            [tblSign reloadData];
        }
    } else if (i == 20) {
        if(Flagindexsec) {
            Flagindexsec = NO;
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Name Your Card";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Name on Card";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Card Number";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Exp.Date";
                [arrSignlist addObject:ob];
            }
            {
                MyprofileOb * ob = [[MyprofileOb alloc]init];
                ob.lblcategory = @"Security Number";
                [arrSignlist addObject:ob];
            }
            
            [tblSign reloadData];
            
        }
    }
}

#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag==0) {
        fname=textField.text;
    }
    else if (textField.tag==1) {
        lstname=textField.text;
    }
    else if (textField.tag==2) {
        username=textField.text;
    }
    else if (textField.tag==3) {
        mobileno=textField.text;
    }
    else if (textField.tag==4) {
        email=textField.text;
    }
    else if (textField.tag==5) {
        reemail=textField.text;
    }
    else if (textField.tag==6) {
        password=textField.text;
    }
    else if (textField.tag==7) {
        repassword=textField.text;
    }
    else if (textField.tag==9) {
        nameyourcard=textField.text;
    }
    else if (textField.tag==10) {
        nameoncard=textField.text;
    }
    else if (textField.tag==11) {
        carno=textField.text;
    }
    else if (textField.tag==12) {
        exdate=textField.text;
    }
    else if (textField.tag==13) {
        secuityno=textField.text;
    }
    else if (textField.tag==15) {
        nameyourcard1=textField.text;
    }
    else if (textField.tag==16) {
        nameoncard1=textField.text;
    }
    else if (textField.tag==17) {
        carno1=textField.text;
    }
    else if (textField.tag==18) {
        exdate1=textField.text;
    }
    else if (textField.tag==19) {
        secuityno1=textField.text;
    }
    else if (textField.tag==21) {
        nameyourcard2=textField.text;
    }
    else if (textField.tag==22) {
        nameoncard2=textField.text;
    }
    else if (textField.tag==23) {
        carno2=textField.text;
    }
    else if (textField.tag==24) {
        exdate2=textField.text;
    }
    else if (textField.tag==25) {
        secuityno2=textField.text;
    }

    
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    self.currentResponder=textField;
//
//    if (textField.tag==4)
//    {
//
//        [self showkeyboard_with_done:textField];
//        [textField setKeyboardType:UIKeyboardTypeNumberPad];
//
//    }
//    if (textField.tag==10)
//    {
//
//
//        [self showkeyboard_with_done:textField];
//        [textField setKeyboardType:UIKeyboardTypeNumberPad];
//
//    }
//
//
//
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.currentResponder=textField;
    
    [textField resignFirstResponder];
    if (textField.tag==0) {
        fname=textField.text;
    }
    else if (textField.tag==1) {
        lstname=textField.text;
    }
    else if (textField.tag==2) {
        username=textField.text;
    }
    else if (textField.tag==3) {
        mobileno=textField.text;
    }
    else if (textField.tag==4) {
        email=textField.text;
    }
    else if (textField.tag==5) {
        reemail=textField.text;
    }
    else if (textField.tag==6) {
        password=textField.text;
    }
    else if (textField.tag==7) {
        repassword=textField.text;
    }
    else if (textField.tag==9) {
        nameyourcard=textField.text;
    }
    else if (textField.tag==10) {
        nameoncard=textField.text;
    }
    else if (textField.tag==11) {
        carno=textField.text;
    }
    else if (textField.tag==12) {
        exdate=textField.text;
    }
    else if (textField.tag==13) {
        secuityno=textField.text;
    }
    else if (textField.tag==15) {
        nameyourcard1=textField.text;
    }
    else if (textField.tag==16) {
        nameoncard1=textField.text;
    }
    else if (textField.tag==17) {
        carno1=textField.text;
    }
    else if (textField.tag==18) {
        exdate1=textField.text;
    }
    else if (textField.tag==19) {
        secuityno1=textField.text;
    }
    else if (textField.tag==21) {
        nameyourcard2=textField.text;
    }
    else if (textField.tag==22) {
        nameoncard2=textField.text;
    }
    else if (textField.tag==23) {
        carno2=textField.text;
    }
    else if (textField.tag==24) {
        exdate2=textField.text;
    }
    else if (textField.tag==25) {
        secuityno2=textField.text;
    }

    return YES;
}

-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance = -170; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self animateTextField:textField up:YES];
//    [self.keyboardControls setActiveField:textField];
//    
//       // [self animateTextField:txt_password up:YES];
//       // [self animateTextField:txt_Email up:YES];
//}
-(void) textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == txtName) {
        cursorPass = true;
        cursorPhone = false;
    } else if (textField == txtName) {
        cursorPhone = true;
        cursorPass = false;
    }
    [self.keyboardControls setActiveField:textField];
    [self animateTextField:txtName up:YES];
    [self animateTextField:txtName up:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:txtName up:NO];
    [self animateTextField:txtName up:NO];
    [self animateTextField:textField up:NO];
}

#pragma mark -
#pragma mark Keyboard Controls Delegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        view = field.superview.superview;
    } else {
        view = field.superview.superview.superview;
    }
    
    //[self.tableView scrollRectToVisible:view.frame animated:YES];
}


- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    //    if (cursorPass)
    //    {
    //        cursorPass = false;
    //        [self Loginbtnpress:nil];
    //    }
    //    else if(cursorPhone)
    //    {
    //        cursorPhone = false;
    //        [txt_password becomeFirstResponder];
    //    }
    [self.view endEditing:YES];
}



//
//-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self animateTextField:textField up:YES];
//}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self animateTextField:textField up:NO];
//}

//-(void)animateTextField:(UITextField*)textField up:(BOOL)up {
//    const int movementDistance = -170; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    
//    int movement = (up ? movementDistance : -movementDistance);
//    
//    [UIView beginAnimations: @"animateTextField" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}

-(IBAction)hidekey:(id)sender {
    [sender resignFirstResponder];
}

-(void)LateGoFinal:(id)sender {
    [self Validation];
}

- (void)setDisplayName:(FIRUser *)user {
    
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    changeRequest.displayName = [[user.email componentsSeparatedByString:@"@"] objectAtIndex:0];
    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            return;
        }
        
        if([base64String isEqualToString:@""] || base64String == nil) {
            base64String = @"https://firebasestorage.googleapis.com/v0/b/cloudcard-1d03b.appspot.com/o/21-Sep-2016,%207:00:02%20PM.jpg?alt=media&token=4ef9d7cd-b271-4a46-b790-ce157691e856";
        } else {
            
        }
        [self signedIn:[FIRAuth auth].currentUser];
    }];
}


- (void)signedIn:(FIRUser *)user {
    
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    [VIP setObject:nil forKey:@"userid"];
    [VIP setObject:nil forKey:@"email"];
    [VIP setObject:nil forKey:@"displayName"];
    [VIP setObject:nil forKey:@"providerID"];
    [VIP setObject:nil forKey:@"refreshToken"];
    NSString * userid = user.uid;
   // useridCurrent = user.uid;
    
    NSString * displayName =user.displayName;
    NSString * email =user.email;
    // NSString * imageProfile =user.imageUrl;
    
    [AppState sharedInstance].signedIn = YES;
    [MeasurementHelper sendLoginEvent];
    [VIP setObject:userid forKey:@"userid"];
    [VIP setObject:email forKey:@"email"];
    [VIP setObject:displayName forKey:@"displayName"];
    
    [AppState sharedInstance].displayName = user.displayName.length > 0 ? user.displayName : user.email;
    [AppState sharedInstance].photoUrl = user.photoURL;
    [AppState sharedInstance].signedIn = YES;
    
    FIRUser *user1 = [FIRAuth auth].currentUser;
    NSString *name1 = user.displayName;
    NSString *email1 = user.email;
    NSURL *photoUrl1= user.photoURL;
    
    NSString * latitude = [VIP objectForKey:@"latitude"];
    NSString * longitude = [VIP objectForKey:@"longitude"];
    
  //  NSString *userid = user.uid;

    if(nameyourcard1 == nil || [nameyourcard1 isEqualToString:@""]) {
    nameyourcard1 = @"";
    }
    if (nameoncard1 == nil || [nameoncard1 isEqualToString:@""]) {
        nameoncard1 = @"cardyoucard";

    }
    if (carno1 == nil || [carno1 isEqualToString:@""]) {
        carno1 = @"cardyoucard";

    }
    if (exdate1 == nil || [exdate1 isEqualToString:@""]) {
        exdate1 = @"cardyoucard";

    }
    if (secuityno1 == nil || [secuityno1 isEqualToString:@""]) {
        secuityno1 = @"cardyoucard";

    }
    if (nameyourcard2 == nil || [nameyourcard2 isEqualToString:@""]) {
        nameyourcard2 = @"cardyoucard";
  
    }
    if (nameoncard2 == nil || [nameoncard2 isEqualToString:@""]) {
        nameoncard2 = @"cardyoucard";
   
    }
    if (carno2 == nil || [carno2 isEqualToString:@""]) {
        carno2 = @"cardyoucard";
    }
    if (exdate2 == nil || [exdate2 isEqualToString:@""]) {
        exdate2 = @"cardyoucard";
   
    }
    if (secuityno2 == nil || [secuityno2 isEqualToString:@""]) {
        secuityno2 = @"cardyoucard";
    
    }
  
   
    FIRDatabaseReference *rootRef= [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/"];
    NSDictionary *alanisawesome = @{
                                    @"userid" : userid,
                                    @"fname" : fname,
                                    @"lstname" : lstname,
                                    @"username" : username,
                                    @"Mobileno" : mobileno,
                                    @"email" : email,
                                    @"password" :password,
                                    @"nameyourcard" : nameyourcard,
                                    @"nameoncard" :nameoncard,
                                    @"carno" : carno,
                                    @"exdate" : exdate,
                                    @"secuityno" :secuityno,
                                    @"nameyourcard1" : nameyourcard1,
                                    @"nameoncard1" :nameoncard1,
                                    @"carno1" : carno1,
                                    @"exdate1" : exdate1,
                                    @"secuityno1" :secuityno1,
                                    @"nameyourcard2" : nameyourcard2,
                                    @"nameoncard2" :nameoncard2,
                                    @"carno2" : carno2,
                                    @"exdate2" : exdate2,
                                    @"secuityno2" :secuityno2,
                                    @"PhotoUrl" :base64String,
                                    @"latitude" :latitude,
                                    @"longitude" :longitude,
                                };

   // @"imageUrl" : ImgURL.absoluteString,

    FIRDatabaseReference *rootReference = [[FIRDatabase database] reference];
    FIRDatabaseReference *usersReference = [rootReference child:@"users"];
    FIRDatabaseReference *newUserReference = [usersReference childByAutoId];
    [newUserReference setValue:alanisawesome];
    
    [newUserReference setValue:alanisawesome withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Data could not be saved.");
        } else {
           
           
            
//            FIRAuth *firebaseAuth = [FIRAuth auth];
//            NSError *signOutError;
//            BOOL status = [firebaseAuth signOut:&signOutError];
//            if (!status) {
//                NSLog(@"Error signing out: %@", signOutError);
//                return;
//            }
//            [AppState sharedInstance].signedIn = false;
//            [HUD show:YES];
            
            
          //  NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
//            [VIP setObject:userid forKey:@"userid"];
//            [VIP setObject:email forKey:@"email"];
//            [VIP setObject:displayName forKey:@"displayName"];
//            
//            [AppState sharedInstance].displayName = user.displayName.length > 0 ? user.displayName : user.email;
//            [AppState sharedInstance].photoUrl = user.photoURL;
            [AppState sharedInstance].signedIn = YES;
            FIRAuth *firebaseAuth = [FIRAuth auth];
            NSError *signOutError;
            BOOL status = [firebaseAuth signOut:&signOutError];
            if (!status) {
                NSLog(@"Error signing out: %@", signOutError);
                return;
            }

            Home *rootViewController = [[Home alloc] init];
          //  rootViewController.StrManageLogin = @"Yes";
            InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            obj_HVC.topViewController =  rootViewController;
            [self.navigationController
             pushViewController:obj_HVC animated:NO];
            NSLog(@"Data saved successfully.");
        }
    }];
    
}

-(void)uploadImage:(UIImage *)image {
}

-(void)Validation {
    [self progressBar];
    
    if(fname==nil || [fname isEqualToString:@""])
    {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter your first name!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    
    if(lstname == nil || [lstname isEqualToString:@""]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter your last name!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if(username == nil || [username isEqualToString:@""]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter your Username!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    BOOL isValidEmail = [JRTextHelper textIsValidEmailFormat:email];
    if(!isValidEmail){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Valid email id!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if(reemail == nil || [reemail isEqualToString:@""]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Re-enter Valid email id!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if(![email isEqualToString:reemail]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Donot Match Email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        
        return;
    }
    
    if(password == nil || [password isEqualToString:@""]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        
        return;
    }
    
    if(repassword == nil || [repassword isEqualToString:@""])
    {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Re-Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if(![password isEqualToString:repassword]){
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Do not Match Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        
        return;
    }
    
    if(nameyourcard == nil)
    {

    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Cardname" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
           [av show];
           [HUD hide:YES];
        return;
    }
    if(nameoncard == nil)
    {

    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Cardname" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    if(carno == nil)
    {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Card No" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        return;
       }

    if(exdate == nil)
    {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your expiry Date" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
          [av show];
          return;
    }

    if(secuityno == nil){

    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your security No!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
       } else {
      
    
        [[FIRAuth auth] createUserWithEmail:email password:password
                             completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                                 if (error) {
                                     [HUD hide:YES];
                                     UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *yesButton=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
                                     [alert addAction:yesButton];
                                     [self presentViewController:alert animated:YES completion:nil];
                                     return;
                                 }
                             
                                 [self setDisplayName:user];
                             }];
       }
}

-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    // HUD.detailsLabelText = @"Registration..";
    HUD.square = YES;
    [HUD show:YES];
    
}

- (IBAction)ActionUploadimage:(id)sender {
    
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //  The user tapped on "Take a photo"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose Existing"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //  The user tapped on "Choose existing"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title_AB = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([title_AB isEqual:@"Camera"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if([title_AB isEqual:@"Photo"]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        } else {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
            }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

        [self dismissViewControllerAnimated:YES completion:nil];
       // imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2;
       // imgProfile.layer.borderWidth = 0.5;
        tempImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        imgProfile.contentMode =  UIViewContentModeScaleAspectFit;
        imgProfile.image = tempImage;
        img_Event = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        imageData = UIImageJPEGRepresentation(tempImage, 0.6);
//        base64String = [UIImagePNGRepresentation(tempImage)
//                              base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
   // imgUserUpload = [self base64String];
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle]; // Set date and time styles
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *dateString1 = [NSString stringWithFormat:@"%@.jpg",dateString];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage referenceForURL:@"gs://cloudcard-1d03b.appspot.com"];
    FIRStorageReference *mountainsRef = [storageRef child:dateString1];
    FIRStorageReference *mountainImagesRef = [storageRef child:@".jpg"];
    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
    metadata.contentType = @"image/jpeg";
    
    mountainsRef.name == mountainImagesRef.name;            // true
    mountainsRef.fullPath == mountainImagesRef.fullPath;    // false
    FIRStorageReference *riversRef = [storageRef child:mountainsRef.name];
    FIRStorageUploadTask *uploadTask = [riversRef putData:imageData metadata:metadata completion:^(FIRStorageMetadata* metadata, NSError* error) {
        if (error != nil) {
        } else {
            downloadURL = metadata.downloadURL;
            base64String = [NSString stringWithFormat:@"%@",downloadURL];
        }
    }];
}

- (NSString *)base64String {
    NSData * data = [UIImagePNGRepresentation(tempImage) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [NSString stringWithUTF8String:[data bytes]];
}

- (IBAction)ActionBack:(id)sender {
    ViewController1 *rootViewController = [[ViewController1 alloc] init];
InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}


@end
