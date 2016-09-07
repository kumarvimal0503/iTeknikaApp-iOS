//
//  LoginVC.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "LoginVC.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"

#define SIGNUPSEGUE @"SignUpSegue"
#define FORGOTPASSWORDSEGUE @"forgotSegue"
#define LOGINSEGUE @"welcomeloginSegue"
@interface LoginVC ()

@end

@implementation LoginVC
@synthesize emailTextField;
@synthesize passWordTextField;
@synthesize loginButton;
@synthesize createNewAccountButton;


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance;




- (void)viewDidLoad {
    
    [self setViewLookAndFeel];
     [self setupAlerts];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewLookAndFeel{
    UIColor *color = [UIColor whiteColor];
    self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName: color}];
    self.passWordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self setTextFieldInsets:self.emailTextField];
    [self setTextFieldInsets:self.passWordTextField];
    //For button border
    [global setButtonBorder:self.loginButton];
    [global setButtonBorder:self.createNewAccountButton];
    
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

// Setting the textfield looks and keyboard type
-(void)setTextFieldInsets:(UITextField*)textfield{
    
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 26)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
    textfield.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    textfield.layer.borderWidth= 0.3f;
    textfield.layer.shadowColor =[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
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

// Methods for setting error message.
-(void)setupAlerts{
    
    [self.emailTextField addRegx:REGEX_EMAIL withMsg:@"Please enter valid Email Id."];
    [self.passWordTextField addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Please enter password between 6-20 characters."];
    self.emailTextField.isMandatory=YES;
    self.passWordTextField.isMandatory=YES;
}

- (IBAction)loginButtonAction:(id)sender
{
//    [self performSegueWithIdentifier:LOGINSEGUE sender:nil];
    [SVProgressHUD showWithStatus:PLEASEWAIT maskType:SVProgressHUDMaskTypeBlack];
    
    if([global isConnected]){
        
        if ( [self IsEmailValid:emailTextField.text]){
            
            if ([emailTextField.text isEqualToString:@"diwakar.g88@gmail.com"] && [passWordTextField.text isEqualToString:@"123456"])
            {
                [SVProgressHUD dismiss];
                [self performSegueWithIdentifier:LOGINSEGUE sender:nil];
            }
            else
            {
                [SVProgressHUD dismiss];
                [global showAllertMsg:ALERTTITLE Message:@"Enter Valid Email Id"];
            }
        }
        else
        {
             [SVProgressHUD dismiss];
            [global showAllertMsg:ALERTTITLE Message:@"Enter Valid Email Id"];
        }
    }
    else
    {
        [SVProgressHUD dismiss];
  
    }
}

- (IBAction)forgotPasswordButtonAction:(id)sender
{
         [self performSegueWithIdentifier:FORGOTPASSWORDSEGUE sender:nil];
}

- (IBAction)createNewAccountButtonAction:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self performSegueWithIdentifier:SIGNUPSEGUE sender:nil];
    
    //    [self performSegueWithIdentifier:SIGNUPSEGUE sender:nil];
}

#pragma touchesBegan delegate method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    
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
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
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
