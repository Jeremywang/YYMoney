//
//  TweetsCellItem.m
//  YYMoney
//
//  Created by jeremy on 10/29/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "TweetsCellItem.h"

@implementation TweetsCellItem

+ (NSMutableArray *) DataSource
{
    NSMutableArray * dataSource = [NSMutableArray new];
    
    TweetsCellItem *item = [TweetsCellItem new];
    item.contentStr = @"美女和你活动，看他72变, 晨跑？夜跑？到底跑步最好的时间是什么时候，倾听美女的奖金";
    item.priceStr = @"0.12";
    item.photo = [UIImage imageNamed:@"Cell-photo"];
    item.allNumberStr = @"10000";
    item.remainNumberStr = @"5000";
    item.beginTimeStr = @"2015-10-11";
    item.endTimeStr = @"2015-10-30";
    item.urlStr = @"http://www.mob.com/";
    [dataSource addObject:item];
    
    item = [TweetsCellItem new];
    item.contentStr = @"惊呆了，原理微信可以这么玩，你居然不知道";
    item.priceStr = @"0.15";
    item.photo = [UIImage imageNamed:@"Cell-photo"];
    item.allNumberStr = @"10050";
    item.remainNumberStr = @"5123";
    item.beginTimeStr = @"2015-10-12";
    item.endTimeStr = @"2015-10-28";
    item.urlStr = @"www.sina.com";
    [dataSource addObject:item];
    
    item = [TweetsCellItem new];
    item.contentStr = @"x5到底问题出在来，你不来试试怎么知道";
    item.priceStr = @"0.16";
    item.photo = [UIImage imageNamed:@"Cell-photo"];
    item.allNumberStr = @"80000";
    item.remainNumberStr = @"50023";
    item.beginTimeStr = @"2015-10-13";
    item.endTimeStr = @"2015-10-29";
    item.urlStr = @"www.qq.com";
    [dataSource addObject:item];
    
    
    item = [TweetsCellItem new];
    item.contentStr = @"sb路虎问题多多，你还会买吗？细数路虎存在问题";
    item.priceStr = @"0.17";
    item.photo = [UIImage imageNamed:@"Cell-photo"];
    item.allNumberStr = @"60000";
    item.remainNumberStr = @"22200";
    item.beginTimeStr = @"2015-10-15";
    item.endTimeStr = @"2015-10-27";
    item.urlStr = @"www.baidu.com";
    [dataSource addObject:item];
    
    
    
    return dataSource;
}

@end
