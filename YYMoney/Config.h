//
//  Config.h
//  YYMoney
//
//  Created by jeremy on 9/30/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Config : NSObject

+ (void)saveWhetherNightMode:(BOOL)isNight;
+ (BOOL)getMode;
+ (UIImage *)getPortrait;
+ (NSArray *)getUsersInformation;
+ (void)savePortrait:(UIImage *)portrait;

+ (void)clearCookie;

@end
