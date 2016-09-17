//
//  ProfileViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//


#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "global.h"
#import "BackgroundLayer.h"
@interface ProfileViewController ()
{

}
@end

@implementation ProfileViewController

@synthesize firstNameTextfield;
@synthesize lastNameTextfield;
@synthesize phoneTextfield;
@synthesize emailTextfield;
@synthesize changePasswordButton;
@synthesize userPlaceholderImage;
@synthesize profileSnapShotButton;
// View did load method
- (void)viewDidLoad {
    
    [self setupAlerts];
    [self setViewLookAndFeel];
    [self initialize];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// View will Appear
-(void)viewWillAppear:(BOOL)animated{

    
    // Add the button for profile snapshot.(editable).
    
    
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    firstNameTextfield.text=@"Diwakar";
    lastNameTextfield.text=@"Garg";
    phoneTextfield.text=@"8055290885";
    emailTextfield.text=@"diwakar.g88@gmail.com";
    changePasswordButton.enabled=true;
    
   NSURL *imageURL=[[NSURL alloc] initWithString:@"https://qb-mikemessenger-s3.s3.amazonaws.com/d6134dee8ab54c28a0cd0a2feefba85900"];

    [self.userPlaceholderImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:USER_PLACEHOLDER] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                DMLog(@"Image Method Success");
           }];

    [super viewWillAppear:YES];
}
//Action for Change Password
- (IBAction)changePasswordAction:(id)sender {
    [self performSegueWithIdentifier:CHANGEPASSWORDSEGUE sender:nil];
}
// Navigation bar edit button
-(void)editprofile
{
    [self performSegueWithIdentifier:EDITPROFILESEGUE sender:nil];
}

- (IBAction)profileSnapShotButtonAction:(id)sender
{
     [self performSegueWithIdentifier:PROFILESNAPSHOTSEGUE sender:nil];
}



//Code for Menu Slide bar Show on swipe gesture
-(void)initialize{
    //adding swipe gesture
    SWRevealViewController *sw=self.revealViewController;
    sw.rearViewRevealWidth=self.view.frame.size.width-60.0f;
    self.navigationItem.leftBarButtonItem.target=self.revealViewController;
    self.navigationItem.leftBarButtonItem.action=@selector(revealToggle:);
    [self.navigationController.topViewController.navigationItem setHidesBackButton:NO];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// Setting look and feel of the profile screen.
-(void)setViewLookAndFeel{
    // Navigation Bar
    //Code for rightBarButton frame set
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
    edit.bounds = CGRectMake( 10, 0,20, 20);
    [edit addTarget:self action:@selector(editprofile) forControlEvents:UIControlEventTouchUpInside];
    [edit setImage:[UIImage imageNamed:@"edit-w"] forState:UIControlStateNormal];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:edit];
    self.navigationItem.rightBarButtonItem = editButton;
    
    //Setting Bordermethod for the textfield and buttons.
    [self borderSetting];
    UIColor *color = [UIColor whiteColor];
    self.firstNameTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.lastNameTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.phoneTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.emailTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email ID" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self setTextFieldInsets:self.firstNameTextfield];
    [self setTextFieldInsets:self.lastNameTextfield];
    [self setTextFieldInsets:self.phoneTextfield];
    [self setTextFieldInsets:self.emailTextfield];
}
//Setting textfield design
-(void)setTextFieldInsets:(UITextField*)textfield{
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 26)];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    textfield.layer.borderWidth= 0.3f;
    textfield.layer.shadowColor =[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    if (textfield==lastNameTextfield) {
        textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 26)];
        textfield.leftViewMode = UITextFieldViewModeAlways;
    }
}
//setting border color of image and button
-(void)borderSetting
{
    //For button border
    changePasswordButton.layer.borderColor=[[UIColor whiteColor]CGColor];
    changePasswordButton.layer.borderWidth= 0.3f;
    
    profileSnapShotButton.layer.borderColor=[[UIColor whiteColor]CGColor];
    profileSnapShotButton.layer.borderWidth= 0.3f;
    
    //UserPlaceholderImage border
    userPlaceholderImage.layer.cornerRadius=userPlaceholderImage.frame.size.height/2;
    userPlaceholderImage.layer.masksToBounds=YES;
    userPlaceholderImage.layer.borderColor=ImageBorderColor;
    userPlaceholderImage.layer.borderWidth= 1.0f;
}
// Methods for setting error message.
-(void)setupAlerts{
    //setting up error messages
    [self.firstNameTextfield addRegx:REGEX_USERNAME withMsg:@"Please enter valid First Name"];
    [self.firstNameTextfield addRegx:REGEX_USER_NAME_LIMIT withMsg:@"Please enter valid First Name between 3-10 characters."];
    [self.lastNameTextfield addRegx:REGEX_USERNAME withMsg:@"Please enter valid Last Name"];
    [self.lastNameTextfield addRegx:REGEX_USER_NAME_LIMIT withMsg:@"Please enter valid Last Name between 3-10 characters."];
    [self.emailTextfield addRegx:REGEX_EMAIL withMsg:@"Please enter valid email id."];
    [self.phoneTextfield addRegx:REGEX_PHONE_DEFAULT withMsg:@"Please enter valid Phone Number"];
    self.firstNameTextfield.isMandatory=YES;
    self.lastNameTextfield.isMandatory=YES;
    self.emailTextfield.isMandatory=YES;
    self.phoneTextfield.isMandatory=YES;
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
