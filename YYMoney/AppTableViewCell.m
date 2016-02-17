//
//  AppTableViewCell.m
//  YYMoney
//
//  Created by jeremy on 11/4/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "AppTableViewCell.h"

@implementation AppTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAppCellItem:(AppCellItem *)appCellItem
{
    _appCellItem = appCellItem;
 
    _titleLabel.text = appCellItem.titleStr;
    _detailLabel.text = appCellItem.detailStr;
    _photoImageView.image = appCellItem.photo;
}

@end
