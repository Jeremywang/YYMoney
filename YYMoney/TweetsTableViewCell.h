//
//  TweetsTableViewCell.h
//  YYMoney
//
//  Created by jeremy on 10/28/15.
//  Copyright © 2015 Fuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsCellItem.h"

@interface TweetsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *allNumbers;
@property (weak, nonatomic) IBOutlet UILabel *remainNumbers;
@property (weak, nonatomic) IBOutlet UILabel *beginTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (strong, nonatomic) TweetsCellItem *tweetsCellItem;
@property (strong, nonatomic) NSString *urlShareLinkStr;

//- (void)setTweetsCellItem:(TweetsCellItem *)tweetsCellItem;

@end
