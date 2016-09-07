//
//  ChangePasswordViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet TextFieldValidator *oldPasswordtextfield;
@property (weak, nonatomic) IBOutlet TextFieldValidator *passwordtextfield;
@property (weak, nonatomic) IBOutlet TextFieldValidator *confirmPasswordtextfield;
@end
