 //
//  AppDelegate.m
//  CloudCar App
//
//  Created by Admin on 29/08/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    //    ViewController1 *welComeVC = [[ViewController1 alloc]initWithNibName:@"ViewController1" bundle:nil];
    //
    //
    //    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:welComeVC];
    //
    
    
    
    ViewController1 *welComeVC = [[ViewController1 alloc]initWithNibName:nil bundle:nil];
    
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    obj_HVC.topViewController =  welComeVC;
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:welComeVC];
    
    
    
    [nav setNavigationBarHidden:YES];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
                // NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    
    [locationManager startUpdatingLocation];

    [self getCurrentLocation];
    [self get_CurruntLocation];

    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
        
    } else {
        
        
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

#pragma mark - Push Notification  Methods

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSLog(@"My token is: %@", deviceToken);
    
    NSString *str=[[[deviceToken description]
                    stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                   stringByReplacingOccurrencesOfString:@" "
                   withString:@""];
    
    if(str!=nil){
        
        if (str.length==0) {
            str=@"5c2fccfd81d7a0d1a3b386de07f1f7b12e3a1ef268cdaa2c7ab7641cd2cadc0a";
        }
        
    }
    NSLog(@"strNtn======%@",str);
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:str forKey:@"GCMId"];
    
}
#pragma mark - Get Current Location  Methods
#pragma mark -



-(void)get_CurruntLocation
{
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    //_myMapview.showsUserLocation = YES;
    
    [self->locationManager startUpdatingLocation];
    
    
    CLLocation *location = [locationManager location];
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
    [VIP setObject:latitude forKey:@"latitude"];
    [VIP setObject:longitude forKey:@"longitude"];
    
}

-(void)getCurrentLocation {
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
       NSString * a = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString * a8 = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    
    NSString *str_Lat =[NSString stringWithFormat:@"%f",location.coordinate.latitude];
    
    NSString *str_Long =[NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    NSString *str_LatLong = [NSString stringWithFormat:@"%@,%@",str_Lat,str_Long];
    
    [[NSUserDefaults standardUserDefaults] setObject:str_LatLong forKey:@"LATLONG"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
