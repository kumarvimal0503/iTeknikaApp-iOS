//
//  ChangePasswordViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//


#import "ChangePasswordViewController.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"
@interface ChangePasswordViewController ()
{

}
@end

@implementation ChangePasswordViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;

- (void)viewDidLoad {
    [self setupAlerts];
    [self setViewLookAndFeel];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// Setting look and feel of the change password screen.
-(void)setViewLookAndFeel{
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    // Navigation Bar
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];
    
    UIColor *color = [UIColor whiteColor];
    self.oldPasswordtextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Old Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.passwordtextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.confirmPasswordtextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    [self setTextFieldInsets:self.oldPasswordtextfield];
    [self setTextFieldInsets:self.passwordtextfield];
    [self setTextFieldInsets:self.confirmPasswordtextfield];
}
// Navigation bar save button
-(void)Save{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    if([self.oldPasswordtextfield validate] &&[self.passwordtextfield validate] &&[self.confirmPasswordtextfield validate])
    {
        NSString *old_password= self.oldPasswordtextfield.text;
        NSString *new_password= self.confirmPasswordtextfield.text;
        NSString *user_id=@"diwakar.g88@gmail.com";
        [self sendChangePassword:[self getChangePassword:user_id OldPassword:old_password NewPassword:new_password]];
    }
}

//Get method for creating change password json.
-(NSDictionary*)getChangePassword:(NSString*)user_id OldPassword:(NSString*)old_password NewPassword:(NSString*)new_password {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:user_id forKey:USER_EMAIL_ID];
    [dictionary setObject:old_password forKey:USER_PASS_WORD];
    [dictionary setObject:new_password forKey:USER_CHANGE_PASSOWRD];
    return dictionary;
}
//send request and handling the response of change password.
-(void)sendChangePassword:(NSDictionary*)updateChangePassword{
    //Post Method
    NSError *error;
    if([global isConnected]){
        [SVProgressHUD showWithStatus:PLEASEWAIT maskType:SVProgressHUDMaskTypeBlack];
        NSString *strurl=[NSString stringWithFormat:@"%@change_password/",ec2maschineIP];
        NSData *data=[NSJSONSerialization dataWithJSONObject:updateChangePassword options:NSJSONWritingPrettyPrinted error:&error];
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
                     [self performSelectorOnMainThread:@selector(changePassword:) withObject:[NSArray arrayWithObjects:res,updateChangePassword, nil] waitUntilDone:NO];
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
//Change Password Action
-(void)changePassword:(NSArray*)resp{
    NSDictionary *response=[resp objectAtIndex:0];
    
    [SVProgressHUD dismiss];
    if([[response objectForKey:SUCCESS] isEqual:@"true"]){
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [SVProgressHUD showInfoWithStatus:@"Change Successful"];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:_passwordtextfield.text  forKey:PASSWORD];
        [defaults synchronize];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"Error Occurred!"];
    }
}
// Setting the textfield looks and keyboard type
-(void)setTextFieldInsets:(UITextField*)textfield{
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    textfield.layer.borderWidth= 0.3f;
    textfield.layer.shadowColor =[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
}
// Methods for setting error message.
-(void)setupAlerts{
    //setting up error messages
    [self.oldPasswordtextfield addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Please enter password between 6-20 characters."];
    [self.oldPasswordtextfield addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    [self.passwordtextfield addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Please enter password between 6-20 characters."];
    [self.passwordtextfield addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    [self.confirmPasswordtextfield addConfirmValidationTo:_passwordtextfield withMsg:@"Confirm password didn't match."];
    
    self.oldPasswordtextfield.isMandatory=YES;
    self.passwordtextfield.isMandatory=YES;
    self.confirmPasswordtextfield.isMandatory=YES;
    
}
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
    
    CGRect viewFrame = self.view.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
#pragma textFieldDidEndEditing delegate method
- (void)textFieldDidEndEditing:(UITextField *)textfield{
    
    CGRect viewFrame = self.view.frame;
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
