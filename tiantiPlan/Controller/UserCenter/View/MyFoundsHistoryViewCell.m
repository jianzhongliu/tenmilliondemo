//
//  MyFoundsHistoryViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/23.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "MyFoundsHistoryViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UserBuyHistoryListModel.h"

@interface MyFoundsHistoryViewCell ()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelOwner;
@property (nonatomic, strong) UILabel *openTime;

@end

@implementation MyFoundsHistoryViewCell

- (UIImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
    }
    return _imageIcon;
}

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"iPhone 6S 64 G 超大内存 王者风范";
    }
    return _labelTitle;
}

- (UILabel *)labelOwner {
    if (_labelOwner == nil) {
        _labelOwner = [[UILabel alloc] init];
        _labelOwner.numberOfLines = 0;
        _labelOwner.lineBreakMode = NSLineBreakByCharWrapping;
        _labelOwner.textAlignment = NSTextAlignmentLeft;
        _labelOwner.textColor = DSBlackColor;
        _labelOwner.font = [UIFont systemFontOfSize:14];
        _labelOwner.text = @"获奖者：屌丝是怎么炼成的";
    }
    return _labelOwner;
}

- (UILabel *)openTime {
    if (_openTime == nil) {
        _openTime = [[UILabel alloc] init];
        _openTime.numberOfLines = 0;
        _openTime.lineBreakMode = NSLineBreakByCharWrapping;
        _openTime.textAlignment = NSTextAlignmentLeft;
        _openTime.textColor = DSBlackColor;
        _openTime.font = [UIFont systemFontOfSize:14];
        _openTime.text = @"揭晓时间：2016-4-18 20：49";
    }
    return _openTime;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.imageIcon.frame = CGRectMake(10, 10, 60, 60);
    self.labelTitle.frame = CGRectMake(self.imageIcon.ctRight + 8, 10, SCREENWIDTH - 90, 20);
    self.labelOwner.frame = CGRectMake(self.imageIcon.ctRight + 8, self.labelTitle.ctBottom, SCREENWIDTH - 90, 20);
    self.openTime.frame = CGRectMake(self.imageIcon.ctRight + 8, self.labelOwner.ctBottom, SCREENWIDTH - 90, 20);
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelOwner];
    [self.contentView addSubview:self.openTime];
}

- (void)configCellWithData:(id) celldata{
    if ([celldata isKindOfClass:[UserBuyHistoryListModel class]]) {
        UserBuyHistoryListModel *buyModel = (UserBuyHistoryListModel *)celldata;
        [self.imageIcon setImageWithURL:[NSURL URLWithString:buyModel.userIcon] placeholderImage:[UIImage imageNamed:@"noimage"]];
        self.labelTitle.text = buyModel.name;
        self.labelOwner.text = buyModel.ownerName;
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss:sss"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(long)buyModel.time];
        NSString *dateString = [formater stringFromDate:date];
        self.openTime.text = dateString;
    }
    
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
