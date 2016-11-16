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
#import "LoadingViewController.h"
#import "NetworkReachability.h"

#import "NSString+EncodeString.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

@interface UIImage (fixorientation)
- (UIImage *) fixOrientation;
@end

@implementation IMGDATA
@synthesize fileName;
@synthesize paraName;
@synthesize imgProfile;
@end

@implementation UIImage (fixorientation)
- (UIImage *) fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

static int boolAlertPopup;
static HttpsRequest * obHttpsRequest;

@interface HttpsRequest()
@property (nonatomic, strong) void(^completionHandler)(id);
@end

@implementation HttpsRequest

+ (HttpsRequest *) HttpsRequestObject
{
    //if (obHttpsRequest == nil)
        //obHttpsRequest = [HttpsRequest new];
    
    //return obHttpsRequest;
    return [HttpsRequest new];
}

- (void) Toast:(NSString *) msg {
    [ALToastView toastInView:KAppDelegate.window withText:msg isKeyBoardUp:NO];
}

- (void) Toast:(NSString *) msg isKeyBoardUp:(BOOL)u {
    [ALToastView toastInView:KAppDelegate.window withText:msg isKeyBoardUp:u];
}

- (void) JSONFromWebServices:(NSString *) webservice
                   Parameter:(NSMutableDictionary *) param
                      Method:(NSString *) method
                          AI:(BOOL) boolAI
                       PopUP:(BOOL) boolPopUP
                      Caller:(id) vc
                   WithBlock:(void (^)(id json))block
{
    _completionHandler = block;
    
    @try {
        if ([self validateURL:webservice]) {
            if ([self InternetStatus:boolPopUP]) {
                AI = boolAI;
                POPUP = boolPopUP;
                JSONLog = YES;
                [self makeRequest:webservice PostDict:param Caller:vc Method:method];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self PopUP];
                    _completionHandler(nil);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PopUpMSG:kInvalidServerURL Header:@"" ];
                _completionHandler(nil);
            });
        }
    } @catch (NSException *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self PopUP];
            _completionHandler(nil);
        });
    }
}

- (void) JSONFromWebServices:(NSString *) webservice
                   Parameter:(NSMutableDictionary *) param
                      Method:(NSString *) method
                          AI:(BOOL) boolAI
                       PopUP:(BOOL) boolPopUP
                     JsonLog:(BOOL) jsonLog
                      Caller:(id) vc
                   WithBlock:(void (^)(id json))block
{
    _completionHandler = block;
    
    @try {
        if ([self validateURL:webservice]) {
            if ([self InternetStatus:boolPopUP]) {
                AI = boolAI;
                POPUP = boolPopUP;
                JSONLog = jsonLog;
                [self makeRequest:webservice PostDict:param Caller:vc Method:method];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self PopUP];
                    _completionHandler(nil);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PopUpMSG:kInvalidServerURL Header:@"" ];
                _completionHandler(nil);
            });
        }
    } @catch (NSException *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self PopUP];
            _completionHandler(nil);
        });
    }
}

- (void) makeRequest:(NSString *) url PostDict:(NSMutableDictionary *) param Caller:(id) vc Method:(NSString *) mehtod
{
    @try {
        if (AI)
            [[LoadingViewController instance] startRotation];
        
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        
        if (mehtod) {
            [request setHTTPMethod:mehtod];
            
            if ([mehtod isEqualToString:@"GET"]) {
                param = nil;
            }
        } else {
            [request setHTTPMethod:@"GET"];
            param = nil;
        }
        
        if (!param)
            param = [NSMutableDictionary new];
        
        NSData *postData = [self encodeDictionary:param];
        
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
        
        [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        //request.timeoutInterval = 30.0;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response, NSData * data, NSError * error)
         {
             NSString *theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
             
             NSError * e;
             NSMutableDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData: [theReply dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
             
             if (e || !dictJSON) {
                 NSLog(@"theReply-%@-", theReply);
                 
                 if (POPUP)
                     [self performSelectorOnMainThread:@selector(PopUpNetworkMessage) withObject:nil waitUntilDone:NO];
             }
             
             if (AI)
                 [[LoadingViewController instance] stopRotation];
             
             if (vc && JSONLog) {
                 NSLog(@"Response-%@\nAPI   -%@-\nPARAM -%@\nJSON  -%@", vc, url, param, dictJSON);
             }
             
             _completionHandler(dictJSON);
         }];
    } @catch (NSException *exception) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self PopUP];
            _completionHandler(nil);
        });
    }
}

