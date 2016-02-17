//
//  MineTableViewController.m
//  YYMoney
//
//  Created by jeremy on 10/13/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "MineTableViewController.h"
#import "Utils.h"
#import "Config.h"
#import "UIColor+Util.h"
#import "MyInfo.h"
#import "AppDelegate.h"
#import "UIScrollView+ScalableCover.h"
#import "UIView+Util.h"
#import "HeshenghuoViewController.h"
#import "SettingsPage.h"

#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>

@interface MineTableViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *portrait;
@property (nonatomic, weak) IBOutlet UIButton *QRCodeButton;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UIView *separator;

@property (nonatomic, weak) IBOutlet UIButton *totalRevenueButton;
@property (nonatomic, weak) IBOutlet UIButton *balanceButton;
@property (nonatomic, weak) IBOutlet UIButton *apprenticeButton;

//@property (nonatomic, strong) UIImageView *myQRCodeImageView;

@property (nonatomic, assign) int64_t myID;
@property (nonatomic, strong) MyInfo *myInfo;
@property (nonatomic, strong) NSMutableArray *noticeCounts;
@property (nonatomic, assign) int badgeValue;



@end

@implementation MineTableViewController

- (void)dawnAndNightMode
{
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];
    self.refreshControl.tintColor = [UIColor refreshControlColor];
    
    [self refreshHeaderView];
}

- (void)awakeFromNib
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeUpdateHandler:) name:OSCAPI_USER_NOTICE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefreshHandler:)  name:@"userRefresh"     object:nil];
//    
    _noticeCounts = [NSMutableArray arrayWithArray:@[@(0), @(0), @(0), @(0), @(0)]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];
    
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self setUpSubviews];
    
    //_myID = [Config getOwnID];
    [self refreshHeaderView];
    
    [self refresh];
}

- (void)refresh
{
//    _myID = [Config getOwnID];
//    if (_myID == 0) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self refreshHeaderView];
//            [self.refreshControl endRefreshing];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        });
//    } else {
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager OSCManager];
//        
//        [manager GET:[NSString stringWithFormat:@"%@%@?uid=%lld", OSCAPI_PREFIX, OSCAPI_MY_INFORMATION, _myID]
//          parameters:nil
//             success:^(AFHTTPRequestOperation *operation, ONOXMLDocument *responseDocument) {
//                 ONOXMLElement *userXML = [responseDocument.rootElement firstChildWithTag:@"user"];
//                 _myInfo = [[OSCMyInfo alloc] initWithXML:userXML];
//                 
//                 [Config updateMyInfo:_myInfo];
//                 
//                 [self refreshHeaderView];
//                 [self.refreshControl endRefreshing];
//                 
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     [self.tableView reloadData];
//                 });
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 MBProgressHUD *HUD = [Utils createHUD];
//                 HUD.mode = MBProgressHUDModeCustomView;
//                 HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
//                 HUD.labelText = @"网络异常，加载失败";
//                 
//                 [HUD hide:YES afterDelay:1];
//                 
//                 [self.refreshControl endRefreshing];
//             }];
//    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - customize subviews

