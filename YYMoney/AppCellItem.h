//
//  AppCellItem.h
//  YYMoney
//
//  Created by jeremy on 11/4/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppCellItem : NSObject

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *itunsLinkStr;

+ (NSMutableArray *)DataSource;

+ (NSMutableArray *)InstallDataSource;

+ (NSMutableArray *)OutTimeDataSource;


@end