- (NSData *)encodeDictionary:(NSDictionary *) dictionary {
    NSMutableArray * parts = [[NSMutableArray alloc] init];
    for (NSString * key in dictionary) {
        NSString *part = [NSString stringWithFormat: @"%@=%@", [NSString encodeString:key], [NSString encodeString:dictionary[key]]];
        [parts addObject:part];
    }
    
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

- (void) UploadFileWebserviceSync:(NSString *) webservice
                         FileName:(NSString *) fileName
                         ParaName:(NSString *) paraName
                         FileType:(NSString *) fileType
                             Data:(NSData * )fileData
                            PopUp:(BOOL) boolPopUp
                               AI:(BOOL) boolAI
                           Caller:(id) vc
                        WithBlock:(void (^)(id json)) block {
    @try {
        if ([self validateURL:webservice]) {
            if (boolAI)
                [[LoadingViewController instance] startRotation];
                        
            webservice = [webservice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"UploadFileWebservice-%@-%lu-%@", vc, (unsigned long)fileData.length, webservice);
            
            NSURL *url = [NSURL URLWithString:webservice];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url] ;
            request.HTTPMethod = @"POST";
            
            NSString *boundary = @"0xKhTmLbOuNdArY";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary, nil];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", paraName, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: application/%@\r\n\r\n", fileType] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:fileData];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response, NSData * data, NSError * error)
             {
                 NSString *theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
                 
                 NSError * e;
                 NSMutableDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData: [theReply dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
                 
                 if (boolAI)
                     [[LoadingViewController instance] stopRotation];
                 
                 if (e) {
                     if (boolPopUp)
                         [self performSelectorOnMainThread:@selector(PopUpNetworkMessage) withObject:nil waitUntilDone:NO];
                 }
                 
                 if (e || !dictJSON)
                     NSLog(@"theReply-%@-", theReply);
                 
                 if (vc) {
                     NSLog(@"API%@-%@-", vc, url);
                     NSLog(@"API%@-%@-", vc, dictJSON);
                 }
                 
                 block(dictJSON);
             }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PopUpMSG:kInvalidServerURL Header:@""];
                block(nil);
            });
        }
    } @catch (NSException *exception) {
        if (boolAI)
            [[LoadingViewController instance] stopRotation];
        
        block(nil);
    }
}

- (void) UploadFileWebserviceSync:(NSString *) webservice
                         FileName:(NSString *) fileName
                         ParaName:(NSString *) paraName
                            Image:(UIImage *) imgProfile
                            PopUp:(BOOL) boolPopUp
                               AI:(BOOL) boolAI
                           Caller:(id) vc
                        WithBlock:(void (^)(id json)) block {
    @try {
        if ([self validateURL:webservice]) {
            if (boolAI)
                [[LoadingViewController instance] startRotation];
            
            NSData *fileData = UIImageJPEGRepresentation([imgProfile fixOrientation], 0.2);
            
            webservice = [webservice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"UploadFileWebservice-%@-%lu-%@", vc, (unsigned long)fileData.length, webservice);
            
            NSURL *url = [NSURL URLWithString:webservice];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url] ;
            request.HTTPMethod = @"POST";
            
            NSString *boundary = @"0xKhTmLbOuNdArY";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary, nil];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", paraName, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:fileData];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response, NSData * data, NSError * error)
             {
                 NSString *theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
                 
                 NSError * e;
                 NSMutableDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData: [theReply dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
                 
                 if (boolAI)
                     [[LoadingViewController instance] stopRotation];
                 
                 if (e) {
                     if (boolPopUp)
                         [self performSelectorOnMainThread:@selector(PopUpNetworkMessage) withObject:nil waitUntilDone:NO];
                 }
                 
                 if (e || !dictJSON)
                     NSLog(@"theReply-%@-", theReply);
                     
                 if (vc) {
                     NSLog(@"API%@-%@-", vc, url);
                     NSLog(@"API%@-%@-", vc, dictJSON);
                 }
                 
                 block(dictJSON);
             }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PopUpMSG:kInvalidServerURL Header:@""];
                block(nil);
            });
        }
    } @catch (NSException *exception) {
        if (boolAI)
            [[LoadingViewController instance] stopRotation];
        
        block(nil);
    }
}

