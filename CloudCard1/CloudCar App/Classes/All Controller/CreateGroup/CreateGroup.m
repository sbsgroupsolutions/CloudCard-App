//
//  CreateGroup.m
//  CloudCar App
//
//  Created by Admin on 07/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "CreateGroup.h"

@interface CreateGroup ()

@end

@implementation CreateGroup
@synthesize tblCreate,txtgroup,imggroup;
@synthesize arrContactgroup , strmanagecont ,GroupNameCurName;
@synthesize imgProfile , imgGroupCurrent ,imageDataClorn;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrCreategroup = [NSMutableArray new];
    {
        MyprofileOb * ob = [[MyprofileOb alloc]init];
        ob.lblcategory = @"First Name";
        [arrCreategroup addObject:ob];
    }
    [tblCreate reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [HUD hide:YES];
    
    _btncard.layer.cornerRadius = 4.5;
    _btncard.layer.masksToBounds = YES;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    tblCreate.hidden = YES;
    arrContactlist = [[NSMutableArray alloc]init];
    if([strmanagecont isEqualToString:@"YES"]) {
        //
        arrContactlist = arrContactgroup;
        tblCreate.hidden = NO;
        txtgroup.text = GroupNameCurName;
        NSString *dd = imageDataClorn;
        if(imageDataClorn == nil) {
            //strmanagecont = @"No";
            [tblCreate reloadData];
        } else {
            imageData = imageDataClorn;
            imgProfile.image = [UIImage imageWithData:imageDataClorn];
        }
        if(imageData == nil) {
        
        } else {
            [self progressBar];
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];         [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            NSString *dateString = [dateFormatter stringFromDate:date];
            NSString *dateString1 = [NSString stringWithFormat:@"%@.jpg",dateString];
            
            FIRStorage *storage = [FIRStorage storage];
            FIRStorageReference *storageRef = [storage referenceForURL:@"gs://cloudcard-1d03b.appspot.com"];
            FIRStorageReference *mountainsRef = [storageRef child:dateString1];
            FIRStorageReference *mountainImagesRef = [storageRef child:@".jpg"];
            FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
            metadata.contentType = @"image/jpeg";
            
            mountainsRef.name ==mountainImagesRef.name;         // true
            mountainsRef.fullPath == mountainImagesRef.fullPath;    // false
            FIRStorageReference *riversRef = [storageRef child:mountainsRef.name];
            FIRStorageUploadTask *uploadTask = [riversRef putData:imageDataClorn metadata:metadata completion:^(FIRStorageMetadata* metadata, NSError* error) {
                if (error != nil) {
                } else {
                    NSURL * downloadURL = metadata.downloadURL;
                    base64String = [NSString stringWithFormat:@"%@",downloadURL];
                    imgGroupCurrent= [NSString stringWithFormat:@"%@",downloadURL];
                    [HUD hide:YES];
                }
            }];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrContactlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    ModelClass * obj = [arrContactlist objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    [self.tblCreate setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString *myString = [NSString stringWithFormat:@"Member : %@ %@",obj.fname,obj.lstname];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    NSRange range = [myString rangeOfString:@"Member : "];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    cell.textLabel.attributedText = attString;
    return cell;
}

-(IBAction)hidekey:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)ActionAddMember:(id)sender {
    
    if (imageData == nil) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your group icon!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    
    ContactNo *Cobj = [[ContactNo alloc] init];
    Cobj.strContactlist = @"Yes";
    Cobj.GroupNameCurrent = txtgroup.text;
    Cobj.imageDataCl = imageData;
    Cobj.imgGroupCurrent = imgGroupCurrent;
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  Cobj;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

-(void)progressBar {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [HUD show:YES];
}

-(void)ValidationGroupCreate {
    if (imageData == nil) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your group icon!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if(txtgroup.text==nil || [txtgroup.text isEqualToString:@""]) {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your group name!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    }
    if([arrContactlist count] == 0) {
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your group members!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        [HUD hide:YES];
        return;
    } else {
        [HUD show:YES];

        NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
        NSString * usserId = [VIP objectForKey:@"userid"];
      //  NSString * userEmailId = [VIP objectForKey:@"email"];
       // NSString * UserName = [VIP objectForKey:@"displayName"];
        
        NSMutableString *newPath = [[NSMutableString alloc] init];
        newPath  = [newPath stringByAppendingString:usserId];
        newPath  = [newPath stringByAppendingString:@","];
        
        for (int i = 0; i< [arrContactlist count] ; i++) {
            ModelClass * obj = [arrContactlist objectAtIndex:i];
            NSString * FristUserId = obj.userid;
            newPath  = [newPath stringByAppendingString:FristUserId];
            newPath  = [newPath stringByAppendingString:@","];
        }
        
        NSString * groupname = txtgroup.text;
        FIRDatabaseReference * ref;
        
        FIRDatabaseReference * autoId = [ref childByAutoId];
        FIRDatabaseReference *f= [[FIRDatabase database] referenceFromURL:@"https://cloudcard-1d03b.firebaseio.com/GroupCreateTable"];
        
        [[f childByAutoId] setValue:@{@"Adminuserid" : usserId, @"MemberId" :newPath,@"GroupName" : groupname,@"status" : @"1",@"GroupIcon" :base64String} withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
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
                
                txtgroup.text = nil;
                imgProfile.image= [UIImage imageNamed:@""];
                [arrContactlist removeAllObjects];
                [tblCreate reloadData];
                [HUD hide:YES];

                return;

            }
        }];
    }
}

- (IBAction)ActionCard:(id)sender {
    [self ValidationGroupCreate];
}

- (IBAction)ActionHome:(id)sender {
    Home *rootViewController = [[Home alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionActiveGroup:(id)sender {
    ActiveGroup *rootViewController = [[ActiveGroup alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionFrdList:(id)sender {
    ContactNo *rootViewController = [[ContactNo alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)BackAction:(id)sender {
    if ([strmanagecont isEqualToString:@"YES"]) {
        Home *rootViewController = [[Home alloc] init];
        InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_HVC.topViewController =  rootViewController;
        [self.navigationController
         pushViewController:obj_HVC animated:NO];

    } else {
        [self.navigationController popViewControllerAnimated:NO];
    }
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

- (IBAction)ActionGroupIcon:(id)sender {
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
    tempImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imgProfile.contentMode =  UIViewContentModeScaleAspectFit;
    imgProfile.image = tempImage;
    img_Event = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageData = UIImageJPEGRepresentation(tempImage, 0.6);
 }


- (IBAction)ActionCardAdd:(id)sender {
//    CardAdd *rootViewController = [[CardAdd alloc] init];
//    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
//    obj_HVC.topViewController =  rootViewController;
//    [self.navigationController
//     pushViewController:obj_HVC animated:NO];
    NSString * txtgroup1;
    if(txtgroup.text==nil || [txtgroup.text isEqualToString:@""]) {
        txtgroup1 = @".";
    } else {
        txtgroup1 = txtgroup.text;
    }
    if (imageData == nil) {
        NSString *str = @"helowrld";
        imageData = [str dataUsingEncoding:NSUTF8StringEncoding];
    }
    if(imgGroupCurrent==nil || [imgGroupCurrent isEqualToString:@""]) {
        imgGroupCurrent = @".";
    }
    
    CardAdd *Cobj = [[CardAdd alloc] init];
   // Cobj.strCardlist = @"Yes";
    Cobj.GroupCardNameCurrent = txtgroup1;
    Cobj.imageCardDataCl = imageData;
    Cobj.imgCardGroupCurrent = imgGroupCurrent;
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  Cobj;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

@end
