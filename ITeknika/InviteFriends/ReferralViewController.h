//
//  ReferralViewController.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface ReferralViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPlaceholderImage;
@property (weak, nonatomic) IBOutlet UITableView *referralTable;

@end
