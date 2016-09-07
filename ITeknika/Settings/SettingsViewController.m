//
//  SettingsViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"
//Constant For Segue
#define FEEDBACKSEGUE @"feedbackSegue"
#define ABOUTUSSEGUE @"aboutUsSegue"
@interface SettingsViewController ()
{

    NSString *smsalert,*emailalert;
}
@end

@implementation SettingsViewController

// view did load method
- (void)viewDidLoad {
    [self initialize];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// view will appear method
-(void)viewWillAppear:(BOOL)animated{
    
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
   
        [self.emailAlertSwitch setOn:YES];
        emailalert=@"1";
  
        [self.emailAlertSwitch setOn:NO];
        emailalert=@"0";
 
        [self.smsAlertSwitch setOn:YES];
        smsalert=@"1";
  
        [self.smsAlertSwitch setOn:NO];
        smsalert=@"0";
    [super viewWillAppear:YES];
}

//Code for Menu Slide bar Show on swipe gesture
-(void)initialize{
    SWRevealViewController *sw=self.revealViewController;
    sw.rearViewRevealWidth=self.view.frame.size.width-60.0f;
    self.navigationItem.leftBarButtonItem.target=self.revealViewController;
    self.navigationItem.leftBarButtonItem.action=@selector(revealToggle:);
    [self.navigationController.topViewController.navigationItem setHidesBackButton:NO];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//shareFeedbackAction Buttons
- (IBAction)shareFeedbackAction:(id)sender {
    [self performSegueWithIdentifier:FEEDBACKSEGUE sender:nil];
}
//aboutUsButton method
- (IBAction)aboutUsButton:(id)sender {
    [self performSegueWithIdentifier:ABOUTUSSEGUE sender:nil];
}
//smsAlertAction method
- (IBAction)smsAlertAction:(id)sender {
    smsalert=  [sender isOn] ? @"1" : @"0";
    [self sendSmsAlert:[self getSmsAlert:USERID SmsAlert:smsalert]];
}
//getSmsAlert Method to create the json of the record.
-(NSDictionary*)getSmsAlert:(NSString*)user_id SmsAlert:(NSString *)sms_alert {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:user_id forKey:USER_USER_ID];
    [dictionary setObject:sms_alert forKey:USER_SMSALERT];
    return dictionary;
}


//send request nad handling the response from sendSmsAlert.
-(void)sendSmsAlert:(NSDictionary*)sendSmsDetail{
    //Post Method
    NSError *error;
    if([global isConnected]){
        NSString *strurl=[NSString stringWithFormat:@"%@sms_alert_activation/",ec2maschineIP];
        NSData *data=[NSJSONSerialization dataWithJSONObject:sendSmsDetail options:NSJSONWritingPrettyPrinted error:&error];
        NSString *strpostlength=[NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
        NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
        [urlrequest setURL:[NSURL URLWithString:strurl]];
        [urlrequest setHTTPMethod:@"POST"];
        [urlrequest setValue:strpostlength forHTTPHeaderField:@"Content-Length"];
        [urlrequest setHTTPBody:data];
        
        [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             NSError *error1;
             if(data !=nil){
                 NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
                 if(!error1){
                     [self performSelectorOnMainThread:@selector(emailSmsAlertMethod:) withObject:[NSArray arrayWithObjects:res,sendSmsDetail, nil] waitUntilDone:NO];
                 }
                 else{
                     [SVProgressHUD showInfoWithStatus:error1.description];
                 }
             }
             else{
                 [global showAllertMsg:ALERTTITLE Message:@"Server Not Responding"];
             }
             
         }];
    }
    
}
// Common method to handle the response from the server
-(void)emailSmsAlertMethod:(NSArray*)resp{
    NSDictionary *response=[resp objectAtIndex:0];
    
    if([[response objectForKey:SUCCESS] isEqual:@"true"]){
//        usr.email_alert=emailalert;
//        usr.sms_alert=smsalert;
    }else{
        //[SVProgressHUD showErrorWithStatus:@"Error Occurred!"];
    }
}

//emailAlertAction method
- (IBAction)emailAlertAction:(id)sender {
    emailalert=  [sender isOn] ? @"1" : @"0";
    [self sendEmailAlert:[self getEmailAlert:USERID EmailAlert:emailalert]];
}
//getEmailAlert Method to create the json of the record.
-(NSDictionary*)getEmailAlert:(NSString*)user_id EmailAlert:(NSString *)email_alert {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:user_id forKey:USER_USER_ID];
    [dictionary setObject:email_alert forKey:USER_EMAILALERT];
    return dictionary;
}


//send request nad handling the response from sendEmailAlert.
-(void)sendEmailAlert:(NSDictionary*)sendEmailDetail{
    //Post Method
    NSError *error;
    if([global isConnected]){
        NSString *strurl=[NSString stringWithFormat:@"%@email_alert_activation/",ec2maschineIP];
        NSData *data=[NSJSONSerialization dataWithJSONObject:sendEmailDetail options:NSJSONWritingPrettyPrinted error:&error];
        NSString *strpostlength=[NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
        NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
        [urlrequest setURL:[NSURL URLWithString:strurl]];
        [urlrequest setHTTPMethod:@"POST"];
        [urlrequest setValue:strpostlength forHTTPHeaderField:@"Content-Length"];
        [urlrequest setHTTPBody:data];
        
        [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             NSError *error1;
             if(data !=nil){
                 NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
                 if(!error1){
                     [self performSelectorOnMainThread:@selector(emailSmsAlertMethod:) withObject:[NSArray arrayWithObjects:res,sendEmailDetail, nil] waitUntilDone:NO];
                 }
                 else{
                     [SVProgressHUD showInfoWithStatus:error1.description];
                 }
             }
             else{
                 [global showAllertMsg:ALERTTITLE Message:@"Server Not Responding"];
             }
             
         }];
    }
    
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

@end
