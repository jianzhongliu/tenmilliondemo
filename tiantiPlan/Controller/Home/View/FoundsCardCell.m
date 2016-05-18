//
//  FoundsCardCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsCardCell.h"
#import "FoundsModel.h"
#import "UIImageView+AFNetworking.h"

@interface FoundsCardCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FoundsCardCell
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"苹果(iPhone 6) 64g";
    }
    return _labelTitle;
}

- (UILabel *)labelTime {
    if (_labelTime == nil) {
        _labelTime = [[UILabel alloc] init];
        _labelTime.numberOfLines = 0;
        _labelTime.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTime.textAlignment = NSTextAlignmentLeft;
        _labelTime.textColor = DSRedColor;
        _labelTime.font = [UIFont systemFontOfSize:14];
        _labelTime.text = @"02:34:35";
    }
    return _labelTime;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:@"noimage"];
    }
    return _imageView;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageView.frame = CGRectMake(10, (90-60)/2, 60, 60);
    self.labelTitle.frame = CGRectMake(self.imageView.ctRight+6, 15, SCREENWIDTH/2 - 10-50-6-15, 30);
    self.labelTime.frame = CGRectMake(self.imageView.ctRight+6, self.labelTitle.ctBottom, 80, 20);
    [self addSubview:self.imageView];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelTime];
}

- (void)configViewWithData:(id) data {
    if ([data isKindOfClass:[FoundsModel class]]) {
        FoundsModel *founds = (FoundsModel *)data;
        NSArray *images = [founds.images componentsSeparatedByString:@"|"];
        [self.imageView setImageWithURL:[NSURL URLWithString:images[0]] placeholderImage:[UIImage imageNamed:@"noimage"]];
        self.labelTitle.text = founds.name;
        self.labelTime.text = [NSString stringWithFormat:@"剩余：%ld 份", [founds.totaln integerValue] - [founds.nown integerValue]];
    }
}

- (CGFloat)fetchViewHeight {
    return 0;
}

@end