- (void)setUpSubviews
{
    _totalRevenueButton.titleLabel.numberOfLines = 0;
    _totalRevenueButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _balanceButton.titleLabel.numberOfLines = 0;
    _balanceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _apprenticeButton.titleLabel.numberOfLines = 0;
    _apprenticeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
//    [_collectionButton addTarget:self action:@selector(pushFavoriteSVC) forControlEvents:UIControlEventTouchUpInside];
//    [_followingButton addTarget:self action:@selector(pushFriendsSVC:) forControlEvents:UIControlEventTouchUpInside];
//    [_fanButton addTarget:self action:@selector(pushFriendsSVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [_portrait setBorderWidth:2.0 andColor:[UIColor whiteColor]];
    [_portrait setCornerRadius:25];
//    [_portrait addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPortrait)]];
    
    [self setCoverImage];
    self.refreshControl.tintColor = [UIColor refreshControlColor];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    UIView *selectedBackground = [UIView new];
    selectedBackground.backgroundColor = [UIColor colorWithHex:0xF5FFFA];
    [cell setSelectedBackgroundView:selectedBackground];
    
    cell.backgroundColor = [UIColor cellsColor];//colorWithHex:0xF9F9F9
    
    cell.textLabel.text = @[@"立即提现", @"系统设置", @"系统消息", @"测试"][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@[@"setting-money", @"setting-systemmessage", @"setting-systemsetting", @"setting-test"][indexPath.row]];
    
    cell.textLabel.textColor = [UIColor grayColor];
    
    if (indexPath.row == 0) {
        if (_badgeValue == 0) {
            cell.accessoryView = nil;
        } else {
            UILabel *accessoryBadge = [UILabel new];
            accessoryBadge.backgroundColor = [UIColor redColor];
            accessoryBadge.text = [@(_badgeValue) stringValue];
            accessoryBadge.textColor = [UIColor whiteColor];
            accessoryBadge.textAlignment = NSTextAlignmentCenter;
            accessoryBadge.layer.cornerRadius = 11;
            accessoryBadge.clipsToBounds = YES;
            
            CGFloat width = [accessoryBadge sizeThatFits:CGSizeMake(MAXFLOAT, 26)].width + 8;
            width = width > 26? width: 22;
            accessoryBadge.frame = CGRectMake(0, 0, width, 22);
            cell.accessoryView = accessoryBadge;
        }
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if ([Config getOwnID] == 0) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        [self.navigationController pushViewController:loginVC animated:YES];
//        return;
//    }
    
    switch (indexPath.row) {
        case 0:
        {
            _badgeValue = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
            self.navigationController.tabBarItem.badgeValue = nil;
            
//            MessageCenter *messageCenterVC = [[MessageCenter alloc] initWithNoticeCounts:_noticeCounts];
//            messageCenterVC.hidesBottomBarWhenPushed = NO;
//            [self.navigationController pushViewController:messageCenterVC animated:YES];
            
            break;
        }
        case 1:
        {
//            BlogsViewController *blogsVC = [[BlogsViewController alloc] initWithUserID:_myID];
//            blogsVC.navigationItem.title = @"我的博客";
//            blogsVC.hidesBottomBarWhenPushed = NO;
//            [self.navigationController pushViewController:blogsVC animated:YES];
            SettingsPage *settingPage = [SettingsPage new];
            settingPage.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingPage animated:NO];
            break;
        }
        case 2: {
//            TeamCenter *teamCenter = [TeamCenter new];
//            teamCenter.hidesBottomBarWhenPushed = NO;
//            [self.navigationController pushViewController:teamCenter animated:YES];

            
            break;
        }
        case 3: {
            HeshenghuoViewController *heshenghuoViewController = [HeshenghuoViewController new];
            heshenghuoViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:heshenghuoViewController animated:NO];
            break;
        }
        default:
            break;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - refresh header

- (void)refreshHeaderView
{
    NSArray *usersInformation = [Config getUsersInformation];
    
    if (_myID == 0) {
        _portrait.image = [UIImage imageNamed:@"default-portrait"];
    } else {
        UIImage *portrait = [Config getPortrait];
        if (portrait == nil) {
            [_portrait sd_setImageWithURL:_myInfo.portraitURL
                         placeholderImage:[UIImage imageNamed:@"default-portrait"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    if (!image) {return;}
                                    [Config savePortrait:image];
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
                                }];
        } else {
            _portrait.image = portrait;
        }
    }
    
    _nameLabel.text = usersInformation[0];
    _separator.backgroundColor = [UIColor lineColor];
    
    [self setCoverImage];
    
    //test code
    [_totalRevenueButton setTitle:[NSString stringWithFormat:@"总收益\n%@", usersInformation[1]] forState:UIControlStateNormal];
    [_balanceButton setTitle:[NSString stringWithFormat:@"可用余额\n%@", usersInformation[2]] forState:UIControlStateNormal];
    [_apprenticeButton setTitle:[NSString stringWithFormat:@"学徒\n%@", usersInformation[3]] forState:UIControlStateNormal];
    
//    if (_myID == 0) {
//        _QRCodeButton.hidden = YES;
//        _creditButton.hidden = YES;
//        _collectionButton.hidden = YES;
//        _followingButton.hidden = YES;
//        _fanButton.hidden = YES;
//        _separator.hidden = YES;
//    } else {
//        _QRCodeButton.hidden = NO;
//        _creditButton.hidden = NO;
//        _collectionButton.hidden = NO;
//        _followingButton.hidden = NO;
//        _fanButton.hidden = NO;
//        _separator.hidden = NO;
//        
//        _QRCodeButton.titleLabel.font = [UIFont fontAwesomeFontOfSize:25];
//        [_QRCodeButton setTitle:[NSString fontAwesomeIconStringForEnum:FAQrcode] forState:UIControlStateNormal];
//        [_QRCodeButton addTarget:self action:@selector(showQRCode) forControlEvents:UIControlEventTouchUpInside];
//        
//        [_creditButton setTitle:[NSString stringWithFormat:@"积分\n%@", usersInformation[1]] forState:UIControlStateNormal];
//        [_collectionButton setTitle:[NSString stringWithFormat:@"收藏\n%@", usersInformation[2]] forState:UIControlStateNormal];
//        [_followingButton setTitle:[NSString stringWithFormat:@"关注\n%@", usersInformation[3]] forState:UIControlStateNormal];
//        [_fanButton setTitle:[NSString stringWithFormat:@"粉丝\n%@", usersInformation[4]] forState:UIControlStateNormal];
//    }
    
    
}

- (void)setCoverImage
{
    NSNumber *screenWidth = @([UIScreen mainScreen].bounds.size.width);
    NSString *imageName = @"user-background";
    if (screenWidth.intValue < 400) {
        imageName = [NSString stringWithFormat:@"%@-%@", imageName, screenWidth];
    }
    
    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
        imageName = [NSString stringWithFormat:@"%@-dark", imageName];
    }
    
    if (!self.tableView.scalableCover) {
        [self.tableView addScalableCoverWithImage:[UIImage imageNamed:imageName]];
    } else{
        self.tableView.scalableCover.image = [UIImage imageNamed:imageName];
    }
}

- (void)tapPortrait
{
}

- (void)userRefreshHandler:(NSNotification *)notification
{
//    _myID = [Config getOwnID];
    
    [self refreshHeaderView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
