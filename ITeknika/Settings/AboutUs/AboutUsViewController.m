//
//  AboutUsViewController.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "AboutUsViewController.h"
#import "BackgroundLayer.h"
//Constant For Segue
#define TERMSOFSERVICESEGUE @"termsOfServiceSegue"
#define PRIVACYPOLICYSEGUE @"privacyPolicySegue"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
// view did load
- (void)viewDidLoad {
    //Background Gradient SettingSetting
    CAGradientLayer *bgLayer = [BackgroundLayer blueOrangeGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
// termsOfServiceAction button
- (IBAction)termsOfServiceAction:(id)sender {
    [self performSegueWithIdentifier:TERMSOFSERVICESEGUE sender:nil];
}
// privacyPolicyAction button
- (IBAction)privacyPolicyAction:(id)sender {
    [self performSegueWithIdentifier:PRIVACYPOLICYSEGUE sender:nil];
}
@end
