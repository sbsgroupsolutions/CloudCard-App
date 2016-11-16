
// WebserviceOperation.m
//Created Via PKTSVITS



#import "WebserviceOperation.h"
#import "Constant.h"

//#import "JSON/JSON.h"


@implementation WebserviceOperation
@synthesize	_delegate;
@synthesize _callback;

//-(void)dealloc{
//	[_delegate release];
//	[super dealloc];
//}
#define baseUrl @"https://api.mastercard.com/mdes/csapi/v2/search"

//  NSString * Base_url = [NSString stringWithFormat:@"%@%@",@"https://api.mastercard.com/mdes/csapi/v2/search/",@"consumer_key%3DgUWIjkkenxkfJaUSx_LTt0Y1kXabcMT03u2123abcf5dJJJF%26RSA-SHA1%26oauth_timestamp%3D1313705674%26"];
-(id)initWithDelegate:(id)delegate callback:(SEL)callback{
	if (self = [super init]) {
		self._delegate = delegate;
		self._callback = callback;
	}
	return self;
}

#pragma mark 1. SignUp
-(void)userSignUpByFirstName:(NSString *)firstName
                LastName:(NSString *)lastName
               UserName:(NSString *)userName
                Password:(NSString *)password
                   Phone:(NSString *)phone
                   Email:(NSString *)email
                   City:(NSString *)city
                 Country:(NSString *)country
{
    strForLogin=@"login";
    RETRY_COUNT = 0;
    
    responseData = [[NSMutableData alloc] init] ;
    NSString *body=[NSString stringWithFormat:@"firstName=%@&lastName=%@&userName=%@&password=%@&phone=%@&email=%@&city=%@&country=%@", firstName, lastName, userName, password, phone, email, city, country];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", baseUrl]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark 29. Get Searching
//-(void)getSearchingpageNo:(NSString *)pageNo
//                    limit:(NSString *)limit
//                 userName:(NSString *)userName
//                firstName:(NSString *)firstName
//                 lastName:(NSString *)lastName
//                    phone:(NSString *)phone
//                    email:(NSString *)email {
//    
//    RETRY_COUNT = 0;
//    
//    responseData = [[NSMutableData alloc] init] ;
//    NSString *body=[NSString stringWithFormat:@"pageNo=%@limit=%@&userName=%@&firstName=%@&lastName=%@&phone=%@&email=%@",pageNo,limit,userName,firstName,lastName,phone,email];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", baseUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    
//    NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPMethod:@"POST"];
//    
//    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
//    
//    [request setHTTPBody:data];
//    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//}

#pragma mark ----------------------------------------------------------------------------
#pragma mark - WebService Response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
    if ([strForLogin isEqualToString:@"login"])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if ([response respondsToSelector:@selector(allHeaderFields)])
        {
            NSDictionary *dictionary = [httpResponse allHeaderFields];
            if([[[[dictionary valueForKey:@"Set-Cookie"] componentsSeparatedByString:@";"] firstObject] length]>8)
            {
                NSLog(@"om=%@",[[[dictionary valueForKey:@"Set-Cookie"] componentsSeparatedByString:@";"] firstObject]);
                [[NSUserDefaults standardUserDefaults]setObject:[[[dictionary valueForKey:@"Set-Cookie"] componentsSeparatedByString:@";"] firstObject] forKey:@"Cookie"];
            }
        }
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (error!=nil) {
     if([[Reachability1 sharedReachability] internetConnectionStatus] == NotReachable) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No network connection, please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }
    }
    
//	if ([self._delegate respondsToSelector:self._callback]) {
//        
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        [self._delegate performSelector:self._callback withObject:error];
//#pragma clang diagnostic pop
//		
//	}else {
//		////NSLog(@"Callback is not responding.");
//	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	strForLogin=@"";
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"\n---------------------------------------------------------\n %@\n----------------------------------------------------------\n",responseString);

 
//    responseString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    
//    
//    if ([responseString hasPrefix:@"\""]) {
//        responseString = [responseString substringFromIndex:1];
//    }
//    
//    if ([responseString hasSuffix:@"\""]) {
//        responseString = [responseString substringToIndex:[responseString length]-1];
//        
//    }
    
    NSLog(@"responseString = %@",responseString);
    NSError *error;
    NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id json=  [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:&error];
    if (json == nil){
        if ([self._delegate respondsToSelector:self._callback]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self._delegate performSelector:self._callback withObject:error];
#pragma clang diagnostic pop
            
            
        }
    }
    else{
        if([self._delegate respondsToSelector:self._callback]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self._delegate performSelector:self._callback withObject:json];
#pragma clang diagnostic pop
            
            
        }
        else{
            ////NSLog(@"Callback is not responding.");
        }
    }
}


-(void)RetryWebservice

{
    
    if (RETRY_COUNT< 50) // It will
        
    {
        
        RETRY_COUNT = RETRY_COUNT+1;
        
        conn=[[NSURLConnection alloc] initWithRequest:conn.currentRequest delegate:self];
        
    }
    
}
@end
