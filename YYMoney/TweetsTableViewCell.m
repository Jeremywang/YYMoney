//
//  TweetsTableViewCell.m
//  YYMoney
//
//  Created by jeremy on 10/28/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import "TweetsTableViewCell.h"

@implementation TweetsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweetsCellItem:(TweetsCellItem *)tweetsCellItem
{
    _tweetsCellItem = tweetsCellItem;
    
    _contentLabel.text = _tweetsCellItem.contentStr;
    _priceLabel.text = _tweetsCellItem.priceStr;
    _allNumbers.text = _tweetsCellItem.allNumberStr;
    _remainNumbers.text = _tweetsCellItem.remainNumberStr;
    _beginTime.text = _tweetsCellItem.beginTimeStr;
    _endTime.text = _tweetsCellItem.endTimeStr;
    
    _urlShareLinkStr = _tweetsCellItem.urlStr;
    
}

@end
