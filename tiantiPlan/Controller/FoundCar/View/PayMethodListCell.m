//
//  PayMethodListCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/20.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "PayMethodListCell.h"

@interface PayMethodListCell ()

@property (nonatomic, strong) UIImageView *imageSelction;
@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelTitle;

@end

@implementation PayMethodListCell

- (UIImageView *)imageSelction {
    if (_imageSelction == nil) {
        _imageSelction = [[UIImageView alloc] init];
        _imageSelction.clipsToBounds = YES;
        _imageSelction.userInteractionEnabled = YES;
        _imageSelction.image = [UIImage imageNamed:@"icon_radio"];
    }
    return _imageSelction;
}

- (UIImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
        _imageIcon.image = [UIImage imageNamed:@"icon_weichat"];
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
        _labelTitle.text = @"微信支付";
    }
    return _labelTitle;
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
    self.imageSelction.frame = CGRectMake(15, 15, 20, 20);
    self.imageIcon.frame = CGRectMake(self.imageSelction.ctRight + 10, 10, 40, 30);
    self.labelTitle.frame = CGRectMake(self.imageIcon.ctRight + 10, 0, SCREENWIDTH, 50);
    [self.contentView addSubview:self.imageSelction];
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.labelTitle];
}

- (void)configCellWithData:(id) celldata{
    
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
