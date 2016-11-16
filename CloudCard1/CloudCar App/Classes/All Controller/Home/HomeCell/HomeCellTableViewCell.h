//
//  HomeCellTableViewCell.h
//  CloudCar App
//
//  Created by Admin on 02/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "QuartzCore/QuartzCore.h"


@interface HomeCellTableViewCell : UITableViewCell<MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lbllikecount;
@property (strong, nonatomic) IBOutlet UIButton *btnSay;
@property (strong, nonatomic) IBOutlet UIButton *ActionLike;
@property (strong, nonatomic) IBOutlet UILabel *lblunlike;
@property (strong, nonatomic) IBOutlet UIButton *ActionUnlike;

@property(nonatomic,retain) IBOutlet MKMapView *mapview;
@property(strong,nonatomic)IBOutlet UILabel *lati;
@property(strong,nonatomic)IBOutlet UILabel *logi;
@end
