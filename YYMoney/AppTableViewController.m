//
//  AppTableViewController.m
//  YYMoney
//
//  Created by jeremy on 10/11/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "AppTableViewController.h"
#import "UIColor+Util.h"
#import "Config.h"
#import <UIKit/UIKit.h>
#import "AppCellItem.h"
#import "AppTableViewCell.h"
#import "UIView+Util.h"

@interface AppTableViewController ()

@property (nonatomic, strong) NSMutableArray *unInstallDataArray;
@property (nonatomic, strong) NSMutableArray *installDataArray;
@property (nonatomic, strong) NSMutableArray *outTimeDataArray;

@end

@implementation AppTableViewController

- (void)dawnAndNightMode
{
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithHex:0xF5F5F5];
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];
    
    _unInstallDataArray = [AppCellItem DataSource];
    _installDataArray = [AppCellItem InstallDataSource];
    _outTimeDataArray = [AppCellItem OutTimeDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_unInstallDataArray count];
        case 1:
            return [_installDataArray count];
        case 2:
            return [_outTimeDataArray count];
        default:
            return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [UITableViewCell new];
    
    AppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYCellDetailIdentifier" forIndexPath:indexPath];
    
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    cell.backgroundColor = [UIColor cellsColor];
    cell.textLabel.textColor = [UIColor titleColor];
    [cell.photoImageView setCornerRadius:10];
    
    switch (indexPath.section) {
        case 0:
            [cell setAppCellItem:[_unInstallDataArray objectAtIndex:indexPath.row]];
            
            break;
        case 1:
            [cell setAppCellItem:[_installDataArray objectAtIndex:indexPath.row]];
            break;
        case 2:
            [cell setAppCellItem:[_outTimeDataArray objectAtIndex:indexPath.row]];
        default:
            break;
    }
    // Configure the cell...
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellColor];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"未品尝";
        case 1:
            return @"已品尝";
        case 2:
            return @"已过期";
        default:
            return @"title wrong";
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 23)];
    customView.backgroundColor = self.tableView.backgroundColor;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    
    switch (section) {
        case 0:
            [titleLabel setText:@"未品尝"];
            break;
        case 1:
            [titleLabel setText:@"已品尝"];
            break;
        case 2:
            [titleLabel setText:@"已过期"];
            break;
        default:
            [titleLabel setText:@"Wrong"];
            break;
    }
    
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextColor:[UIColor titleColor]];
    [customView addSubview:titleLabel];
    
    return customView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.section) {
        case 0:
        {
           [self handleCellAction:indexPath.row];
            
            break;
        }
        case 1:
        {
             NSURL *url = [NSURL URLWithString:@"test://com.fuyou.test"];
             [[UIApplication sharedApplication] openURL:url];
            break;
        }
        case 2:
        {
            NSURL *url = [NSURL URLWithString:@"test://com.fuyou.test"];
            [[UIApplication sharedApplication] openURL:url];
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


- (void)handleCellAction:(NSInteger)index
{
    NSString *urlString = [[_unInstallDataArray objectAtIndex:index] itunsLinkStr];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


@end
