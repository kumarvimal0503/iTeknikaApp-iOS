//
//  SettingsViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *smsAlertSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *emailAlertSwitch;
@property (weak, nonatomic) IBOutlet UIButton *shareFeedbackButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutUsButton;
- (IBAction)shareFeedbackAction:(id)sender;
- (IBAction)aboutUsButton:(id)sender;
- (IBAction)smsAlertAction:(id)sender;
- (IBAction)emailAlertAction:(id)sender;
@end
