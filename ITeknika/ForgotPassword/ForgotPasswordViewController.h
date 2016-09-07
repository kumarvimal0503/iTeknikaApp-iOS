//
//  ForgotPasswordViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
@interface ForgotPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet TextFieldValidator *emailTextfield;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (IBAction)sendPasswordAction:(id)sender;
@end
