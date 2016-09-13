//
//  ProfileSnapShotVC.m
//  ITeknika
//
//  Created by Diwakar Garg on 13/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "ProfileSnapShotVC.h"
#import "global.h"
#import "SVProgressHUD.h"
#import "BackgroundLayer.h"

@interface ProfileSnapShotVC ()

@end

@implementation ProfileSnapShotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewLookAndFeel];
    // Do any additional setup after loading the view.
}

// Setting look and feel of the change password screen.
-(void)setViewLookAndFeel{
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    self.navigationItem.title = @"Profile SnapShot";
    // Navigation Bar
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];

}

// Navigation bar save button
-(void)Save{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFade;
    [self.view.window.layer addAnimation:transition forKey:nil];
   
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
