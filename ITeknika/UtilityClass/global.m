//
//  global.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "global.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

NSString *ssousing;
NSString *USERID;

bool tablePopup=NO;

@implementation global
//Check for the network connection
+(BOOL)isConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if(networkStatus == NotReachable)
    {
        [self showAllertMsg:ALERTTITLE Message:@"You are not connected to internet"];
    }
    return networkStatus != NotReachable;
}

//Post Request Method
+(NSData*)makePostRequest:(NSData*)body requestURL:(NSString*)url {
    NSError *error;
    NSData *responseData;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ec2maschineIP,url]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    
    NSHTTPURLResponse* urlResponse = nil;
    error = [[NSError alloc] init];
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    return responseData;
}

//Show alert Method
+(void)showAllertMsg:(NSString*)title Message:(NSString*)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//show the alert for crediential
+(void)showAllertForEnterValidCredentials{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERTTITLE message:@"Please enter Email Id and Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//Setting the textfield  inset value
+(void)setTextFieldInsets:(UITextField*)textfield{
    
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
}

//Setting button border
+(void)setButtonBorder:(UIButton *)button{
    
    button.layer.borderColor=[[UIColor whiteColor]CGColor];
    button.layer.borderWidth= 0.3f;
}

@end
