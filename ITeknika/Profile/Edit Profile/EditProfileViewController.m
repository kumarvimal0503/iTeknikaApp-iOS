//
//  EditProfileViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//


#import "EditProfileViewController.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "UIImageView+Network.h"
#import "UIImageView+WebCache.h"
#import "BackgroundLayer.h"

@interface EditProfileViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL camera;
}
@end

@implementation EditProfileViewController

@synthesize firstNameTextfield;
@synthesize lastNameTextfield;
@synthesize phoneTextfield;
@synthesize emailTextfield;


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
CGFloat animatedDistance4;
//view did appear method
- (void)viewDidLoad {
    
   NSURL *imageURL=[[NSURL alloc] initWithString:@"https://qb-mikemessenger-s3.s3.amazonaws.com/d6134dee8ab54c28a0cd0a2feefba85900"];
    
    [self.userPlaceholderImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:USER_PLACEHOLDER] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        DMLog(@"Image Method Success");
    }];
    
    
    
    [self setupAlerts];
    [self setViewLookAndFeel];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//view will appear method
-(void)viewWillAppear:(BOOL)animated{

    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    firstNameTextfield.text=@"Diwakar";
    lastNameTextfield.text=@"Garg";
    phoneTextfield.text=@"8055290885";
    emailTextfield.text=@"diwakar.g88@gmail.com";

    [super viewWillAppear:YES];
}
// Setting look and feel of the edit profile screen.
-(void)setViewLookAndFeel{
    
    // Navigation Bar
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];
    
    //Setting Bordermethod for the textfield and buttons.
    [self borderSetting];
    
    UIColor *color = [UIColor whiteColor];
    self.firstNameTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.lastNameTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    self.phoneTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact Number" attributes:@{NSForegroundColorAttributeName: color}];
    self.emailTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Id" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self setTextFieldInsets:self.firstNameTextfield];
    [self setTextFieldInsets:self.lastNameTextfield];
    [self setTextFieldInsets:self.phoneTextfield];
    [self setTextFieldInsets:self.emailTextfield];
    
}


//Change Picture Action Button.
- (IBAction)changePictureAction:(id)sender {

        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:KCancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:Gallery style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            // Distructive button tapped.
            [self getMediaPic];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:Camera style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            // OK button tapped.
            [self getCameraPic];
        }]];
        
        // Present action sheet.
        [self presentViewController:actionSheet animated:YES completion:nil];

}

-(void)getCameraPic{
    BOOL permission=[global CameraPermission];
    
    
    if (permission) {
        camera=true;
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_NAME message:CameraAlert preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            [self sendToSettingPage];
                                            //write command for action perform
                                        }];
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:KCancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     //write command for action perform
                                 }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
// call image picker
-(void) getMediaPic{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)sendToSettingPage
{
    BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
}
#pragma mark************************ Image Picker Delegate Method *********************
// Delegate method of picker view for image selection
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (camera == true) {
        //Save the image to lib when click from camera
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil);
        camera=false;
    }
    //Image with out compression
    self.userPlaceholderImage.image=chosenImage;
//    //Image compression
//    self.userPlaceholderImage.image=[global resizedImage:chosenImage :CGRectMake(0, 0, 300, 300)];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//Delegate method of picker view for image cancellation
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// Navigation bar save button
-(void)Save{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    if([self.emailTextfield validate] &&[self.phoneTextfield validate] &&[self.firstNameTextfield validate] &&[self.lastNameTextfield validate])
    {
        [SVProgressHUD showWithStatus:PLEASEWAIT maskType:SVProgressHUDMaskTypeBlack];
        NSString *firstName= self.firstNameTextfield.text;
        NSString *lastName= self.lastNameTextfield.text;
        NSString *email_id= self.emailTextfield.text;
        NSString *phone= self.phoneTextfield.text;
        // Image Parsing
        UIImage *img = _userPlaceholderImage.image;
        NSData *imageData = UIImagePNGRepresentation(img);
        NSString *userProfileImage = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSString *user_id=USERID;
        
        if([self IsEmailValid:email_id])
        {
            [self sendUpdateDetail:[self getUpdateDetails:user_id FirstName:firstName LastName:lastName Phone:phone   EmailId:email_id UserProfileImage:userProfileImage]];
        }
    }
}

//Get method for creating edit profile json.
-(NSDictionary*)getUpdateDetails:(NSString*)user_id FirstName:(NSString*)firstName LastName:(NSString*)lastName Phone:(NSString*)phone  EmailId:(NSString*)email_id  UserProfileImage:(NSString *)userProfileImage {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:user_id forKey:USER_USER_ID];
    [dictionary setObject:firstName forKey:USER_FIRST_NAME];
    [dictionary setObject:lastName forKey:USER_LAST_NAME];
    [dictionary setObject:phone forKey:USER_PHONE];
    [dictionary setObject:email_id forKey:USER_EMAIL_ID];
    [dictionary setObject:userProfileImage forKey:USER_PROFILE_IMAGE];
    return dictionary;
}


