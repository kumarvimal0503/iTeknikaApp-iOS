//
//  RegisteredJobList.h
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#define REGISTREDJOB_SEGUE_IDENTIFIER @"registredJobDescriptionSegue"

@interface RegisteredJobList : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *registeredJobTable;

@end
