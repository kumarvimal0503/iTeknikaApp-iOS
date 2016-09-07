//
//  LoginVC.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet TextFieldValidator *emailTextField;
@property (weak, nonatomic) IBOutlet TextFieldValidator *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *createNewAccountButton;

@end