//send request and handling the response of update profile.
-(void)sendUpdateDetail:(NSDictionary*)updateProfileDetails{
//    //Post Method
//    NSError *error;
//    if([global isConnected]){
//        @try {
//            
//            NSString *strurl=[NSString stringWithFormat:@"%@update_consumer_profile/",ec2maschineIP];
//            NSData *data=[NSJSONSerialization dataWithJSONObject:updateProfileDetails options:NSJSONWritingPrettyPrinted error:&error];
//            NSString *strpostlength=[NSString stringWithFormat:@"%lu",(unsigned long)[data length]];
//            NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
//            [urlrequest setURL:[NSURL URLWithString:strurl]];
//            [urlrequest setHTTPMethod:@"POST"];
//            [urlrequest setValue:strpostlength forHTTPHeaderField:@"Content-Length"];
//            [urlrequest setHTTPBody:data];
//            
//            [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
//             {
//                 NSError *error1;
//                 if(data !=nil){
//                     NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
//                     if(!error1){
//                         [self performSelectorOnMainThread:@selector(updateProfile:) withObject:[NSArray arrayWithObjects:res,updateProfileDetails, nil] waitUntilDone:NO];
//                         [SVProgressHUD dismiss];
//                     }
//                     else{
//                         [SVProgressHUD showInfoWithStatus:error1.description];
//                         [SVProgressHUD dismiss];
//                         
//                     }
//                 }
//                 else{
//                     [global showAllertMsg:ALERTTITLE Message:@"Server Not Responding"];
//                     [SVProgressHUD dismiss];
//                 }
//                 
//             }];
//        }
//        @catch(NSException *e){
//        }
//    }
    
}

//Update Profile Methpod
-(void)updateProfile:(NSArray*)resp{
    NSDictionary *response=[resp objectAtIndex:0];
    if(response!=nil &&![response isKindOfClass:[NSNull class]]){
        if([response isKindOfClass:[NSDictionary class]]){
            if([[response objectForKey:SUCCESS] isEqual:@"true"]){
                @try {
                    
                    NSDictionary *user=[response objectForKey:@"user_info"];
                    NSDictionary *profile=[user objectForKey:@"basic"];
                    
                    [self setuserInfo:[profile valueForKey:USER_USER_ID] withFirstName:[profile valueForKey:USER_FIRST_NAME] withLastName:[profile valueForKey:USER_LAST_NAME] withPhone:[profile valueForKey:USER_PHONE] withEmailId:[profile valueForKey:USER_EMAIL_ID] withUserProfileImage:[profile valueForKey:USER_PROFILE_IMAGE] withSignUpVia:[profile valueForKey:USER_SIGN_UP_VIA] withSmsAlert:[profile valueForKey:USER_SMSALERT] withEmailAlert:[profile valueForKey:USER_EMAILALERT]];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [SVProgressHUD showInfoWithStatus:@"Updated Successful"];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    // optional block of clean-up code
                    // executed whether or not an exception occurred
                }
            }
            
        }
        else{
            [SVProgressHUD dismiss];
        }
    }
    else{
        [SVProgressHUD showErrorWithStatus:SERVER_ERROR];
        [SVProgressHUD dismiss];
    }
    
}

//Assigning value to user bean for profile.
-(void)setuserInfo:(NSString*)user_id withFirstName:(NSString*)first_name withLastName:(NSString*)last_name withPhone:(NSString*)phone withEmailId:(NSString*)email_id withUserProfileImage:(NSString*)user_profile_image withSignUpVia:(NSString*)sign_up_via withSmsAlert:(NSString*)sms_alert withEmailAlert:(NSString*)email_alert
{
    DMLog(@"Update Profile Call");
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
    if (textfield==phoneTextfield){
        textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
}
//Setting border of button
-(void)borderSetting
{
    _cloudButton.layer.cornerRadius=_cloudButton.frame.size.height/2;
    _cloudButton.layer.masksToBounds=YES;
    
    //UserPlaceholderImage border
    _userPlaceholderImage.layer.cornerRadius=_userPlaceholderImage.frame.size.height/2;
    _userPlaceholderImage.layer.masksToBounds=YES;
    _userPlaceholderImage.layer.borderColor=ImageBorderColor;
    _userPlaceholderImage.layer.borderWidth= 1.0f;
}
// Methods for setting error message.
-(void)setupAlerts{
    //setting up error messages
    [self.firstNameTextfield addRegx:REGEX_USERNAME withMsg:@"Please enter valid First Name"];
    [self.firstNameTextfield addRegx:REGEX_USER_NAME_LIMIT withMsg:@"Please enter valid First Name between 1-10 characters."];
    [self.lastNameTextfield addRegx:REGEX_USERNAME withMsg:@"Please enter valid Last Name"];
    [self.lastNameTextfield addRegx:REGEX_USER_NAME_LIMIT withMsg:@"Please enter valid Last Name between 1-10 characters."];
    [self.emailTextfield addRegx:REGEX_EMAIL withMsg:@"Please enter valid Email Id."];
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
//Restricting text input for Phone no.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(textField.tag == 3)
    {
        //first, check if the new string is numeric only. If not, return NO;
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([newString rangeOfCharacterFromSet:characterSet].location != NSNotFound)
        {
            return NO;
        }
    }
    return [newString doubleValue] < 10000000000;
    
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
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance4 = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance4 = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance4;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}
#pragma textFieldDidEndEditing delegate method
- (void)textFieldDidEndEditing:(UITextField *)textfield{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance4;
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
