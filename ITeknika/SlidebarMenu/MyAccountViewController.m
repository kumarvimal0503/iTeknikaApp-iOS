//
//  MyAccountViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountTableViewCell.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import "UIImageView+Network.h"
#import "UIImageView+WebCache.h"
#import "BackgroundLayer.h"

//Constant For Segue
#define LOGOUTSEGUE @"logOutSegue"
@interface MyAccountViewController ()
@property(nonatomic,strong) NSArray *optionsOne,*optionTwo,*identifireOne;
@end

@implementation MyAccountViewController
{
    UIImageView *topProfileBtn;
}
@synthesize userPlaceholderImage;
@synthesize fullnameLabel;
@synthesize locationLabel;
@synthesize optionsOne,optionTwo,identifireOne;
//Default Method
- (void)viewDidLoad {
    //Setting Tap Gesture on Front view controller
    SWRevealViewController *revealController = [self revealViewController];
    [revealController tapGestureRecognizer];
    
    
    
    NSURL *imageURL=[[NSURL alloc] initWithString:@"https://www.google.co.in/search?q=diwakar+prasad+garg&client=firefox-b-ab&biw=1373&bih=726&tbm=isch&imgil=hij-AB_pyAyuzM%253A%253BBqaggvdvop7y1M%253Bhttps%25253A%25252F%25252Fin.linkedin.com%25252Fin%25252Fdiwakar-prasad-garg-b8b09056&source=iu&pf=m&fir=hij-AB_pyAyuzM%253A%252CBqaggvdvop7y1M%252C_&usg=__jJiONrJ47xfdAYzesb2VnE8hmGo%3D&ved=0ahUKEwiZrs3Z6frOAhUGM48KHUtNDyAQyjcIMA&ei=tMHOV5mEGobmvATLmr2AAg#imgrc=hij-AB_pyAyuzM%3A"];
    
    [self.userPlaceholderImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"name"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        DMLog(@"Image Method Success");
    }];


    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIColor colorWithRed:0.992 green:0.855 blue:0.035 alpha:1],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    //Add the one menu (my progress)
    optionsOne = [NSArray arrayWithObjects:@"Home",@"Profile", @"Registred Job",@"Invite Friends",@"My Progress",@"Settings",@"Logout", nil];
    
    
    identifireOne=[NSArray arrayWithObjects:@"firstCell",@"secondCell",@"thirdCell",@"fourthCell",@"fifthCell",@"sixthCell",@"seventhCell",nil];
    
    self.menuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupProfilePic];
    

    
    USERID=@"Diwakar Garg";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//view will Appear Method
-(void)viewWillAppear:(BOOL)animated{
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];

        fullnameLabel.text=@"Diwakar Garg";
        
        locationLabel.text=@"8055290885";
   
    //Code for image
    
    NSURL *imageURL=[[NSURL alloc] initWithString:@"https://qb-mikemessenger-s3.s3.amazonaws.com/d6134dee8ab54c28a0cd0a2feefba85900"];
    
    [self.userPlaceholderImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"name"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        DMLog(@"Image Method Success");
    }];

    [super viewWillAppear:YES];
}
//view will Disappear Method
-(void)viewWillDisappear:(BOOL)animated
{
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
    [super viewWillDisappear:YES];
}
//View Didappear
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
//Setting number of row in section of table view.
#pragma numberOfRowsInSection delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [optionsOne count];
}
// Setting the table view cell.
#pragma cellForRowAtIndexPath delegate method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier;
    
    simpleTableIdentifier= [self.identifireOne objectAtIndex:indexPath.row];
    
    MyAccountTableViewCell *cell=(MyAccountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    cell.optionName.text = [optionsOne objectAtIndex:indexPath.row];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width, 20)];
    v.backgroundColor = APPTHEMECOLOR; // any color of your choice.
    cell.selectedBackgroundView = v;
    
    cell.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
    //    cell.layer.borderWidth= 0.3f;
    return cell;
}
//table Did Select Method
#pragma didSelectRowAtIndexPath delegate method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   if (indexPath.row==6) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Are you sure you want to Logout ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alert show];
        }
}
//Alert Show Method
-(void)alertShow
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:ALERTTITLE message:@"Please login first" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}
//Skip User Method
-(void)skipUser{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self alertShow];
}
//Code for alert View delegate method
#pragma alerview delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        DMLog(@"Logoout call");
    }
    else{

        //Plain Logout
        [self logout];
           }
}

//Logout Method
-(void)logout{
    //clear userdefaults
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    //Logout Segue
    [self performSegueWithIdentifier:LOGOUTSEGUE sender:nil];
    USERID=nil;
}
//Setting Profile pic look and feel.
-(void)setupProfilePic{
    @try{
        //UserPlaceholderImage border
        userPlaceholderImage.layer.cornerRadius=userPlaceholderImage.frame.size.height/2;
        userPlaceholderImage.layer.masksToBounds=YES;
        userPlaceholderImage.clipsToBounds=YES;
        userPlaceholderImage.layer.borderColor=ImageBorderColor;
        
        userPlaceholderImage.layer.borderWidth= 1.0f;
        //Table Border
        _menuTable.layer.borderColor=[[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5]CGColor];
        _menuTable.layer.borderWidth= 0.3f;
    }@catch(NSException *e){}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