- (void) UploadImages:(NSString *) webservice
                Param:(NSMutableArray *) param
                PopUp:(BOOL) boolPopUp
                   AI:(BOOL) boolAI
               Caller:(id) vc
            WithBlock:(void (^)(id json)) block {
    @try {
        if ([self validateURL:webservice]) {
            if (boolAI)
                [[LoadingViewController instance] startRotation];

            webservice = [webservice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        
            NSURL *url = [NSURL URLWithString:webservice];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url] ;
            request.HTTPMethod = @"POST";
            
            NSString *boundary = @"0xKhTmLbOuNdArY";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary, nil];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            for (int i = 0; i < param.count; i++) {
                
                IMGDATA * obIMGDATA = param[i];
                
                if (obIMGDATA.imgProfile && obIMGDATA.paraName && obIMGDATA.fileName) {
                    NSData *fileData = UIImageJPEGRepresentation([obIMGDATA.imgProfile fixOrientation], 0.2);
                    
                    NSLog(@"UploadFileWebservice-%@-%lu-%@", vc, (unsigned long)fileData.length, webservice);
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", obIMGDATA.paraName, obIMGDATA.fileName] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:fileData];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                }
            }
            
            [request setHTTPBody:body];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response, NSData * data, NSError * error)
             {
                 NSString *theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
                 
                 NSError * e;
                 NSMutableDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData: [theReply dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
                 
                 if (boolAI)
                     [[LoadingViewController instance] stopRotation];
                 
                 if (e) {
                     if (boolPopUp)
                         [self performSelectorOnMainThread:@selector(PopUpNetworkMessage) withObject:nil waitUntilDone:NO];
                 }
                 
                 if (e || !dictJSON)
                     NSLog(@"theReply-%@-", theReply);
                 
                 if (vc) {
                     NSLog(@"API%@-%@-", vc, url);
                     NSLog(@"API%@-%@-", vc, dictJSON);
                 }
                 
                 block(dictJSON);
             }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self PopUpMSG:kInvalidServerURL Header:@""];
                block(nil);
            });
        }
    } @catch (NSException *exception) {
        if (boolAI)
            [[LoadingViewController instance] stopRotation];
        
        block(nil);
    }
}

- (BOOL) validateURL:(NSString *) urlString {
	return YES;
    
    /*NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return [NSURLConnection canHandleRequest:request];
   
	NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	
	NSPredicate *urlValidator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
	return [urlValidator evaluateWithObject:urlString];*/
}

