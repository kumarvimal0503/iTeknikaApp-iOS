//
//  EditProfileViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"


@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userPlaceholderImage;
@property (weak, nonatomic) IBOutlet TextFieldValidator *firstNameTextfield;
@property (weak, nonatomic) IBOutlet TextFieldValidator *lastNameTextfield;
@property (weak, nonatomic) IBOutlet TextFieldValidator *phoneTextfield;
@property (weak, nonatomic) IBOutlet TextFieldValidator *emailTextfield;
@property (weak, nonatomic) IBOutlet UIButton *cloudButton;
- (IBAction)changePictureAction:(id)sender;

@end
