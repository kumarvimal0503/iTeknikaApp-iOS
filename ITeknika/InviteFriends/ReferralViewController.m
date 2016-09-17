//
//  ReferralViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "ReferralViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "ReferralTableViewCell.h"
#import <Social/Social.h>
#import "global.h"
#import "UIImageView+Network.h"
#import "UIImageView+WebCache.h"
#import "BackgroundLayer.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ReferralViewController ()

@property(nonatomic,strong) NSArray *options,*icons;

@end

@implementation ReferralViewController
{

   // NSString *sharingURL;
    NSString *sharingMsg;
}

// view did load method
- (void)viewDidLoad {
    
    sharingMsg=IviteMessage;
   // sharingURL=@"www.deal-monk.com";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    _options = [NSArray arrayWithObjects:@"Refer By SMS",@"Refer By Email", @"Twitter",@"WhatsApp",nil];
    
    _icons= [NSArray arrayWithObjects:@"sms-g",@"email-g",@"twitter-g",@"WhatsApp-g",nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// view did appear method
-(void)viewDidAppear:(BOOL)animated{
    
    _userNameLabel.text=@"Diwakar Garg";
    
   NSURL *imageURL=[[NSURL alloc] initWithString:@"https://qb-mikemessenger-s3.s3.amazonaws.com/d6134dee8ab54c28a0cd0a2feefba85900"];
    
    [self.userPlaceholderImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"profileplaceholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        DMLog(@"Image Method Success");
    }];
    

    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [super viewDidAppear:YES];
}
// check the connectivity of the internet
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
// view did disappear method
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
}
// view will appear method
-(void)viewWillAppear:(BOOL)animated{
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    [self initialize];
    [self borderSetting];
    
    [super viewWillAppear:YES];
    
}
// Border setting method
-(void)borderSetting
{
    //hiding extra rows in table view
    self.referralTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //Table Border
    _referralTable.layer.borderColor=[[UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1] CGColor];
    _referralTable.layer.borderWidth=0.3f;
    
    //UserPlaceholderImage border
    _userPlaceholderImage.layer.cornerRadius=_userPlaceholderImage.frame.size.height/2;
    _userPlaceholderImage.layer.masksToBounds=YES;
    _userPlaceholderImage.layer.borderColor=ImageBorderColor;
    _userPlaceholderImage.layer.borderWidth= 1.0f;
    
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

// Table View code.......
#pragma numberOfSectionsInTableView delegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma numberOfRowsInSection delegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_options count];
    
}
#pragma cellForRowAtIndexPath delegate method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tableIdentifier;
    
    tableIdentifier= @"inviteFriendCell";
    
    ReferralTableViewCell *cell=(ReferralTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier forIndexPath:indexPath];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width, 20)];
    v.backgroundColor = APPTHEMECOLOR;  // any color of your choice.
    
    cell.selectedBackgroundView = v;
    if (cell == nil) {
        cell = (ReferralTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier forIndexPath:indexPath];
        
    }
    
    cell.referralNameLabel.text= [_options objectAtIndex:indexPath.row];
    cell.referralIconImage.image=[UIImage imageNamed:[_icons objectAtIndex:indexPath.row]];
    
    
    return cell;
}
//Table Did select method
#pragma didSelectRowAtIndexPath delegate method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
            
        //SMS Method Call
        case 0:
            [self showSMS];
            break;
        //Email Method Call
        case 1:
            [self emailMethod];
            break;
        //Twitter Method Call
        case 2:
            [self shareTwitter];
            break;
        case 3:
            [self whatsAppCallMethod];
            break;

        default:
            break;
    }
}

-(void)whatsAppCallMethod
{
    NSURL *whatsappURL = [NSURL URLWithString:WhatsAppInvitation];
    
    if ([[UIApplication sharedApplication] canOpenURL:whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
    else {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:ErrorTitle message:ErrorAlertWhatsApp delegate:nil cancelButtonTitle:KChatVCOk otherButtonTitles:nil];
        [warningAlert show];
    }
}
//Custom message for SMS
- (void)showSMS {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:ErrorTitle message:ErrorAlertSms delegate:nil cancelButtonTitle:KChatVCOk otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    else
    {
    NSString *message = [NSString stringWithFormat:IviteMessage];
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:[NSArray arrayWithObjects:@"", nil]];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
    }
}


#pragma mark************************ Mail Method *********************

//Email Method to call email view controller
- (void)emailMethod
{
    if(![MFMailComposeViewController canSendMail]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:ErrorTitle message:EmailErrorAlert delegate:nil cancelButtonTitle:KChatVCOk otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    else
    {
        // Email Subject
        NSString *emailTitle = APP_NAME;
        // Email Content
        NSString *messageBody = IviteMessage;
        // To address
        //    NSArray *toRecipents = [NSArray arrayWithObject:@""];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ic_MakeInIndia" ofType:@"png"];
        NSData *myData = [NSData dataWithContentsOfFile:path];
        [mc addAttachmentData:myData mimeType:@"image/png" fileName:@"logo.png"];
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

// Delegate method of message composer
#pragma mark ************* messageComposeViewController*********************
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            [SVProgressHUD showWithStatus:@"Saved"];
            break;
        case MFMailComposeResultSent:
            [global showAllertMsg:@"iTeknika" Message:@"Thank you for sharing!"];
            break;
        case MFMailComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"Failed To send"];
            break;
        default:
            [SVProgressHUD showWithStatus:@"Not sent"];
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


//Twitter Share method
-(void)shareTwitter
{
    if([global isConnected]){
       
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any UI updates occur
        // on the main queue
        
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    NSLog(@"Twitter Sharing is done");
                    
                    if ([self connected]) {
                        // Show success message
                        
                    }
                    else {
                        // Show internet is not available message
                    }

                    break;
           
                default:
                    break;

            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        };
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText: IviteMessage];
                if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
                    [tweetSheet addURL:[NSURL URLWithString:@"iTeknika"]];
                }
         [tweetSheet addImage:[UIImage imageNamed:@"twitter_ad.png"]];
        //  Adds an image to the Tweet.  For demo purposes, assume we have an
        //  image named 'larry.png' that we wish to attach
        
        
        //  Presents the Tweet Sheet to the user
        [self presentViewController:tweetSheet animated:NO completion:^{
            
        }];
        
    }
    
}
// method to handle the parseURLParams
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
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