- (BOOL) check:(NSString *) url
{
    NSURL *candidateURL = [NSURL URLWithString:url];
    
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - PopUP

- (void) PopUP
{
    if (POPUP) {
        [self performSelectorOnMainThread:@selector(PopUpNetworkMessage) withObject:nil waitUntilDone:NO];
    }
}

- (void) PopUpNetworkMessage
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Network Message" message:kCouldnotconnect delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void) PopUpMSG:(NSString *) msg Header:(NSString *) header
{
    if ([self isObject:msg TypeOf:Type_Str]) {
        if (![self isObject:header TypeOf:Type_Str])
            header = @"";
        [self performSelectorOnMainThread:@selector(PopUpMSGThread:) withObject:[NSArray arrayWithObjects:msg, header, nil] waitUntilDone:NO];
    }
}

- (void) PopUpMSGThread:(NSArray *) arr
{
    if ([self isObject:[arr objectAtIndex:0] TypeOf:Type_Str]) {
        if (![self isObject:[arr objectAtIndex:1] TypeOf:Type_Str])
            [[[UIAlertView alloc] initWithTitle:@"" message:[arr objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        else
            [[[UIAlertView alloc] initWithTitle:[arr objectAtIndex:1] message:[arr objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (void) PopUpMSGPop:(NSString *) msg Header:(NSString *) header
{
    if ([self isObject:msg TypeOf:Type_Str]) {
        if (![self isObject:header TypeOf:Type_Str])
            header = @"";
        
        [self performSelectorOnMainThread:@selector(PopUpMSGThreadOwner:) withObject:[NSArray arrayWithObjects:msg, header, nil] waitUntilDone:NO];
    }
}

- (void) PopUpMSGThreadOwner:(NSArray *) arr
{
    if (arr.count == 2) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[arr objectAtIndex:1] message:[arr objectAtIndex:0] delegate:KAppDelegate.vcContainerViewController cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1111;
        [alert show];
    }
}

#pragma mark - isObject

- (BOOL) isObjectNotNil:(id) ob
{
    if (ob == nil)
        return NO;
    
    if ([ob isKindOfClass:[NSNull class]])
        return NO;
    
    return YES;
}

- (BOOL) isObject:(id) ob TypeOf:(int) which
{
    @try {
        if (ob) {
            if (![ob isKindOfClass:[NSNull class]]) {
                if (which == Type_Str) {
                    if ([ob isKindOfClass:[NSString class]]) {
                        return YES;
                    } else {
                        if ([ob isKindOfClass:[NSMutableString class]])
                            return YES;
                        else
                            return NO;
                    }
                } else if (which == Type_Arr) {
                    if ([ob isKindOfClass:[NSArray class]]) {
                        return YES;
                    } else {
                        if ([ob isKindOfClass:[NSMutableArray class]])
                            return YES;
                        else
                            return NO;
                    }
                } else if (which == Type_Dct) {
                    if ([ob isKindOfClass:[NSDictionary class]]) {
                        return YES;
                    } else {
                        if ([ob isKindOfClass:[NSMutableDictionary class]])
                            return YES;
                        else
                            return NO;
                    }
                } else if (which == Type_Int) {
                    if ([ob isKindOfClass:[NSNumber class]]) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else if (which == Type_Img) {
                    if ([ob isKindOfClass:[UIImage class]])
                        return YES;
                    else
                        return NO;
                } else if (which == Type_Lbl) {
                    if ([ob isKindOfClass:[UILabel class]])
                        return YES;
                    else
                        return NO;
                } else if (which == Type_ImV) {
                    if ([ob isKindOfClass:[UIImageView class]])
                        return YES;
                    else
                        return NO;
                } else if (which == Type_Btn) {
                    if ([ob isKindOfClass:[UIButton class]])
                        return YES;
                    else
                        return NO;
                } else if (which == Type_Viw) {
                    if ([ob isKindOfClass:[UIView class]])
                        return YES;
                    else
                        return NO;
                }
            } else {
                return NO;
            }
        } else {
            return NO;
        }
        
        return NO;
    } @catch (NSException *exception) {
        return NO;
    }
}

#pragma mark - Internet

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 55) {
        boolAlertPopup = NO;
    }
}

- (BOOL) InternetStatus:(BOOL) popup
{
    if ([self isInternetAvailable]) {
        return YES;
    } else if (popup) {
        dispatch_async(dispatch_get_main_queue(), ^{
            /*if (!boolAlertPopup) {
                @synchronized(self) {
                    boolAlertPopup = YES;
                }
                
                if (boolAlertPopup) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:kInternetNotAvailable delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 55;
                    
                    [alert show];
                }
            }*/
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:kInternetNotAvailable delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 55;
            
            [alert show];
        });
        
        return NO;
    }
    
    return YES;
}

- (BOOL) InternetStatus
{
    if ([self isInternetAvailable]) {
        return YES;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"" message:kInternetNotAvailable delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        });
        
        return NO;
    }
    
    return YES;
}

-(BOOL)isInternetAvailable
{
    NetworkReachability * objReach = [NetworkReachability reachabilityForInternetConnection];
    NetworkStatus status = [objReach currentReachabilityStatus];
    
    if (status == NotReachable)
        return NO;
    
    return YES;
}

-(int) netConnection
{
    NetworkReachability * objReach = [NetworkReachability reachabilityForInternetConnection];
    NetworkStatus status = [objReach currentReachabilityStatus];
    
    if (status == NotReachable)
        return Net_NotReachable;
    else if (status == ReachableViaWiFi)
        return Net_ReachableViaWiFi;
    else if (status == ReachableViaWWAN)
        return Net_ReachableViaWWAN;
    
    return 0;
}

#pragma mark - jsonString

-(NSString*) jsonString:(id) ob {
    NSError *error;
    BOOL prettyPrint = NO;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ob
                                                       options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        if ([obNet isObject:ob TypeOf:Type_Dct]) {
            return @"{}";
        } else if ([obNet isObject:ob TypeOf:Type_Arr]) {
            return @"[]";
        } else {
            return nil;
        }
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

#pragma mark - DeviceStoredData

- (void) setDeviceStoredData:(NSString *) data
{
    @try {
        if (!obKeyChainItemWrapper)
            obKeyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KeyChainItemWrapper_Identifier accessGroup:nil];
        
        [obKeyChainItemWrapper savePassword:data];
    } @catch (NSException *exception) { }
}

- (NSMutableArray *) getDeviceStoredData
{
    @try {
        if (!obKeyChainItemWrapper)
            obKeyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KeyChainItemWrapper_Identifier accessGroup:nil];
        
        NSString * data = [obKeyChainItemWrapper retrievePassword];
        
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:0 error:NULL];
        //NSLog(@"getDeviceStoredData-%@", jsonObject);
        
        NSMutableArray * arr = [NSMutableArray arrayWithArray:jsonObject];
        
        NSLog(@"getDeviceStoredData-%@-", arr);
        
        return arr;
    } @catch (NSException *exception) { }
    
    return [NSMutableArray new];
}

- (NSMutableDictionary *) getDeviceStoredDataAsDictionary
{
    @try {
        if (!obKeyChainItemWrapper)
            obKeyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:KeyChainItemWrapper_Identifier accessGroup:nil];
        
        NSString * data = [obKeyChainItemWrapper retrievePassword];
        
        NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding]
                                                                          options:0 error:NULL];
        //NSLog(@"getDeviceStoredData-%@", jsonObject);
        
        NSMutableDictionary * arr = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
        
        return arr;
    } @catch (NSException *exception) { }
    
    return [NSMutableDictionary new];
}

