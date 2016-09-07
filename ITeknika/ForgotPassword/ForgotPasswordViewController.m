//
//  ForgotPasswordViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"
@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance3;
//view did load method
- (void)viewDidLoad {
    [self setupAlerts];
    [self setViewLookAndFeel];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// Setting look and feel of the Signup screen.
-(void)setViewLookAndFeel{
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    // Navigation bar code
    //Left Bar Button Item
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.bounds = CGRectMake( 10, 0, 20, 20);
    [back addTarget:self action:@selector(backmenu) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"backarrow-w"] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIColor *color = [UIColor whiteColor];
    self.emailTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Registered Email Id" attributes:@{NSForegroundColorAttributeName: color}];
    [self setTextFieldInsets:self.emailTextfield];
}
//Code for Save button of the navigation bar
- (IBAction)sendPasswordAction:(id)sender {
    if([self.emailTextfield hasText])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Are you sure you have entered the correct Email Id ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Please enter registered Email Id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
        [alert show];
    }
    
}
//Code for alert View delegate method
#pragma alerview delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
    }else{
        CATransition* transition = [CATransition animation];
        transition.duration = 0.35;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFade;
        [self.view.window.layer addAnimation:transition forKey:nil];
        
        if([self.emailTextfield hasText])
        {
            NSString *forgotPassword= self.emailTextfield.text;
            if([global isConnected]){
                [self sendForgotPassword:[self getForgotPassword:forgotPassword]];
            }
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Please enter valid id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}
//Method to create the json of the record.
-(NSDictionary*)getForgotPassword:(NSString*)forgotPassword {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:forgotPassword forKey:USER_EMAIL_ID];
    return dictionary;
}
//Sending and handling of the request and response.
-(void)sendForgotPassword:(NSDictionary*)sendPasswordLink{
    //Post Method
    NSError *error;
    if([global isConnected]){
        [SVProgressHUD showWithStatus:PLEASEWAIT maskType:SVProgressHUDMaskTypeBlack];
        NSString *strurl=[NSString stringWithFormat:@"%@forgot_password/",ec2maschineIP];
        NSData *data=[NSJSONSerialization dataWithJSONObject:sendPasswordLink options:NSJSONWritingPrettyPrinted error:&error];
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
                     [self performSelectorOnMainThread:@selector(forgotPassword:) withObject:[NSArray arrayWithObjects:res,sendPasswordLink, nil] waitUntilDone:NO];
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

//Forgotpassword method for handling the response from the server
-(void)forgotPassword:(NSArray*)resp{
    NSDictionary *response=[resp objectAtIndex:0];
    [SVProgressHUD dismiss];
    if([[response objectForKey:SUCCESS] isEqual:@"true"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Password is sent on your registered id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showInfoWithStatus:@"Successfully send email"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"Email Id is not registered!"];
    }
}

//Code For lefbar button
-(void)backmenu{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
// Setting the textfield looks and keyboard type
-(void)setTextFieldInsets:(UITextField*)textfield{
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 26)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.font=[UIFont fontWithName:@"MyriadPro-Light" size:18];
    textfield.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    textfield.layer.borderWidth= 0.3f;
    textfield.layer.shadowColor =[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
}
// Methods for setting alert message.
-(void)setupAlerts{
    //setting up error messages
    [self.emailTextfield addRegx:REGEX_EMAIL withMsg:@"Please enter valid email id."];
    self.emailTextfield.isMandatory=YES;
}
// Method for validating the email id
-(BOOL)IsEmailValid:(NSString *)checkString
{
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
    
}
// Textfield Delegate method for returning the keyboard
#pragma textFieldShouldReturn delegate method
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:textField.tag + 1];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

//Delegate method of textfield when editing is start
#pragma textFieldDidBeginEditing delegate method
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance3 = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance3 = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance3;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
//Delegate method of textfield when editing is end
#pragma textFieldDidEndEditing delegate method
- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance3;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

//this function will end editing by dissmissing keyboard if user touches outside the textfields
#pragma touchesBegan delegate method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
