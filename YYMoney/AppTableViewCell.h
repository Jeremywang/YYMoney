//
//  AppTableViewCell.h
//  YYMoney
//
//  Created by jeremy on 11/4/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCellItem.h"

@interface AppTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (strong, nonatomic) AppCellItem *appCellItem;

- (void)setAppCellItem:(AppCellItem *)appCellItem;

@end
