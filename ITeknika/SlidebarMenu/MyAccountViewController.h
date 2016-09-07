//
//  MyAccountViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyAccountViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPlaceholderImage;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@end
