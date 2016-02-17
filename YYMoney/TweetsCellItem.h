//
//  TweetsCellItem.h
//  YYMoney
//
//  Created by jeremy on 10/29/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TweetsCellItem : NSObject

@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, copy) NSString *priceStr;
@property (nonatomic, copy) NSString *allNumberStr;
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, copy) NSString *remainNumberStr;
@property (nonatomic, copy) NSString *beginTimeStr;
@property (nonatomic, copy) NSString *endTimeStr;
@property (nonatomic, copy) NSString *urlStr;

+ (NSMutableArray *)DataSource;

@end