#pragma mark - DistanceBetweenTwoPoints

CGFloat DistanceBetweenTwoPoints(CGPoint point1,CGPoint point2)
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}

#pragma mark - ConvertDate

- (NSString *) ConvertDate:(NSString *) toDate FromFormate:(NSString *) fromFormate ToFormate:(NSString *) toFormate
{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:fromFormate];
        
        NSDate *date = [formatter dateFromString:toDate];
        
        [formatter setDateFormat:toFormate];
        
        NSString * output = [formatter stringFromDate:date];
        
        if (!output)
            output = toDate;
        
        return output;
    } @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - maskImage

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
}

#pragma mark - InternetRechabilityMonitor

- (void) InternetRechabilityMonitor
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    NetworkReachability * reach = [NetworkReachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(NetworkReachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Network Reachability" message:@"Notification Says Reachable" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    };
    
    reach.unreachableBlock = ^(NetworkReachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Network Reachability" message:@"Notification Says Unreachable" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        });
    };
    
    [reach startNotifier];
}

-(void)reachabilityChanged:(NSNotification*)note
{
    NetworkReachability * reach = [note object];
    
    if([reach isReachable]) {
        [self PopUpMSG:@"Notification Says Reachable" Header:@"Network Reachability"];
    } else {
        [self PopUpMSG:@"Notification Says Unreachable" Header:@"Network Reachability"];
    }
}

- (void) setBorder:(UIView *) view Color:(UIColor *) color CornerRadious:(float) cr BorderWidth:(float) bw
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cr;
    view.layer.borderWidth = bw;
    view.layer.borderColor = color.CGColor;
}

- (void) setBorder:(UIView *) view ColorArray:(NSArray *) colorArray CornerRadious:(float) cr BorderWidth:(float) bw
{
    NSString * red   = colorArray[0]; //red
    NSString * green = colorArray[1]; //green
    NSString * blue  = colorArray[2]; //blue
    
    NSString * alpha = @"1.0";
    
    if (colorArray.count == 4)
        alpha = colorArray[3];        //alpha
    
    UIColor * color = [UIColor colorWithRed:red.doubleValue/255.0 green:green.doubleValue/255.0 blue:blue.doubleValue/255.0 alpha:alpha.doubleValue];
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cr;
    view.layer.borderWidth = bw;
    view.layer.borderColor = color.CGColor;
}

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

