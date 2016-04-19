//
//  FoundsTypeCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsTypeCell.h"

@interface FoundsTypeCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FoundsTypeCell
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"手机1元";
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
        _labelTime.text = @"iPhone,小米";
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
    self.imageView.frame = CGRectMake(SCREENWIDTH/2 - 70, (90-60)/2, 60, 60);
    self.labelTitle.frame = CGRectMake(10, 15, SCREENWIDTH/2 - 80, 30);
    self.labelTime.frame = CGRectMake(10, self.labelTitle.ctBottom, SCREENWIDTH/2 - 80, 20);
    [self addSubview:self.imageView];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelTime];
}

- (void)configViewWithData:(id) data {
    
}

- (CGFloat)fetchViewHeight {
    return 0;
}

@end
