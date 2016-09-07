//
//  ShareFeedbackViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "ShareFeedbackViewController.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"
@interface ShareFeedbackViewController ()

@end

@implementation ShareFeedbackViewController

- (void)viewDidLoad {
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    _shareFeedbackTextView.text = @"Write.......";
    _shareFeedbackTextView.textColor = [UIColor lightGrayColor];
    _shareFeedbackTextView.delegate = self;
    
    // Code for Right Bar Button Item
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//Code for Save button
-(void)send{
    // JSON Request send for change password
    if([global isConnected]){
        [_shareFeedbackTextView resignFirstResponder];
        NSString *feedback=_shareFeedbackTextView.text;
        NSString *user_id=USERID;
        [self sendFeedbackAlert:[self getFeedbackAlert:user_id Feedback:feedback]];
    }
}
#pragma alertview delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
//Share Feedback Method to create the json of the record.
-(NSDictionary*)getFeedbackAlert:(NSString*)user_id Feedback:(NSString *)feedback {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:user_id forKey:USER_USER_ID];
    [dictionary setObject:feedback forKey:SHAREFEEDBACK];
    return dictionary;
}

//send request and handling the response from share feedback .
-(void)sendFeedbackAlert:(NSDictionary*)sendFeedbackDetail{
    //Post Method
    NSError *error;
    if([global isConnected]){
        [SVProgressHUD showWithStatus:PLEASEWAIT maskType:SVProgressHUDMaskTypeBlack];
        NSString *strurl=[NSString stringWithFormat:@"%@consumer_feedback/",ec2maschineIP];
        NSData *data=[NSJSONSerialization dataWithJSONObject:sendFeedbackDetail options:NSJSONWritingPrettyPrinted error:&error];
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
                     [self performSelectorOnMainThread:@selector(feedbackResponse:) withObject:[NSArray arrayWithObjects:res,sendFeedbackDetail, nil] waitUntilDone:NO];
                     [SVProgressHUD dismiss];
                 }
                 else{
                     [SVProgressHUD showInfoWithStatus:error1.description];
                     [SVProgressHUD dismiss];
                     
                 }
             }
             else{
                 [global showAllertMsg:ALERTTITLE Message:@"Server Not Responding"];
                 [SVProgressHUD dismiss];
             }
             
         }];
    }
    
}

//Code for fetching data from the server
-(void)feedbackResponse:(NSArray *)response
{
    NSDictionary *respo=[response objectAtIndex:0];
    
    if([[respo objectForKey:SUCCESS] isEqual:@"true"]){
        [SVProgressHUD showInfoWithStatus:@"Successfull"];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Thank You for Sharing Feedback" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [SVProgressHUD showErrorWithStatus:@"Error Occurred!"];
    }
}
//this function will end editing by dissmissing keyboard if user touches outside the textfields
#pragma touchesBegan delegate method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma textViewShouldBeginEditing delegate method
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([_shareFeedbackTextView.text isEqualToString:@"Write......."]){
        _shareFeedbackTextView.text = @"";
        _shareFeedbackTextView.textColor = [UIColor blackColor];
        return YES;
    }
    else
    {
        _shareFeedbackTextView.textColor = [UIColor blackColor];
        return YES;
    }
}
#pragma textViewShouldEndEditing delegate method
- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

#pragma textViewDidChange delegate method
-(void) textViewDidChange:(UITextView *)textView
{
    if(_shareFeedbackTextView.text.length == 0){
        _shareFeedbackTextView.textColor = [UIColor lightGrayColor];
        _shareFeedbackTextView.text = @"Write.......";
        [_shareFeedbackTextView resignFirstResponder];
    }
}
#pragma textViewDidEndEditing delegate method
- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    if (![_shareFeedbackTextView hasText]) {
        _shareFeedbackTextView.textColor = [UIColor lightGrayColor];
        _shareFeedbackTextView.text = @"Write.......";
    }
}
#pragma textFieldDidEndEditing delegate method
- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    
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
