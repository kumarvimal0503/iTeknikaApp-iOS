//
//  global.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

#define ec2maschineIP @"http://54.148.82.251/"
#define SSOUSING @"SSOUsing"
#define USERNAME @"username"
#define PASSWORD @"password"
#define LOGGEDIN @"LoggedIn"

#define iTeknika @"iTeknika"

#define PLEASEWAIT @"Please wait"
#define ERROR_MSG @"error_message"
#define SUCCESS @"success"
#define SERVER_ERROR @"Server not responding"
#define SHAREFEEDBACK @"feedback"
#define ALERTTITLE @"iTeknika"
#define DATE @"date"
#define TIME @"time"


#define ImageBorderColor [[UIColor colorWithRed:0.08 green:0.63 blue:0.85 alpha:1.0]CGColor]
//pink Color
//#define APPTHEMECOLOR [UIColor colorWithRed:1 green:0 blue:0.294 alpha:1]
//Red orange Color
//#define APPTHEMECOLOR [UIColor colorWithRed:0.78 green:0.22 blue:0.06 alpha:1.0]
//Blue color
#define APPTHEMECOLOR [UIColor colorWithRed:0.08 green:0.63 blue:0.85 alpha:1.0]
//Dark blue green
//#define APPTHEMECOLOR [UIColor colorWithRed:0.00 green:0.51 blue:0.56 alpha:1.0]

#define HIGHLIGHTEDTABCOLOR [UIColor colorWithRed:0.984 green:0 blue:0.224 alpha:0.8]
#define DEFAULTTABCOLOR [UIColor colorWithRed:0.204 green:0.204 blue:0.204 alpha:1]
#define USER_PLACEHOLDER @"profileplaceholder"

#define ChatsCellColor [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1]
#define WhiteColor        [UIColor whiteColor]
#define APP_NAME           @"iTeknika"
#define KChatVCOk           @"OK"
#define KCancel             @"Cancel"

#define USER_USER_ID @"user_id"
#define USER_FIRST_NAME @"first_name"
#define USER_LAST_NAME @"last_name"
#define USER_PHONE @"phone"
#define USER_EMAIL_ID @"email_id"
#define USER_PROFILE_IMAGE @"user_profile_image"
#define USER_SIGN_UP_VIA @"sign_up_via"
#define USER_SIGN_UP_SOURCE @"sign_up_source"
#define USER_APNSTOKEN @"apns_token"
#define USER_PROFILE_PREFIX @" "
#define USER_USERNAME @"user_name"
#define USER_PASS_WORD @"pass_word"
#define USER_CHANGE_PASSOWRD @"change_password"
#define USER_SMSALERT @"sms_alert"
#define USER_EMAILALERT @"email_alert"


#define WhatsAppInvitation  @"whatsapp://send?text=Download%20this%20app%20to%20view%20your%20job%20history%20and%20register%20for%20job."
#define ErrorTitle          @"Error"
#define KChatVCOk           @"OK"
#define ErrorAlertWhatsApp  @"Your device doesn't support Whatsapp!"
#define EmailErrorAlert     @"Your device doesn't support Mail!"
#define ErrorAlertSms       @"Your device doesn't support SMS!"
#define IviteMessage        @"Check out this app for job registration "
//*********************Log print in project**********************

#ifdef DEBUG
#define DMLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DMLog(...) do { } while (0)
#endif



extern NSString * APNSTOKEN;
extern NSString *ssousing;
extern NSString *USERID;
extern bool isAllreadyTried;
extern bool tablePopup;

@interface global : NSObject
//Post Request Method
+(NSData*)makePostRequest:(NSData*)body requestURL:(NSString*)url;
//Show alert Method
+(void)showAllertMsg:(NSString*)title Message:(NSString*)msg;
//Check for the network connection
+(BOOL)isConnected;
//show the alert for crediential
+(void)showAllertForEnterValidCredentials;
//Setting the textfield  inset value
+(void)setTextFieldInsets:(UITextField*)textfield;
//Setting button border 
+(void)setButtonBorder:(UIButton *)button;
@end
