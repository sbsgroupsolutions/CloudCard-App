//
//  HttpsRequest.m
//  NetworkRequestProject
//
//  Created by Techlect on 09/09/14.
//  Copyright (c) 2014 Technology. All rights reserved.
//

/*
 https example url
 
 https://alpha-api.app.net/stream/0/posts/stream/global
 
 */

#import "HttpsRequest.h"

//@interface UIImage (fixorientation)
//- (UIImage *) fixOrientation;
//@end

@implementation IMGDATA
@synthesize fileName;
@synthesize paraName;
@end

static int boolAlertPopup;
static HttpsRequest * obHttpsRequest;

@interface HttpsRequest()
@property (nonatomic, strong) void(^completionHandler)(id);
@end

@implementation HttpsRequest



#pragma mark - isObject
#pragma mark - Internet
#pragma mark - DeviceStoredData
#pragma mark - DistanceBetweenTwoPoints
#pragma mark - maskImage
#pragma mark - InternetRechabilityMonitor

#ifdef __IPHONE_8_0
#define RemoteNotificationTypeAlert UIUserNotificationTypeAlert
#define RemoteNotificationTypeBadge UIUserNotificationTypeBadge
#define RemoteNotificationTypeSound UIUserNotificationTypeSound
#define RemoteNotificationTypeNone  UIUserNotificationTypeNone
#else
#define RemoteNotificationTypeAlert UIRemoteNotificationTypeAlert
#define RemoteNotificationTypeBadge UIRemoteNotificationTypeBadge
#define RemoteNotificationTypeSound UIRemoteNotificationTypeSound
#define RemoteNotificationTypeNone  UIRemoteNotificationTypeNone
#endif

- (NSDate *) dateFromString:(NSString *) str withFormat:(NSString *) format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *dateGST = [dateFormat dateFromString:str];
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:dateGST];
    return [NSDate dateWithTimeInterval:seconds sinceDate:dateGST];
}

- (NSString *) currentDateNTimeString:(NSString *) formate {
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    
    if (formate == nil)
        formate = @"yyyy-MM-dd hh:mm:ss";
    
    [df setDateFormat:formate];
    
    NSString * currentDate = [df stringFromDate:[NSDate date]];
    return currentDate;
}


- (NSDictionary *) convertDate:(NSDate *) date intoFormate:(NSString *) formate {
    @try {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:formate];
        
        NSString * nsString = [dateFormatter stringFromDate:date];
        
        NSDate * nsDate = [dateFormatter dateFromString:nsString];
        
        return @{@"nsstring":nsString, @"nsdate":nsDate};
    } @catch (NSException *exception) {
        return @{@"nsstring":@"", @"nsdate":@""};
    }
}

- (NSDictionary *) getConvertedDateFromSeconds:(double) seconds {
    @try {
        NSTimeInterval timeInterval = (NSTimeInterval)seconds;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        
        NSString *convertedString = [dateFormatter stringFromDate:date];
        
        return @{@"nsstring":convertedString, @"nsdate":date};
    } @catch (NSException *exception) {
        return @{@"nsstring":@"", @"nsdate":@""};
    }
}

@end








