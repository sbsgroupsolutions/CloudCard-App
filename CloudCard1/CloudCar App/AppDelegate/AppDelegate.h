//
//  AppDelegate.h
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//
#import <Firebase/Firebase.h>
#import "ConstantFinal.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController1.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *root;


@end

