//
//  HistoryOwnerInfoViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsHistoryOwnerListCell.h"
#import "FoundsHistoryOwnerListModel.h"
#import "UIImageView+AFNetworking.h"

@interface FoundsHistoryOwnerListCell ()

@property (nonatomic, strong) UIView *viewBackground;
@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelNumber;
@property (nonatomic, strong) UILabel *labelTime;

@property (nonatomic, strong) UIImageView *imageOwnerTag;
@property (nonatomic, strong) UIImageView *imageStatus;

@property (nonatomic, strong) UIView *viewBG;

@property (nonatomic, strong) UILabel *labelOwner;
@property (nonatomic, strong) UILabel *labelTimeId;

@property (nonatomic, strong) UIButton *buttonResult;

@end

@implementation FoundsHistoryOwnerListCell

- (UIView *)viewBackground {
    if (_viewBackground == nil) {
        _viewBackground = [[UIView alloc] init];
        _viewBackground.backgroundColor = [UIColor whiteColor];
    }
    return _viewBackground;
}

- (UIImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
        _imageIcon.image = [UIImage imageNamed:@"userhead"];
    }
    return _imageIcon;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.textColor = DSBlackColor;
        _labelName.font = [UIFont systemFontOfSize:14];
        _labelName.text = @"";
    }
    return _labelName;
}

- (UILabel *)labelNumber {
    if (_labelNumber == nil) {
        _labelNumber = [[UILabel alloc] init];
        _labelNumber.numberOfLines = 0;
        _labelNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelNumber.textAlignment = NSTextAlignmentLeft;
        _labelNumber.textColor = DSBlackColor;
        _labelNumber.font = [UIFont systemFontOfSize:14];
        _labelNumber.text = @"";
    }
    return _labelNumber;
}

- (UILabel *)labelTime {
    if (_labelTime == nil) {
        _labelTime = [[UILabel alloc] init];
        _labelTime.numberOfLines = 0;
        _labelTime.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTime.textAlignment = NSTextAlignmentLeft;
        _labelTime.textColor = DSBlackColor;
        _labelTime.font = [UIFont systemFontOfSize:14];
        _labelTime.text = @"";
    }
    return _labelTime;
}

- (UIImageView *)imageOwnerTag {
    if (_imageOwnerTag == nil) {
        _imageOwnerTag = [[UIImageView alloc] init];
        _imageOwnerTag.clipsToBounds = YES;
        _imageOwnerTag.userInteractionEnabled = YES;
        _imageOwnerTag.image = [UIImage imageNamed:@"zhongjiang"];
    }
    return _imageOwnerTag;
}

- (UIImageView *)imageStatus {
    if (_imageStatus == nil) {
        _imageStatus = [[UIImageView alloc] init];
        _imageStatus.clipsToBounds = YES;
        _imageStatus.userInteractionEnabled = YES;
        _imageStatus.image = [UIImage imageNamed:@"beforewiner"];
    }
    return _imageStatus;
}

- (UIView *)viewBG {
    if (_viewBG == nil) {
        _viewBG = [[UIView alloc] init];
        _viewBG.backgroundColor = DSColorAlphaFromHex(0xe36062, 0.5);
    }
    return _viewBG;
}

- (UILabel *)labelOwner {
    if (_labelOwner == nil) {
        _labelOwner = [[UILabel alloc] init];
        _labelOwner.numberOfLines = 0;
        _labelOwner.lineBreakMode = NSLineBreakByCharWrapping;
        _labelOwner.textAlignment = NSTextAlignmentLeft;
        _labelOwner.textColor = [UIColor whiteColor];
        _labelOwner.font = [UIFont boldSystemFontOfSize:13];
        _labelOwner.text = @"";
    }
    return _labelOwner;
}

- (UILabel *)labelTimeId {
    if (_labelTimeId == nil) {
        _labelTimeId = [[UILabel alloc] init];
        _labelTimeId.numberOfLines = 0;
        _labelTimeId.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTimeId.textAlignment = NSTextAlignmentRight;
        _labelTimeId.textColor = [UIColor whiteColor];
        _labelTimeId.font = [UIFont systemFontOfSize:14];
        _labelTimeId.text = @"";
    }
    return _labelTimeId;
}

- (UIButton *)buttonResult {
    if (_buttonResult == nil) {
        _buttonResult = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonResult addTarget:self action:@selector(onClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonResult.selected = NO;
        _buttonResult.backgroundColor = [UIColor whiteColor];
        [_buttonResult setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _buttonResult.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [_buttonResult setTitle:@"查看计算详情" forState:UIControlStateNormal];
        _buttonResult.layer.cornerRadius = 6;
        _buttonResult.clipsToBounds = YES;
        _buttonResult.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonResult;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = DSBackColor;
    self.viewBackground.frame = CGRectMake(0, 0, SCREENWIDTH, 105);
    self.imageIcon.frame = CGRectMake(10, 10, 60, 60);
    self.imageOwnerTag.frame = CGRectMake(0, 0, 30, 30);
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 6, 10, SCREENWIDTH - 85, 20);
    self.labelNumber.frame = CGRectMake(self.imageIcon.ctRight + 6, self.labelName.ctBottom , SCREENWIDTH - 85, 20);
    self.labelTime.frame = CGRectMake(self.imageIcon.ctRight + 6, self.labelNumber.ctBottom, SCREENWIDTH - 85, 20);
    self.imageStatus.frame = CGRectMake(SCREENWIDTH - 30, 0, 21, 53);
    
    self.viewBG.frame = CGRectMake(0, self.imageIcon.ctBottom + 10, SCREENWIDTH, 25);
    self.labelOwner.frame = CGRectMake(10, 0, SCREENWIDTH, 25);
    self.labelTimeId.frame = CGRectMake(0, 0, SCREENWIDTH - 10, 25);
    self.buttonResult.frame = CGRectMake(SCREENWIDTH - 90, 10, 80, 30);
    [self.viewBG addSubview:self.labelOwner];
    [self.viewBG addSubview:self.labelTimeId];
    [self.contentView addSubview:self.viewBackground];
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.imageOwnerTag];
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelNumber];
    [self.contentView addSubview:self.labelTime];
    [self.contentView addSubview:self.imageStatus];
    [self.contentView addSubview:self.viewBG];
    
}

- (void)onClickButtonAction:(UIButton *) button {
//    if (_delegate && [_delegate respondsToSelector:@selector(didViewResultDetail)]) {
//        [_delegate didViewResultDetail];
//    }
}

- (void)configCellWithData:(id) celldata{
    if ([celldata isKindOfClass:[FoundsHistoryOwnerInfoModel class]]) {
        FoundsHistoryOwnerInfoModel *history = (FoundsHistoryOwnerInfoModel *) celldata;
        [self.imageIcon setImageWithURL:[NSURL URLWithString:history.userIcon] placeholderImage:[UIImage imageNamed:@"userhead"]];
        self.labelName.text = [NSString stringWithFormat:@"获奖者：%@", history.userName == nil?@"1391624135":history.userName];
        self.labelNumber.text = [NSString stringWithFormat:@"参与次数：%@", history.ownerBuyNumber];
//        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss:sss"];
//        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:(long)history.resulttime];
//        NSString *dateString = [formater stringFromDate:date];
        self.labelTime.text = [NSString stringWithFormat:@"揭晓时间：%@", history.resulttime];
        self.labelOwner.text = [NSString stringWithFormat:@"幸运号码：%@",history.resultnumber];
        self.labelTimeId.text = [NSString stringWithFormat:@"期号：%@", history.lastid];
    }
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
