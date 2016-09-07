//
//  SignUpVC.m
//  ITeknika
//
//  Created by MIKE on 07/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation SignUpVC
@synthesize webViewPage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLookAndFeel];
    
    // Do any additional setup after loading the view.
}
-(void)setLookAndFeel
{
    activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width)-40, 20, 40, 40)];
    activityIndicator.color=[UIColor colorWithRed:0.78 green:0.22 blue:0.06 alpha:1.0];
    [activityIndicator startAnimating];
    self.navigationItem.title=@"Please Wait";
    [self.navigationController.view addSubview:activityIndicator];
    
    webViewPage.userInteractionEnabled=NO;
    webViewPage.delegate = self;
    
    // Navigation :- Left Bar Button Item
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.bounds = CGRectMake( 10, 0, 20, 20);
    [back addTarget:self action:@selector(backmenu) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"backarrow-w"] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButton;
    
   
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.iteknika.com"];
    
    webViewPage.userInteractionEnabled=YES;
    // NSURL *url = [NSURL URLWithString:URLstring];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //self.myWebView = tempWebview;
    [webViewPage loadRequest:requestObj];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
     self.navigationItem.title=@"iTeknika Website";
    [activityIndicator stopAnimating];
    webView.userInteractionEnabled=YES;
    [self.view viewWithTag:100].hidden = YES;
}


//Navigation bar button back method
-(void)backmenu{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
