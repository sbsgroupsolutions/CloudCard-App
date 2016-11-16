//
//  Home.h
//  CloudCar App
//
//  Created by Admin on 02/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//
#import "ConstantFinal.h"
#import "FooterHome.h"
#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "InitialSlidingViewController.h"
#import "MenuViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "QuartzCore/QuartzCore.h"

@interface Home : UIViewController <UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>{
    NSMutableArray *arrhomelist;
    NSMutableArray *arrLikelist;
    NSString * strFlag;
    MBProgressHUD *HUD;
}

@property(nonatomic,retain) IBOutlet MKMapView *mapview;
@property(strong,nonatomic)IBOutlet UILabel *lati;
@property(strong,nonatomic)IBOutlet UILabel *logi;
@property (strong, nonatomic) IBOutlet UITableView *tblHome;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
- (IBAction)ActionPlus:(id)sender;
- (IBAction)ActionHOme:(id)sender;
- (IBAction)ActionGroupuser:(id)sender;
- (IBAction)ActionInvited:(id)sender;
- (IBAction)ActionSetting:(id)sender;

@end
