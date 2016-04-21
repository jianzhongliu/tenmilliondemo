//
//  HistoryOwnerInfoViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HistoryOwnerInfoViewCell.h"

@interface HistoryOwnerInfoViewCell ()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelNumber;
@property (nonatomic, strong) UILabel *labelTime;

@property (nonatomic, strong) UIImageView *imageOwnerTag;
@property (nonatomic, strong) UIImageView *imageStatus;

@property (nonatomic, strong) UIView *viewBG;
@end

@implementation HistoryOwnerInfoViewCell
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
        _labelName.text = @"获奖账户：风花雪月";
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
        _labelNumber.text = @"本期参与：304次";
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
        _labelTime.text = @"揭晓时间：2016-04-21 03:37:33:192";
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
        _viewBG.backgroundColor = [UIColor redColor];
    }
    return _viewBG;
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
    self.imageOwnerTag.frame = CGRectMake(0, 0, 30, 30);
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 6, 10, SCREENWIDTH - 85, 20);
    self.labelNumber.frame = CGRectMake(self.imageIcon.ctRight + 6, self.labelName.ctBottom , SCREENWIDTH - 85, 20);
    self.labelTime.frame = CGRectMake(self.imageIcon.ctRight + 6, self.labelNumber.ctBottom, SCREENWIDTH - 85, 20);
    self.imageStatus.frame = CGRectMake(SCREENWIDTH - 30, 0, 21, 53);
    
    self.viewBG.frame = CGRectMake(0, self.imageIcon.ctBottom + 10, SCREENWIDTH, 50);
    
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.imageOwnerTag];
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelNumber];
    [self.contentView addSubview:self.labelTime];
    [self.contentView addSubview:self.imageStatus];
    [self.contentView addSubview:self.viewBG];
    
}

- (void)configCellWithData:(id) celldata{
    
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
