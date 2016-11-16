//
//  ContactNo.m
//  CloudCar App
//
//  Created by Admin on 05/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "ContactNo.h"

@interface ContactNo ()

@end

@implementation ContactNo
@synthesize ContactNumberDelegate;
@synthesize strForCommingFrom;
@synthesize strContactlist,GroupNameCurrent;
@synthesize imgGroupCurrent,imageDataCl;

- (void)viewDidLoad {
    [self progressBar];
    [super viewDidLoad];
    arrGroup = [[NSMutableArray alloc]init];
    arrAppContact = [[NSMutableArray alloc]init];
      
    strLL =[[NSMutableString alloc] init];
    arrCheckSelect = [NSMutableArray new];
    arrCheckgroup = [NSMutableArray new];
    [tblViewForFriends setDelegate:self];
    [tblViewForFriends setDataSource:self];
    tblViewForFriends.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    arrForConnectFriends=[[NSMutableArray alloc] init];
    arrForConnectFriends=[[NSMutableArray alloc] init];
}

-(void)progressBar {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [HUD show:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [HUD show:YES];

    arrGroup = [[NSMutableArray alloc]init];
    mArrAppContDetail = [[NSMutableArray alloc]init];
    arrAppContact = [[NSMutableArray alloc]init];
    arrWithOutAppContact = [[NSMutableArray alloc]init];
    arrContact = [[NSMutableArray alloc]init];
    [self getPhoneBookContacts];
    
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
    _imgupload.hidden = NO;
    _lblHeader.text = @"Invite Friends";
    [_btnDone setTitle:@"" forState:UIControlStateNormal];
    arrAppContact= sortedArray;
    strContactlist = @"";
    [tblViewForFriends reloadData];
}

- (IBAction)ActionSetting:(id)sender {
    Setting *rootViewController = [[Setting alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

#pragma mark phone contacts method:-----
-(void)getPhoneBookContacts {
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Rideversity would like to access your contacts. Please allow access in the iPhone Settings app under Privacy > Contacts." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if(!addressBook) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if(error) {
            NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
        } if(granted) {
            [self listPeopleInAddressBook:addressBook];
        } else {
            dispatch_async(dispatch_get_main_queue(),^{
                // BTW, this is not on the main thread, so dispatch UI updates back to the main queue
                //[AppDelegate killHud];
                [[[UIAlertView alloc] initWithTitle:nil message:@"Rideversity would like to access your contacts. Please allow access in the iPhone Settings app under Privacy > Contacts." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
        CFRelease(addressBook);
    });
}

- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook {
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSInteger numberOfPeople = [allPeople count];
    [arrForConnectFriends removeAllObjects];
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            [dict setValue:email forKey:@"email"];
        }
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        NSString *phoneNumber;
        for(CFIndex k = 0; k < numberOfPhoneNumbers; k++) {
            phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, k));
        }
        UIImage*image;
        UIImage*imageForBlnk=[UIImage imageNamed:@"user_profile.png"];
        CFDataRef cfImage = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
        if (firstName==nil&&lastName==nil) {
            NSLog(@"nothing to add");
        } else {
            if (cfImage) {
                image = [UIImage imageWithData:(__bridge NSData*)cfImage];
                [dict setValue:image forKey:@"image"];
            } else {
                [dict setValue:imageForBlnk forKey:@"image"];
            }
        }
        [dict setValue:firstName forKey:@"first_name"];
        if (lastName==nil) {
            [dict setValue:@"" forKey:@"last_name"];
        } else {
            [dict setValue:lastName forKey:@"last_name"];
        }
        [dict setValue:phoneNumber forKey:@"phone_number"];
        [arrForConnectFriends addObject:dict];
        [arrCheckSelect addObject:@"0"];
    }
    dispatch_async(dispatch_get_main_queue(),^{
        
        NSString*strForKey;
        strForKey=@"first_name";
        NSSortDescriptor *hopProfileDescriptor =
        [[NSSortDescriptor alloc] initWithKey:strForKey
                                    ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:hopProfileDescriptor, nil];
        sortedArray = [arrForConnectFriends sortedArrayUsingDescriptors:descriptors];
        arrAppContact= [arrForConnectFriends sortedArrayUsingDescriptors:descriptors];
        if([strContactlist isEqualToString:@"Yes"]) {
            arrAppContact = [[NSMutableArray alloc]init];
            arrCheckgroup = [[NSMutableArray alloc]init];

            _imgupload.hidden = YES;
            [_btnDone setTitle:@"Done" forState:UIControlStateNormal];
            _lblHeader.text = @"Add Friends";
            [self CompFunct];
        } else {
            [HUD hide:YES];

            _imgupload.hidden = NO;
            _lblHeader.text = @"Invite Friends";
            [_btnDone setTitle:@"" forState:UIControlStateNormal];
        }
        [tblViewForFriends reloadData];
    });
}

-(void) CompFunct {
    NSMutableArray * mArrAppContDetail1 = [[NSMutableArray alloc]init];
    NSString *strUrl = [NSString stringWithFormat:@"https://cloudcard-1d03b.firebaseio.com/users"];
    FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:strUrl];
    
 /*   [[ref queryOrderedByChild:@"userid"]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
         
         NSLog(@"%@ was %@ meters tall", snapshot.key, snapshot.value[@"height"]);
     }];*/
    
    [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *post = snapshot.value;
        NSString * div;
        for (FIRDataSnapshot *child in snapshot.children) {
            div = child.key;
            NSDictionary * dict1 = snapshot.value;
            NSMutableDictionary * dict = dict1[div];
            ModelClass *obj = [[ModelClass alloc]init];

            
            obj.Mobileno = [dict valueForKey:@"Mobileno"];
            obj.carno  = [dict valueForKey:@"carno"];
            obj.carno1 = [dict valueForKey:@"carno1"];
            obj.carno2 = [dict valueForKey:@"carno2"];
            obj.secuityno = [dict valueForKey:@"secuityno"];
            obj.secuityno2 = [dict valueForKey:@"secuityno1"];
            obj.secuityno1 = [dict valueForKey:@"secuityno2"];
            obj.userid = [dict valueForKey:@"userid"];
            obj.username = [dict valueForKey:@"username"];
            obj.password = [dict valueForKey:@"password"];
            obj.nameyourcard2 = [dict valueForKey:@"nameyourcard2"];
            obj.nameyourcard1 = [dict valueForKey:@"nameyourcard1"];
            obj.nameyourcard = [dict valueForKey:@"nameyourcard"];
            obj.nameoncard = [dict valueForKey:@"nameoncard"];
            obj.nameoncard1 = [dict valueForKey:@"nameoncard1"];
            obj.nameoncard2 = [dict valueForKey:@"nameoncard2"];
            obj.lstname = [dict valueForKey:@"lstname"];
            obj.fname = [dict valueForKey:@"fname"];
            obj.exdate = [dict valueForKey:@"exdate"];
            obj.exdate1 = [dict valueForKey:@"exdate1"];
            obj.exdate2 = [dict valueForKey:@"exdate2"];
            obj.email = [dict valueForKey:@"email"];
            [mArrAppContDetail1 addObject:obj];
        }
        for (int i = 0 ; i< [sortedArray count] ; i++) {
            NSMutableDictionary *dict = [sortedArray objectAtIndex:i];
            NSString * stringWithoutSpaces = dict[@"phone_number"];
             NSString *phoneno = [stringWithoutSpaces stringByReplacingOccurrencesOfString:@"+1" withString:@""];
            NSString *phoneno11 = [phoneno stringByReplacingOccurrencesOfString:@"+91" withString:@""];
            NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
            NSString *phoneno23 = [[phoneno11 componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
           
           for (int j = 0 ; j< [mArrAppContDetail1 count] ; j++) {
            ModelClass *obj = [mArrAppContDetail1 objectAtIndex:j];
               NSString * phoneno1 = obj.Mobileno;
               NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
               NSString *resultStringaa = [[phoneno1 componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
               if([phoneno23 isEqualToString:resultStringaa]) {
                  
                   [arrAppContact addObject:obj];
                   [arrGroup addObject:@"0"];
                   [arrCheckgroup addObject:@"0"];
               } else {
                 [arrWithOutAppContact addObject:obj];
               }
               
            }
        }
        [HUD hide:YES];
        [tblViewForFriends reloadData];
    }];
}

#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([strContactlist isEqualToString:@"Yes"])
        return 65;
    else
        return 55;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrAppContact.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId=@"cellId";
    CustomContactList *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"CustomContactList" owner:self options:nil];
        cell=[ar lastObject];
    }
    
    if([strContactlist isEqualToString:@"Yes"]) {
        ModelClass * obj = [arrAppContact objectAtIndex:indexPath.row];
               cell.imgCDFUser.hidden = NO;
        cell.lblCDFName.hidden = NO;
        cell.lblForName.hidden = YES;
        cell.lblCDFName.text=[NSString stringWithFormat:@"%@ %@",obj.fname,obj.lstname];
        cell.imgCDFUser.layer.cornerRadius = cell.imgCDFUser.frame.size.height/2;
        cell.imgCDFUser.layer.borderWidth = 0.5;
        cell.imgCDFUser.clipsToBounds = YES;
        cell.imgCDFUser.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.imgCDFUser.image = [UIImage imageNamed:@"user.png.png"];
    } else {
        NSMutableDictionary * dict = [sortedArray objectAtIndex:indexPath.row];
        cell.imgCDFUser.hidden = YES;
        cell.lblCDFName.hidden = YES;
        cell.lblForName.hidden = NO;
        cell.lblForName.text=[NSString stringWithFormat:@"%@ %@",dict[@"first_name" ],dict[@"last_name"]];
    }

    if ([[arrCheckSelect objectAtIndex:indexPath.row] boolValue] == YES)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell.btnForCheckUncheck addTarget:self action:@selector(actionForCheckUncheck:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnForCheckUncheck.tag=indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int i = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if([strContactlist isEqualToString:@"Yes"]) {
        ModelClass * obj = [arrAppContact objectAtIndex:i];
        
        if ([[arrCheckgroup objectAtIndex:indexPath.row] boolValue] == YES) {
            [arrCheckgroup replaceObjectAtIndex:i withObject:@"0"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            //[arrGroup removeObjectAtIndex:i];
            [arrGroup replaceObjectAtIndex:i withObject:@"0"];

        } else {
            [arrCheckgroup replaceObjectAtIndex:i withObject:@"1"];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [arrGroup replaceObjectAtIndex:i withObject:obj];
        }
        
    } else {
        NSMutableDictionary * dict = [sortedArray objectAtIndex:i];
        if ([[arrCheckSelect objectAtIndex:indexPath.row] boolValue] == YES) {
            [arrCheckSelect replaceObjectAtIndex:i withObject:@"0"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            // NSString *strTempLL = [NSString stringWithFormat:@"%@,",contantno];
            //[strLL appendString:[NSString stringWithFormat:@"%@",strTempLL]];
            
        } else {
            [arrCheckSelect replaceObjectAtIndex:i withObject:@"1"];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            //strLL = [strLL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",contantno] withString:@"0"];
        }
    }
}

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
        
        if (arrConDetail == (id)[NSNull null] || [arrConDetail count] == 0) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please select atleast one contact" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [av show];
            [HUD hide:YES];
            return;

        } else {
            CreateGroup *rootViewController = [[CreateGroup alloc] init];
            rootViewController.arrContactgroup = arrConDetail;
            rootViewController.strmanagecont = @"YES";
            rootViewController.GroupNameCurName = GroupNameCurrent;
            rootViewController.imgGroupCurrent = imgGroupCurrent;
            rootViewController.imageDataClorn = imageDataCl;

            InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            obj_HVC.topViewController =  rootViewController;
            [self.navigationController
             pushViewController:obj_HVC animated:NO];
        }
       
    } else {
        // [self.navigationController popViewControllerAnimated:NO];

    }
}


@end
