//
//  MagazineViewController.m
//  MagazineApp
//
//  Created by Akhilesh Mourya on 12/18/14.
//  Copyright (c) 2014 Akhilesh Mourya. All rights reserved.
//
#import "ContactNumber.h"
#import "CustomContact/CustomContactList.h"

@interface ContactNumber ()

@end

@implementation ContactNumber
@synthesize ContactNumberDelegate;
@synthesize strForCommingFrom;

- (IBAction)PostAction:(id)sender {
    // strLL = [strLL stringByReplacingOccurrencesOfString:@"0," withString:@""];
  //  [AppDelegate sharedInstance].strForContacts=[strLL stringByReplacingOccurrencesOfString:@"0," withString:@""];
    
    
    NSUserDefaults * VIP = [NSUserDefaults standardUserDefaults];
    
    NSMutableString * strFrdsid =[[NSMutableString alloc] init];
    [strFrdsid appendString:@"["];
    NSArray * array = [strLL componentsSeparatedByString:@"0"];
    array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    
    for (int i = 0; i<[array count]; i++) {
        [strFrdsid appendString:[array objectAtIndex:i]];
    }
    [strFrdsid appendString:@"]"];
    
    [VIP setObject:strFrdsid forKey:@"FrdsId"];
    
    
    [UIView animateWithDuration:0.0
                          delay:0
                        options:0
                     animations:^{
                         self.frame=CGRectMake(0,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:.5
                                          animations:^{
                                              self.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.origin.y, self.frame.size.width, self.frame.size.height);
                                              [viewContact removeFromSuperview];
                                          }];
                     }];
    
}

- (IBAction)BackAction:(id)sender {
    [UIView animateWithDuration:0.0
                          delay:0
                        options:0
                     animations:^{
                         self.frame=CGRectMake(0,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:.5
                                          animations:^{
                                              self.frame=CGRectMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.origin.y, self.frame.size.width, self.frame.size.height);
                                              [viewContact removeFromSuperview];
                                          }];
                     }];
    // }
}

-(void)drawData1:(NSString *)flagvalue {
    strLL =[[NSMutableString alloc] init];
    arrCheckSelect = [NSMutableArray new];
    [tblViewForFriends setDelegate:self];
    [tblViewForFriends setDataSource:self];
    
    tblViewForFriends.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    arrForConnectFriends=[[NSMutableArray alloc] init];
    
    //Title For View
    if ([strForCommingFrom isEqualToString:@"TaskDetails"]) {
        //self.title=@"CONNECT FRIENDS";
        [self customRightButton];
    } else {
        ////self.title=@"INVITE FRIENDS";
    }
    
    if([flagvalue isEqualToString:@"yes"]) {
        [self getPhoneBookContacts];
        flagmanage = YES;
    } else {
        flagmanage = NO;
    }
    
    
}
- (void)viewDidLoad
{
    [self customBackButton];
    tblViewForFriends.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    arrForConnectFriends=[[NSMutableArray alloc] init];
    //Title For View
    if ([strForCommingFrom isEqualToString:@"TaskDetails"]) {
        [self customRightButton];
    } else {
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self getPhoneBookContacts];
    //[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    // [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark:IBAction Method:---------
#pragma mark Custom Back Button
-(void) customBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 8, 12)];
    
    [backButton setImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(actionOnBackButton:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barbackItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //self.navigationItem.leftBarButtonItem = barbackItem;
}

-(void) customRightButton {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 12, 12)];
    
    [rightButton setImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(actionForPlusButton) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barbackItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //self.navigationItem.rightBarButtonItem = barbackItem;
}

-(IBAction)actionForConnectBtn:(id)sender {
}

#pragma mark Back button action
-(void)actionOnBackButton:(UIButton *)sender {
}

-(void)actionForPlusButton {
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    ConnectFriendsVC *objConnectFriendsVC = (ConnectFriendsVC *)[storyboard instantiateViewControllerWithIdentifier:@"ConnectFriendsVC"];
    //    objConnectFriendsVC.strForCommingFrom=@"PlusBtn";
    //    [self.navigationController.visibleViewController.navigationController pushViewController:objConnectFriendsVC animated:YES];
}

