//Created Via PKTSVITS
//  WebserviceOperation.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Reachability1.h"

@interface WebserviceOperation : NSObject<NSURLConnectionDelegate> {
	NSMutableData *responseData;
	id _delegate;
	SEL _callback;
    NSURLConnection *conn;
    
    int RETRY_COUNT;
    
    NSString*strForLogin;
}

@property(nonatomic, retain) 	id _delegate;
@property(nonatomic, assign) 	SEL _callback;

-(id)initWithDelegate:(id)delegate callback:(SEL)callback;


//webservice methods..
//1
-(void)userSignUpByFirstName:(NSString *)firstName
                    LastName:(NSString *)lastName
                    UserName:(NSString *)userName
                    Password:(NSString *)password
                       Phone:(NSString *)phone
                       Email:(NSString *)email
                        City:(NSString *)city
                     Country:(NSString *)country;

//
-(void)createDoorNewPostText:(NSString *)postText
               PostImage:(NSData *)postImage
               PostVideo:(NSString *)postVideo
                Latitude:(NSString *)lat
               Longitude:(NSString *)lng
               DoorId:(NSString *)doorId;

@end
