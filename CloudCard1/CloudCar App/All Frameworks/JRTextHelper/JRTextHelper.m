//
//  JRTextHelper.m
//  TriniPossed
//
//  Created by Manjit Bhuriya on 20/12/13.
//  Copyright (c) 2013 Manjit Bhuriya. All rights reserved.
//

#import "JRTextHelper.h"

@implementation JRTextHelper

+ (BOOL)textIsValidEmailFormat:(NSString *)text {
    
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

+ (BOOL)textIsValidPasswordFormat:(NSString *)text {
    
    NSString *stricterFilterString = @"(?!^[0-9]*$)(?!^[a-zA-Z]*$)^([a-zA-Z0-9]{8,10})$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    
    if (text.length < 6) {
        return NO;
    }
    else {
        return [passwordTest evaluateWithObject:text];
    }
}

@end
