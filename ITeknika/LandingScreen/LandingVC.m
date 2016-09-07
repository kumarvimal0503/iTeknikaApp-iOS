//
//  LandingVC.m
//  ITeknika
//
//  Created by Diwakar Garg on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "LandingVC.h"
#import "global.h"
#import "SWRevealViewController.h"
#import "LandingTableViewCell.h"


@interface LandingVC ()
{
    int count;
    NSMutableArray *jobListArray,*jobDescriptionArray;
}
@end

@implementation LandingVC
@synthesize landingTableView;

#pragma mark************************ view controller life cycle *********************
- (void)viewDidLoad {
    [self setViewLookAndFeel];
    [self initialize];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark************************ Custom Methods *********************
//Code for Menu Slide bar Show on swipe gesture
-(void)initialize{
    //adding swipe gesture
    SWRevealViewController *sw=self.revealViewController;
    sw.rearViewRevealWidth=self.view.frame.size.width-60.0f;
    self.navigationItem.leftBarButtonItem.target=self.revealViewController;
    self.navigationItem.leftBarButtonItem.action=@selector(revealToggle:);
    [self.navigationController.topViewController.navigationItem setHidesBackButton:NO];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//Setting look and feel of the screen.
-(void)setViewLookAndFeel
{
//    jobListArray=nil;
//    jobDescriptionArray=nil;
    
    jobListArray=[[NSMutableArray alloc] initWithObjects:@"JOB 1",@"JOB 2",@"JOB 3",@"JOB 4",@"JOB 5",@"JOB 6",@"JOB 7", nil];
    jobDescriptionArray=[[NSMutableArray alloc] initWithObjects:@"JOB Detail 1",@"JOB Detail 2",@"JOB Detail 3",@"JOB Detail 4",@"JOB Detail 5",@"JOB Detail 6",@"JOB Detail 7", nil];
    self.navigationItem.title = @"Home Page";
    
//    Hide seprator Line
    self.landingTableView.separatorColor = [UIColor clearColor];
    
    //    //Hiding extra cell in table view
//        self.landingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)countList
{
    count=0;
    @try{
        count=(int)[jobListArray count];
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(-10, (bgView.frame.size.height / 2)- 80, bgView.frame.size.width, 44)];
//        [button setImage:[UIImage imageNamed:USER_PLACEHOLDER] forState:UIControlStateNormal];
//        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 150, 0, -110)];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
        [button setTitle:@"click here to reload the data" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tableBgButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
        if(count<=0)
        {
            self.landingTableView.backgroundView = bgView;
        }
        else{
            self.landingTableView.backgroundView=nil;
        }
    }@catch(NSException *e){}
    
}

-(void)tableBgButtonAction
{
    [landingTableView reloadData];
    DMLog(@"table reload call");
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_NAME message:@"Go to Setting" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                    {
//                                        [self sendToSettingPage];
//                                        //write command for action perform
//                                    }];
//    
//    UIAlertAction* cancel = [UIAlertAction actionWithTitle:KCancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                             {
//                                 //write command for action perform
//                             }];
//    
//    [alert addAction:defaultAction];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
}

//-(void)sendToSettingPage
//{
//    BOOL canOpenSettings = (UIApplicationOpenSettingsURLString != NULL);
//    if (canOpenSettings)
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//    
//}


#pragma mark************************ TableView delegate  methods *********************

// Table View code.......
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
    
}
//Setting number of row in section of table view.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self countList];
    if (count>0)
    {
        return [jobListArray count];
    }
    else
    {
        return count;
    }
    
}

// Setting the table view cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"landingCell";
    
    LandingTableViewCell *cell=(LandingTableViewCell *)[tableView   dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[LandingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    cell.jobTitleLabel.text=[jobListArray objectAtIndex:indexPath.row];
    cell.jobDescriptionLabel.text=[jobDescriptionArray objectAtIndex:indexPath.row];
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = ChatsCellColor;
    else
        cell.backgroundColor = WhiteColor;
    
    
    return cell;
    
    
}


//code for seperator line
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
