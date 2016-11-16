//
//  CardAdd.m
//  
//
//  Created by Admin on 10/10/16.
//
//
#import "SBJson.h"
#import "AFNetworking.h"
#import "CardAdd.h"
//#import "ASIHTTPRequest.h"
//#import "sha.h"
//#import "rsa.h"
//#import "pem.h"
//#import "openssl/objects.h"


@interface CardAdd ()

@end

@implementation CardAdd
@synthesize strCardlist,GroupCardNameCurrent,imageCardDataCl,imgCardGroupCurrent;
@synthesize txtPhone,txtName,txtAccount,txtOrganisation;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionCardAdd:(id)sender {
    CreateGroup *rootViewController = [[CreateGroup alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionBack:(id)sender {
    CreateGroup *rootViewController = [[CreateGroup alloc] init];
    InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_HVC.topViewController =  rootViewController;
    [self.navigationController
     pushViewController:obj_HVC animated:NO];
}

- (IBAction)ActionDollor:(id)sender {
}

- (IBAction)ActionPerc:(id)sender {
}
-(IBAction)hidekey:(id)sender {
    [sender resignFirstResponder];
}

-(void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
//    if (textField == txtEmailid) {
//        cursorPass = true;
//        cursorPhone = false;
//    } else if (textField == txtPasswordLogin) {
//        cursorPhone = true;
//        cursorPass = false;
//    }
//    [self.keyboardControls setActiveField:textField];
//    [self animateTextField:txtPasswordLogin up:YES];
//    [self animateTextField:txtEmailid up:YES];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
//    [self animateTextField:txtEmailid up:NO];
//    [self animateTextField:txtPasswordLogin up:NO];
}

- (IBAction)ActionAddCard:(id)sender {

    if( [txtName.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Your Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [txtName setTextColor:[UIColor blackColor]];
    } else if( [txtOrganisation.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Your Organization" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [txtOrganisation setTextColor:[UIColor blackColor]];
    } else if(![self check_Digit_Validation1]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Your Account No" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [txtAccount setTextColor:[UIColor blackColor]];
        return;
    } else if(![self check_Digit_Validation]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Please Enter valid Mobile Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        [txtPhone setTextColor:[UIColor blackColor]];
        return;
    } else {
        
        
        
        
        NSUserDefaults *VIP = [NSUserDefaults standardUserDefaults];
        NSString * usserId = [VIP objectForKey:@"userid"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *str = @"SearchRequest​.AuditInfo​.Organization";
        NSString *str1 = @"SearchRequest​.AuditInfo​.UserId";
        NSString *str2 = @"SearchRequest​.AuditInfo​.UserName";
        NSString *str3 = @"SearchRequest​.AuditInfo​.Phone";
        NSString *str4 = @"SearchRequest​.PaymentAppInstanceId";
        NSString *str5 = @"SearchRequest​.AccountPAN";
        NSString *str6 = @"SearchRequest​.TokenUniqueReference";
        NSString *str7 = @"SearchRequest.CommentId​";
        NSString *str8 = @"SearchRequest​.ExcludeDeletedIndicator";
        NSString *str9 = @"SearchRequest.AuditInfo";

        NSString* zarb = @"\u200B";
        NSString* resu = [str stringByReplacingOccurrencesOfString:zarb withString:@""];
        NSString* resu1 = [str1 stringByReplacingOccurrencesOfString:zarb withString:@""];
        NSString* resu2 = [str2 stringByReplacingOccurrencesOfString:zarb withString:@""];
        
         NSString* resu3 = [str3 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu4 = [str4 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu5 = [str5 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu6 = [str6 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu7 = [str7 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu8 = [str8 stringByReplacingOccurrencesOfString:zarb withString:@""];
         NSString* resu9 = [str9 stringByReplacingOccurrencesOfString:zarb withString:@""];
        
        FIRAuth *firebaseAuth = [FIRAuth auth];
        NSError *signOutError;
        BOOL status = [firebaseAuth signOut:&signOutError];
        if (!status) {
            NSLog(@"Error signing out: %@", signOutError);
            return;
        }
        
        NSUInteger time = [[NSDate date] timeIntervalSince1970];
        NSString *timestamp = [NSString stringWithFormat: @"%lu", (unsigned long)time] ;
        NSString *urlString = @"https://sandbox.api.mastercard.com/offers/v1/offer";
        NSString *nonce = @"1234567890";
        NSString *consumerKey = @"AajmNcCn9oINP3qTATeAvS5relCzeex09tuqe8RT6e2690d9";
        
        NSURL *url = [NSURL URLWithString: urlString];
        // ASIHTTPRequest *request = [[ASIHTTPRequest requestWithURL: url] retain];
        
        NSString *header = [NSString stringWithFormat:
                            @"oauth_consumer_key=\"%@\",oauth_nonce=\"%@\",oauth_signature_method=\"RSA-SHA1\",oauth_timestamp=\"%@\",oauth_version=\"1.0\"",
                            consumerKey, nonce, timestamp];
        
        NSString *signatureString = [NSString stringWithFormat: @"GET&%@%%26%@",
                                     [self urlEncodeValue: urlString],
                                     [self urlEncodeValue: [header stringByReplacingOccurrencesOfString: @"," withString: @"&"]]];
        
        NSString *finalAuthHeader = [NSString stringWithFormat: @"%@,oauth_signature=\"%@\"", header, [self sha1RsaText: signatureString]];
        
        NSLog(@"\n\nRSA Encryption:\n\n%@", [self sha1RsaText: signatureString]);

    
        
      //  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",Base_url]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[request setValue:finalAuthHeader forHTTPHeaderField:@"Bypass"];
        [request setValue:finalAuthHeader forHTTPHeaderField:@"Authorization"];

        NSString *boundary = @"0b79bab50daca910b000d4f1a2b675d604257e42";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
       // [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        // post body
        NSMutableData *body = [NSMutableData data];
        NSString * Base_url = [NSString stringWithFormat:@"%@",@"https://sandbox.api.mastercard.com/mdes/csapi/v2/search%26oauth_consumer_key%3DAajmNcCn9oINP3qTATeAvS5relCzeex09tuqe8RT6e2690d9%26oauth_nonce%3D25400540855611%26oauth_timestamp%3D1286917726%26oauth_version%3D1.0%26oauth_body_hash%3D8CDsKsBpvFyMVMIdkZHi7ADckFA%3D%26oauth_signature_method%3DRSA-SHA1%26oauth_signature%3DJ20bH3rKwCDOsj6Rn4Q8XhYrFgNVfInpLm3zSQFM7awCn%2B%2BDIuu4TBRC3%2F1eTGqLPgWwKDNbNUAQ0ZTLuRTsliQNVTRyXAn6N6w2Vmv%2BC3xQR9Clvpjyzb0FKmwXOQrqMaX7QxP4hywoZG6idZsVCcyrEGffVm39jJ1%2B9AK59s8%3D"] ;
        
        
        [dict setValue:txtOrganisation.text forKey:resu];
        [dict setValue:@"5598765432109876" forKey:@"SearchRequest.Token"];
        [dict setValue:@"A1435477" forKey:resu1];
        [dict setValue:txtName.text forKey:resu2];
        [dict setValue:txtPhone.text forKey:resu3];
        [dict setValue:@"5412345678901234" forKey:resu5];
        [dict setValue:@"true" forKey:resu8];
   
          for (NSString *param in dict) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [dict objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }

        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        [request setURL:url];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"requestttt= imagepath==%@",returnString);
        if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)) {
            if ([returnString rangeOfString:@"Video uploaded successfully"].location != NSNotFound) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Video uploaded successfully" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            } else {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Video uploading fail" message:@"Please Try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        } else {
            if ([returnString containsString:@"Video uploaded successfully"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Video uploaded successfully" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
                [alert show];
            } else {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Video uploading fail" message:@"Please Try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        }

    }
 }

-(BOOL)check_Digit_Validation {
    
    BOOL isValidate = '\0';
    
    /*  limit to only numeric characters  */
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    for (int i = 0; i < [txtPhone.text length]; i++) {
        
        unichar c = [txtPhone.text characterAtIndex:i];
        
        if ([myCharSet characterIsMember:c]) {
            isValidate = YES;
        } else {
            isValidate = NO;
        }
    }
    
    return isValidate;
    
}

-(BOOL)check_Digit_Validation1 {
    
    BOOL isValidate = '\0';
    
    /*  limit to only numeric characters  */
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    for (int i = 0; i < [txtAccount.text length]; i++) {
        
        unichar c = [txtAccount.text characterAtIndex:i];
        
        if ([myCharSet characterIsMember:c]) {isValidate = YES;
        }else{ isValidate = NO;}
    }
    
    return isValidate;
    
}



- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8));
    return result ;
}


-(NSString *)sha1RsaText: (NSString *)text
{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"keyalias_sandbox" ofType: @"p12"];
    FILE *secretFile = fopen([path cStringUsingEncoding: NSUnicodeStringEncoding], "r");
    NSData *clearTextData = [text dataUsingEncoding: NSUTF8StringEncoding];
    
    unsigned char encryptedData[40];
   // RSA *rsa = PEM_read_RSAPrivateKey(secretFile, &rsa, NULL, NULL);
    
    unsigned int encryptionLength = 40;
   // RSA_size(rsa);
    
  //  RSA_size(NID_sha1, [clearTextData bytes], [clearTextData length], encryptedData, &encryptionLength, rsa);
    
    NSMutableString* stringResult = [NSMutableString stringWithCapacity: 40];
    for(int i = 0; i < 20; i++)
        [stringResult appendFormat:@"%02x", encryptedData[i]];
    
    NSString *base64EncodedResult = [NSString stringWithFormat:@"%@",stringResult];// [ASIHTTPRequest base64forData: [stringResult dataUsingEncoding: NSUTF8StringEncoding]];
    
    return base64EncodedResult ;
}
/*
+(void)requestWithOAuth {
    NSUInteger time = [[NSDate date] timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat: @"%lu", (unsigned long)time] ;
    NSString *urlString = @"https://sandbox.api.mastercard.com/offers/v1/offer";
    NSString *nonce = @"1234567890";
    NSString *consumerKey = @"AajmNcCn9oINP3qTATeAvS5relCzeex09tuqe8RT6e2690d9";
    
    NSURL *url = [NSURL URLWithString: urlString];
   // ASIHTTPRequest *request = [[ASIHTTPRequest requestWithURL: url] retain];
    
    NSString *header = [NSString stringWithFormat:
                        @"oauth_consumer_key=\"%@\",oauth_nonce=\"%@\",oauth_signature_method=\"RSA-SHA1\",oauth_timestamp=\"%@\",oauth_version=\"1.0\"",
                        consumerKey, nonce, timestamp];
    
    NSString *signatureString = [NSString stringWithFormat: @"GET&%@%%26%@",
                                 [self urlEncodeValue: urlString],
                                 [self urlEncodeValue: [header stringByReplacingOccurrencesOfString: @"," withString: @"&"]]];
    
    NSString *finalAuthHeader = [NSString stringWithFormat: @"OAuth %@,oauth_signature=\"%@\"", header, [self sha1RsaText: signatureString]];
    
    NSLog(@"\n\nRSA Encryption:\n\n%@", [self sha1RsaText: signatureString]);
    
 /*   [request addRequestHeader: @"Authorization" value: finalAuthHeader];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(response);
    }
 
 
}*/

 /*   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *token ; //GET THE TOKEN FROM THE KEYCHAIN
    
    NSString *authValue = @"5c2fccfd81d7a0d1a3b386de07f1f7b12e3a1ef268cdaa2c7ab7641cd2cadc0a";//[NSString stringWithFormat:@"Token %@",token];
    
    //Configure your session with common header fields like authorization etc
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"OAuth.Authorization": authValue};
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSString *url;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:Base_url]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200){
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
                
                //Process the data
            } else {
                [[[UIAlertView alloc] initWithTitle:nil message:@"TimeOut Transaction!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
        }
        
    }];
    [task resume];


}
*/

@end