#pragma mark phone contacts method:-----
-(void)getPhoneBookContacts {
    //[AppDelegate showHud];
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted) {
        //  [AppDelegate killHud];
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
        }
        if(granted) {
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
        
        if(([dict valueForKey:@"first_name"]!=nil && ![[dict valueForKey:@"first_name"]isKindOfClass:[NSNull class]] && ![[dict valueForKey:@"first_name"]isEqualToString:@"" ]) && ([dict valueForKey:@"phone_number"]!=nil && ![[dict valueForKey:@"phone_number"]isKindOfClass:[NSNull class]] && ![[dict valueForKey:@"phone_number"]isEqualToString:@"" ])&& ([dict valueForKey:@"email"]!=nil && ![[dict valueForKey:@"email"]isKindOfClass:[NSNull class]] && ![[dict valueForKey:@"email"]isEqualToString:@"" ])) {
            [arrForConnectFriends addObject:dict];
            
            [arrCheckSelect addObject:@"0"];
            
        }
    }
    dispatch_async(dispatch_get_main_queue(),^{
        
        NSString*strForKey;
        strForKey=@"first_name";
        NSSortDescriptor *hopProfileDescriptor =
        [[NSSortDescriptor alloc] initWithKey:strForKey
                                    ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:hopProfileDescriptor, nil];
        sortedArray = [arrForConnectFriends sortedArrayUsingDescriptors:descriptors];
        
        
        [tblViewForFriends setDelegate:self];
        [tblViewForFriends setDataSource:self];
        [tblViewForFriends reloadData];
        //[AppDelegate killHud];
    });
}
#pragma mark Table view methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(flagmanage) {
        return sortedArray.count;
    } else {
        return arrSearchFrdsList.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(flagmanage) {
        static NSString *cellId=@"cellId";
        CustomContactList *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"CustomContactList" owner:self options:nil];
            cell=[ar lastObject];
        }
        
        NSMutableDictionary * dict = [sortedArray objectAtIndex:indexPath.row];
        cell.lblForName.text=[NSString stringWithFormat:@"%@ %@",dict[@"first_name" ],dict[@"last_name"]];
        cell.asyncImageProfile.clipsToBounds = YES;
        cell.asyncImageProfile.layer.cornerRadius = cell.asyncImageProfile.frame.size.height/2;
        cell.asyncImageProfile.layer.borderWidth = 0.5;
        cell.asyncImageProfile.layer.borderColor = [UIColor whiteColor].CGColor;
        [cell.asyncImageProfile setImage:[UIImage imageNamed:@"menu_option_bg"] forState:UIControlStateNormal];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if ([[arrCheckSelect objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [cell.btnForCheckUncheck setBackgroundImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
        } else {
            [cell.btnForCheckUncheck setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        }
        
        [cell.btnForCheckUncheck addTarget:self action:@selector(actionForCheckUncheck:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnForCheckUncheck.tag=indexPath.row;
        return cell;
        
    } else {
        
        static NSString *cellId=@"cellId";
        CustomContactList *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            NSArray *ar=[[NSBundle mainBundle]loadNibNamed:@"CustomContactList" owner:self options:nil];
            cell=[ar lastObject];
        }
        NSDictionary *dictMain = [arrSearchFrdsList objectAtIndex:indexPath.row];
        NSDictionary *dictuserProfileAvatar = dictMain[@"userProfileAvatar"];
        
        cell.lblForName.text=[NSString stringWithFormat:@"%@",dictMain[@"userName"]];
        cell.asyncImageProfile.clipsToBounds = YES;
        cell.asyncImageProfile.layer.cornerRadius = cell.asyncImageProfile.frame.size.height/2;
        cell.asyncImageProfile.layer.borderWidth = 0.5;
        cell.asyncImageProfile.layer.borderColor = [UIColor whiteColor].CGColor;
       // [cell.asyncImageProfile setImageURL:[NSURL URLWithString:dictuserProfileAvatar[@"selectedAvatar"]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if ([[arrTailgate objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [cell.btnForCheckUncheck setBackgroundImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
        } else {
            [cell.btnForCheckUncheck setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        }
        
        [cell.btnForCheckUncheck addTarget:self action:@selector(actionForCheckUncheck1:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnForCheckUncheck.tag=indexPath.row;
        return cell;
    }
}

-(void)actionForCheckUncheck1:(UIButton*)sender {
    NSMutableString *str;
    UIButton *abc=(UIButton *)sender;
    int i=abc.tag;
    NSDictionary * dictMain = [arrSearchFrdsList objectAtIndex:i];
    NSString * contantno = dictMain[@"id"];
    
    if ([[arrTailgate objectAtIndex:i] isEqualToString:@"0"]) {
        [arrTailgate replaceObjectAtIndex:i withObject:@"1"];
        [abc setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        
        NSString *strTempLL = [NSString stringWithFormat:@"%@,",contantno];
        
        [strLL appendString:[NSString stringWithFormat:@"%@",contantno]];
        
    } else {
        [arrTailgate replaceObjectAtIndex:i withObject:@"0"];
        [abc setBackgroundImage:[UIImage imageNamed:@"ununchecked_icon.png"] forState:UIControlStateNormal];
        strLL = [strLL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",contantno]
                                                 withString:@"0"];
    }
    
}


-(void)actionForCheckUncheck:(UIButton*)sender {
    NSMutableString *str;
    UIButton *abc=(UIButton *)sender;
    int i=abc.tag;
    NSDictionary * dictMain = [sortedArray objectAtIndex:i];
    NSString * contantno = dictMain[@"phone_number"];
    
    if ([[arrCheckSelect objectAtIndex:i] isEqualToString:@"0"]) {
        [arrCheckSelect replaceObjectAtIndex:i withObject:@"1"];
        [abc setBackgroundImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        
        NSString *strTempLL = [NSString stringWithFormat:@"%@,",contantno];
        
        [strLL appendString:[NSString stringWithFormat:@"%@",strTempLL]];
        
    } else {
        [arrCheckSelect replaceObjectAtIndex:i withObject:@"0"];
        [abc setBackgroundImage:[UIImage imageNamed:@"ununchecked_icon.png"] forState:UIControlStateNormal];
        strLL = [strLL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",contantno]
                                                 withString:@"0"];
    }
    
}

#pragma mark - Call Webservice Door Second Tab PostDataList

-(void)GetPostServiceHandler:(id)sender {
  //  [[AppDelegate sharedInstance] killHUD];
    if ([sender isKindOfClass:[NSError class]]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:@"Sorry, we are unable to process the request at this time. Please check your internet connection and try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesButton=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                                        }];
        [alert addAction:yesButton];
        // [self presentViewController:alert animated:YES completion:nil];
        return;
    } else {
        NSDictionary *dictData = (NSDictionary*)sender;
        if ([[NSString stringWithFormat:@"%@", [dictData objectForKey:@"status"]] isEqualToString:@"1"])        {
            arrTailgate = [[NSMutableArray alloc]init];
            arrSearchFrdsList = [[NSMutableArray alloc]init];
            arrSearchFrdsList = [[dictData objectForKey:@"data"] mutableCopy];
            
            for (int i = 0; i < [arrSearchFrdsList count]; i++) {
                NSDictionary *dict=[arrSearchFrdsList objectAtIndex:i];
                NSInteger val = [dict[@"isTailgated"] integerValue];
                
                if (val == 1) {
                    [arrTailgate addObject:@"1"];
                } else {
                    [arrTailgate addObject:@"0"];
                }
            }
            [tblViewForFriends reloadData];
            
        } else if ([[NSString stringWithFormat:@"%@", [dictData objectForKey:@"status"]] isEqualToString:@"-2"]) {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:[NSString stringWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                            }];
            [alert addAction:yesButton];
            // [self presentViewController:alert animated:YES completion:nil];
        } else if ([[NSString stringWithFormat:@"%@", [dictData objectForKey:@"status"]] isEqualToString:@"-3"]) {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:[NSString stringWithFormat:@"Username \"%@\" dose not exist.", @""] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                            }];
            [alert addAction:yesButton];
            // [self presentViewController:alert animated:YES completion:nil];
        }
    }
}



@end
