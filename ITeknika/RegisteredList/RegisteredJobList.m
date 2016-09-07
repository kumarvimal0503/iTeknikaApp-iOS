//
//  RegisteredJobList.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "RegisteredJobList.h"
#import "global.h"
#import "SWRevealViewController.h"

@interface RegisteredJobList ()

@end

@implementation RegisteredJobList

- (void)viewDidLoad {
    [self setViewLookAndFeel];
    [self initialize];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark************************ Custom Methods *********************
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

//Setting look and feel of the screen.
-(void)setViewLookAndFeel
{
   
    //Hide seprator Line
//    self.landingTableView.separatorColor = [UIColor clearColor];
    
    //    //Hiding extra cell in table view
    //        self.landingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