- (void) initRegisterPN:(UIApplication *)application
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else
#endif
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
}

- (NSString *) getPNToken:(NSData*) deviceToken
{
    NSString * token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return [token copy];
}

- (NSString *) base64forData:(NSData *) theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (void) setUserInfoObject:(id) object {
//    if (object) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:encodedObject forKey:USERLOGINDATA];
        [defaults synchronize];
//    }
}

- (id) getUserInfoObject {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:USERLOGINDATA];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return object;
}

- (void) setDefaultUserData:(id) object WithKey:(NSString *) key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:object];
    [defaults setObject:myData forKey:key];
    [defaults synchronize];
}

- (id) getDefaultUserDataWithKey:(NSString *) key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *encodedObject = [defaults objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return object;
}

- (NSDateComponents *) ageFrom:(NSDate   *) from
                        ToDate:(NSDate   *) to
                FromDateString:(NSString *) fromDateString
               FromDateFormate:(NSString *) fromDateFormate
                  toDateString:(NSString *) toDateString
                 toDateFormate:(NSString *) toDateFormate
{
    if (from == nil) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:fromDateFormate];
        from = [dateFormatter dateFromString:fromDateString];
    }
    
    if (to == nil) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:toDateFormate];
        to = [dateFormatter dateFromString:toDateString];
    }
    
    @try {
        if (from && to) {
            NSDateComponents * ageComponents = [[NSCalendar currentCalendar]
                                                components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                fromDate:from
                                                toDate:to
                                                options:0];
            
            return ageComponents;
        } else {
            return [NSDateComponents new];
        }
    } @catch (NSException *exception) { }
}

- (NSString *) UUID {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (CGRect) deviceFrame {
    return [UIScreen mainScreen].bounds;
}

- (NSString *) getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (void) startSpaceTo:(UITextField *)textfield Space:(float) space
{
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, space, space)];
    [textfield setLeftViewMode:UITextFieldViewModeAlways];
    [textfield setLeftView:spacerView];
}

- (void) titleInMoreLines:(UIButton *) button
{
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    //[button setTitle: @"Line1\nLine2" forState: UIControlStateNormal];
}

- (void) setHtml: (NSString*) html Label:(UILabel *) lbl
{
    NSError *err = nil;
    lbl.attributedText = [[NSAttributedString alloc] initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                               documentAttributes: nil
                                                            error: &err];
    
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *) font {
    CGSize size = CGSizeZero;
    if (text) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size;
}

- (id) getJsonFromFile:(NSString *) filename {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSError * e;
    NSMutableDictionary *dictJSON = [NSJSONSerialization JSONObjectWithData: [content dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
    
    return dictJSON;
}

- (BOOL) checkJson:(id) json PassPopUp:(BOOL) boolPass FailPopUp:(BOOL) boolFail {
    if (json) {
        NSString * status = json[@"status"];
        
        if ([obNet isObject:status TypeOf:Type_Int]) {
            if (status.intValue == 1) {
                if (boolPass) ToastMSG(json[@"message"]);
                return YES;
            } else {
                if (boolFail) ToastMSG(json[@"message"]);
                return NO;
            }
        }
    }
    
    return NO;
}

- (UIColor *) colorWithHexString:(NSString *) hex
{
    //[self colorWithHexString:@"FFFFFF"]
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

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

- (BOOL) canDevicePlaceAPhoneCall:(BOOL) popUP; {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        // Device supports phone calls, lets confirm it can place one right now
        CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [netInfo subscriberCellularProvider];
        NSString *mnc = [carrier mobileNetworkCode];
        if (([mnc length] == 0) || ([mnc isEqualToString:@"65535"])) {
            // Device cannot place a call at this time.  SIM might be removed.
            
            if (popUP)
                PopUp(@"Device cannot place a call at this time. SIM might be removed.", @"");
            
            return NO;
        } else {
            // Device can place a phone call
            return YES;
        }
    } else {
        // Device does not support phone calls
        return  NO;
    }
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








