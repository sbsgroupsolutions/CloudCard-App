//
//  HttpsRequest.h
//  NetworkRequestProject
//
//  Created by Techlect on 09/09/14.
//  Copyright (c) 2014 Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToastMSG.h"
#import "LoadingViewController.h"
#import "UIImageView+Custom.h"

#import "KeychainItemWrapper.h"

#import "ALToastView.h"
#import "NSString+EncodeString.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define USERLOGINDATA @"USERLOGINDATA"

#define obNet ([HttpsRequest HttpsRequestObject])

#define ToastMSGK(m,u) ([obNet Toast:m isKeyBoardUp:u])
#define ToastMSG(m) ([obNet Toast:m isKeyBoardUp:NO])

#define PopUp(m,s) ([obNet PopUpMSG:m Header:s])
#define PopUpPop(m,s) ([obNet PopUpMSGPop:m Header:s])

#define IsObNotNil(o) [obNet isObjectNotNil:o]

#define CALLER ([NSString stringWithFormat:@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__])

#define isIPhone     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isIPad       ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE_4  (([UIScreen mainScreen].bounds.size.width == 320) && ([UIScreen mainScreen].bounds.size.height == 480))
#define IS_IPHONE_5  (([UIScreen mainScreen].bounds.size.width == 320) && ([UIScreen mainScreen].bounds.size.height == 568))
#define IS_IPHONE_6  (([UIScreen mainScreen].bounds.size.width == 375) && ([UIScreen mainScreen].bounds.size.height == 667))
#define IS_IPHONE_6P (([UIScreen mainScreen].bounds.size.width == 414) && ([UIScreen mainScreen].bounds.size.height == 736))

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kGPS @"Please establish GPS."
#define kInternetNotAvailable @"Please establish network connection."
#define kCouldnotconnect @"Could not connect to the server. Please try again later."
#define KAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kInvalidServerURL @"Invalid server URL"

#define Net_NotReachable     1
#define Net_ReachableViaWiFi 2
#define Net_ReachableViaWWAN 3

#define Type_Str 1
#define Type_Arr 2
#define Type_Dct 3
#define Type_Int 4
#define Type_Img 5
#define Type_Lbl 6
#define Type_ImV 7
#define Type_Btn 8
#define Type_Viw 9

@interface IMGDATA : NSObject
@property (strong, nonatomic) NSString * fileName;
@property (strong, nonatomic) NSString * paraName;
@property (strong, nonatomic) UIImage  * imgProfile;
@end

@interface HttpsRequest : NSObject <UIAlertViewDelegate>
{
    KeychainItemWrapper * obKeyChainItemWrapper;
    
    BOOL POPUP;
    BOOL JSONLog;
    BOOL AI;
    
    //BOOL boolAlertPopup;
}

+ (HttpsRequest *) HttpsRequestObject;

- (void) JSONFromWebServices:(NSString *) webservice
                   Parameter:(NSMutableDictionary *) param
                      Method:(NSString *) method
                          AI:(BOOL) boolAI
                       PopUP:(BOOL) boolPopUP
                      Caller:(id) vc
                   WithBlock:(void (^)(id json))block;

- (void) JSONFromWebServices:(NSString *) webservice
                   Parameter:(NSMutableDictionary *) param
                      Method:(NSString *) method
                          AI:(BOOL) boolAI
                       PopUP:(BOOL) boolPopUP
                     JsonLog:(BOOL) jsonLog
                      Caller:(id) vc
                   WithBlock:(void (^)(id json))block;

- (void) UploadFileWebserviceSync:(NSString *) webservice
                         FileName:(NSString *) fileName
                         ParaName:(NSString *) paraName
                            Image:(UIImage *) imgProfile
                            PopUp:(BOOL) boolPopUp
                               AI:(BOOL) boolAI
                           Caller:(id) vc
                        WithBlock:(void (^)(id json)) block;

- (void) UploadImages:(NSString *) webservice
                Param:(NSMutableArray *) param
                PopUp:(BOOL) boolPopUp
                   AI:(BOOL) boolAI
               Caller:(id) vc
            WithBlock:(void (^)(id json)) block;

- (void) UploadFileWebserviceSync:(NSString *) webservice
                         FileName:(NSString *) fileName
                         ParaName:(NSString *) paraName
                         FileType:(NSString *) fileType
                             Data:(NSData * )fileData
                            PopUp:(BOOL) boolPopUp
                               AI:(BOOL) boolAI
                           Caller:(id) vc
                        WithBlock:(void (^)(id json)) block;

- (void) PopUpMSG:(NSString *) msg Header:(NSString *) header;
- (BOOL) isObject:(id) ob TypeOf:(int) which;
- (BOOL) isObjectNotNil:(id) ob;

- (BOOL) InternetStatus;
- (BOOL) InternetStatus:(BOOL) popup;
- (int) netConnection;
- (BOOL) isInternetAvailable;

-(NSString *) jsonString:(id) ob;

- (void) setDeviceStoredData:(NSString *) data;
- (NSMutableArray *) getDeviceStoredData;
- (NSMutableDictionary *) getDeviceStoredDataAsDictionary;

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2);

- (NSString *) ConvertDate:(NSString *) toDate FromFormate:(NSString *) fromFormate ToFormate:(NSString *) toFormate;

- (UIImage *) maskImage:(UIImage *) image withMask:(UIImage *) maskImage;

- (void) InternetRechabilityMonitor;

- (void) setBorder:(UIView *) view Color:(UIColor *) color CornerRadious:(float) cr BorderWidth:(float) bw;
- (void) setBorder:(UIView *) view ColorArray:(NSArray *) colorArray CornerRadious:(float) cr BorderWidth:(float) bw;

- (void) initRegisterPN:(UIApplication *)application;

- (NSString *) getPNToken:(NSData*) deviceToken;

- (NSString *) base64forData:(NSData *) theData;

- (void) setUserInfoObject:(id) object;

- (id) getUserInfoObject;

- (void) setDefaultUserData:(id) object WithKey:(NSString *) key;
- (id) getDefaultUserDataWithKey:(NSString *) key;

- (NSDateComponents *) ageFrom:(NSDate   *) from
                        ToDate:(NSDate   *) to
                FromDateString:(NSString *) fromDateString
               FromDateFormate:(NSString *) fromDateFormate
                  toDateString:(NSString *) toDateString
                 toDateFormate:(NSString *) toDateFormate;

- (NSString *) UUID;
- (CGRect) deviceFrame;

- (NSString *) getIPAddress;

- (void) startSpaceTo:(UITextField *)textfield Space:(float) space;
- (void) titleInMoreLines:(UIButton *) button;

- (void) setHtml: (NSString*) html Label:(UILabel *) lbl;

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *) font ;

- (id) getJsonFromFile:(NSString *) filename;

- (BOOL) checkJson:(id) json PassPopUp:(BOOL) boolPass FailPopUp:(BOOL) boolFail;

- (void) Toast:(NSString *) msg isKeyBoardUp:(BOOL)u;
- (void) Toast:(NSString *) msg;

- (UIColor *) colorWithHexString:(NSString *) hex;

- (NSDate *) dateFromString:(NSString *) str withFormat:(NSString *) format;
- (NSString *) currentDateNTimeString:(NSString *) formate;
- (BOOL) canDevicePlaceAPhoneCall:(BOOL) popUP;
- (NSDictionary *) convertDate:(NSDate *) date intoFormate:(NSString *) formate;
- (NSDictionary *) getConvertedDateFromSeconds:(double) seconds;

- (void) PopUpMSGPop:(NSString *) msg Header:(NSString *) header;

@end













