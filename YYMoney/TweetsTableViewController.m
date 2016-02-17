//
//  TweetsTableViewController.m
//  YYMoney
//
//  Created by jeremy on 10/27/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "TweetsCellItem.h"
#import "TweetsTableViewCell.h"
#import "UIColor+Util.h"

#import <ShareSDK/ShareSDK.h>


@interface TweetsTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TweetsTableViewController

- (void)dawnAndNightMode
{
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorColor = [UIColor seperatorColor];

    _dataArray = [TweetsCellItem DataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetsTableViewCellIdentifider" forIndexPath:indexPath];
    
    [cell setTweetsCellItem:[_dataArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section)
    {
        case 0:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            //[self showShareActionSheet:cell];
            [self showShareAlertView:cell];
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

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
//    __weak TweetsTableViewController *theController = self;
//    __weak TweetsTableViewCell *theCell = (TweetsTableViewCell *)view;
//    
//    //1、创建分享参数（必要）
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
//    [shareParams SSDKSetupShareParamsByText:[[theCell contentLabel] text]
//                                     images:imageArray
//                                        url:[NSURL URLWithString:@"http://mob.com"]
//                                      title:[[theCell contentLabel] text]
//                                       type:SSDKContentTypeAuto];
    
    
//    
//    NSArray *shareList = [ShareSDK getShareListWithType:
//                          ShareTypeFacebook,
//                          ShareTypeWeixiSession,
//                          ShareTypeWeixiTimeline,
//                          ShareTypeSMS,
//                          ShareTypeQQ,
//                          ShareTypeMail,
//                          ShareTypeCopy,nil];
//    
//    NSMutableArray *activePlatforms = [ShareSDK ];
    //1.2、自定义分享平台（非必要）
 //   NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
//    //添加一个自定义的平台（非必要）
//    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
//                                                                                  label:@"自定义"
//                                                                                onClick:^{
//                                                                                    
//                                                                                    //自定义item被点击的处理逻辑
//                                                                                    NSLog(@"=== 自定义item被点击 ===");
//                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
//                                                                                                                                        message:nil
//                                                                                                                                       delegate:nil
//                                                                                                                              cancelButtonTitle:@"确定"
//                                                                                                                              otherButtonTitles:nil];
//                                                                                    [alertView show];
//                                                                                }];
//    [activePlatforms addObject:item];
    
    //设置分享菜单栏样式（非必要）
//            [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
//            [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//            [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//            [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
//            [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
//            [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
//            [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
//            [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
    
    //2、分享
//    [ShareSDK showShareActionSheet:view
//                             items:nil
//                       shareParams:shareParams
//               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                   
//                   switch (state) {
//                           
//                       case SSDKResponseStateBegin:
//                       {
//                           [theController showLoadingView:YES];
//                           break;
//                       }
//                       case SSDKResponseStateSuccess:
//                       {
//                           NSLog(@"The response of wechat2.");
//                           UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                           [alertController addAction:okAction];
//                           
//                           [self presentViewController:alertController animated:YES completion:nil];
//                           
//                           break;
//                       }
//                       case SSDKResponseStateFail:
//                       {
//                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
//                           {
//                               UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享失败" message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。" preferredStyle:UIAlertControllerStyleAlert];
//                               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                               [alertController addAction:okAction];
//                               
//                               [self presentViewController:alertController animated:YES completion:nil];
//                               
//                               break;
//                           }
//                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
//                           {
//                               UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享失败" message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用。" preferredStyle:UIAlertControllerStyleAlert];
//                               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                               [alertController addAction:okAction];
//                               
//                               [self presentViewController:alertController animated:YES completion:nil];
//                               
//
//                               break;
//                           }
//                           else
//                           {
//                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
//                               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                               [alertController addAction:okAction];
//                               
//                               break;
//                           }
//                           break;
//                       }
//                       case SSDKResponseStateCancel:
//                       {
//                           UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享已取消" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                           
//                           
//                           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                           [alertController addAction:okAction];
//                           
//                           [self presentViewController:alertController animated:YES completion:nil];
//                           
//                           break;
//                       }
//                       default:
//                           break;
//                   }
//                   
//                   if (state != SSDKResponseStateBegin)
//                   {
//                       [theController showLoadingView:NO];
//                       [theController.tableView reloadData];
//                   }
//                   
//               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}

#pragma mark -

/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
- (void)showLoadingView:(BOOL)flag
{
    NSLog(@"showLoadingView");
//    if (flag)
//    {
//        [self.view addSubview:self.panelView];
//        [self.loadingView startAnimating];
//    }
//    else
//    {
//        [self.panelView removeFromSuperview];
//    }
}


- (void)showShareAlertView:(UIView *)view
{
    __weak TweetsTableViewCell *theCell = (TweetsTableViewCell *)view;
    
    //1、构造分享内容
    //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
    //id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
    id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"girl" ofType:@"jpg"]];
    
    //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
    id<ISSContent> publishContent = [ShareSDK content:[[theCell contentLabel] text]
                                       defaultContent:nil
                                                image:localAttachment
                                                title:[[theCell contentLabel] text]
                                                  url:[theCell urlShareLinkStr]
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //1.3、自定义各个平台的分享内容(非必要)
    [self customizePlatformShareContent:publishContent];
    
    //1.4、自定义一个分享菜单项(非必要)
    id<ISSShareActionSheetItem> customItem = [ShareSDK shareActionSheetItemWithTitle:@"Custom"
                                                                                icon:[UIImage imageNamed:@"Icon.png"]
                                                                        clickHandler:^{
                                                                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"自定义分享菜单" message:@"自定义分享菜单点击" preferredStyle:UIAlertControllerStyleAlert];
                                                                            
                                                                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];

                                                                            [alertController addAction:okAction];
                                                                            [self presentViewController:alertController animated:YES completion:nil];
                                                                        }];
    //1.5、分享菜单栏选项排列位置和数组元素index相关(非必要)
    NSArray *shareList = [ShareSDK customShareListWithType:
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                          SHARE_TYPE_NUMBER(ShareTypeQQ),
                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                          customItem,nil];
    
    //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    //2、展现分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                NSLog(@"=== response state :%zi ",state);
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                    
                                    [alertController addAction:okAction];
                                    
                                    [self presentViewController:alertController animated:YES completion:nil];

                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"分享失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                    
                                    [alertController addAction:okAction];
                                    
                                    [self presentViewController:alertController animated:YES completion:nil];
                                }
                            }];
}

- (void)customizePlatformShareContent:(id<ISSContent>)publishContent
{
    //定制QQ空间分享内容
    [publishContent addQQSpaceUnitWithTitle:@"The title of QQ Space."
                                        url:@"http://www.mob.com"
                                       site:nil
                                    fromUrl:nil
                                    comment:@"comment"
                                    summary:@"summary"
                                      image:nil
                                       type:@(4)
                                    playUrl:nil
                                       nswb:0];
    
//    //定制邮件分享内容
//    [publishContent addMailUnitWithSubject:@"The subject of Mail"
//                                   content:@"The content of Mail."
//                                    isHTML:[NSNumber numberWithBool:YES]
//                               attachments:nil
//                                        to:nil
//                                        cc:nil
//                                       bcc:nil];
    //定制新浪微博分享内容
    id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"shareImg" ofType:@"png"]];
    [publishContent addSinaWeiboUnitWithContent:@"The content of Sina Weibo" image:localAttachment];
    
}

@end
