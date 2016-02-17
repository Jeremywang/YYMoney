//
//  AppCellItem.m
//  YYMoney
//
//  Created by jeremy on 11/4/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "AppCellItem.h"

@implementation AppCellItem

+ (NSMutableArray *) DataSource
{
    NSMutableArray *dataSource = [NSMutableArray new];
    
    AppCellItem *item = [AppCellItem new];
    item.titleStr = @"和生活";
    item.detailStr = @"下载并注册立即送5块话费";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"heshenghuo" ofType:@"jpg"]];
    item.itunsLinkStr = @"https://itunes.apple.com/cn/app/he-sheng-huo/id626162542?l=en&mt=8";
    
    [dataSource addObject:item];
    
    item = [AppCellItem new];
    item.titleStr = @"知趣天气";
    item.detailStr = @"下载注册每天推送天气预告，穿衣，取暖，烤火";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"weather" ofType:@"png"]];
    item.itunsLinkStr = @"https://itunes.apple.com/cn/app/mei-tuan-wai-mai/id737310995#";
    
    [dataSource addObject:item];
    
    item = [AppCellItem new];
    item.titleStr = @"快拍";
    item.detailStr = @"Enjoy fast and fun mobile conversation! Snap a photo or a video, add a caption, and send it to a friend. They’ll view it, laugh, and then the Snap disappears from the screen – unless they take a screenshot!";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"kuaipai" ofType:@"png"]];
    item.itunsLinkStr = @"https://itunes.apple.com/cn/app/snapchat/id447188370?l=en&mt=8";
    
    [dataSource addObject:item];
    
    item = [AppCellItem new];
    item.titleStr = @"火车票";
    item.detailStr = @"买火车票是一款通过直接连接中国铁路客户服务中心官方网站(12306.cn)来购买火车票的移动设备客户端工具软件";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"huochepiao" ofType:@"png"]];
    item.itunsLinkStr = @"https://itunes.apple.com/cn/app/mai-huo-che-piao-for-12306guan/id668518784?l=en&mt=8";
    
    [dataSource addObject:item];
    
    item = [AppCellItem new];
    item.titleStr = @"新仙剑奇侠转";
    item.detailStr = @"官方正版3D手游《新仙剑奇侠传》新版火热来袭！二十年情缘再续，回忆心底最初的感动！";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"xianjian" ofType:@"png"]];
    item.itunsLinkStr = @"https://itunes.apple.com/cn/app/xin-xian-jian-qi-xia-chuan3d/id965082520?l=en&mt=8";
    
    [dataSource addObject:item];
    
    
    return dataSource;
}

+ (NSMutableArray *)InstallDataSource
{
    NSMutableArray *installDataSource = [NSMutableArray new];
    
    AppCellItem *item = [AppCellItem new];
    item.titleStr = @"同城热恋";
    item.detailStr = @"下载注册送女朋友";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"tongchengrenlan" ofType:@"png"]];
    item.itunsLinkStr = nil;
    
    [installDataSource addObject:item];
    
    
    item = [AppCellItem new];
    item.titleStr = @"淘宝";
    item.detailStr = @"手机淘宝（iPhone版）是淘宝专为iPhone手机用户推出的满足其生活消费和线上购物需求的软件，具有查看附近的生活优惠信息、商品搜索、浏览、购买、支付、收藏、物流查询、旺旺沟通等在线功能，成为了用户方便快捷的生活消费入口。";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"taobao" ofType:@"png"]];
    item.itunsLinkStr = nil;
    
    [installDataSource addObject:item];
    
    
    return installDataSource;
}

+ (NSMutableArray *)OutTimeDataSource
{
    NSMutableArray *outTimeDataSource = [NSMutableArray new];
    
    AppCellItem *item = [AppCellItem new];
    item.titleStr = @"YYMoney";
    item.detailStr = @"YY挣钱工具";
    item.photo = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"taobao" ofType:@"png"]];
    item.itunsLinkStr = nil;
    
    [outTimeDataSource addObject:item];
    
    return outTimeDataSource;
}

@end
