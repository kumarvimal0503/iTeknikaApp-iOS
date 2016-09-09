//
//  JobDetailVC.m
//  ITeknika
//
//  Created by Diwakar Garg on 09/09/16..
//  Copyright © 2016 iTeknika. All rights reserved.

#import "JobDetailVC.h"

@interface JobDetailVC ()

@end

@implementation JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewLookAndFeel];
    // Do any additional setup after loading the view.
}
//Setting look and feel of the screen.
-(void)setViewLookAndFeel
{
     self.navigationController.title=@"Job Detail";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerationButtonAction:(id)sender
{
    
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
