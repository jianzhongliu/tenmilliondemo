//
//  FoundsProgressCardCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsProgressCardCell.h"

@interface FoundsProgressCardCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *labelCurrentNumber;
@property (nonatomic, strong) UILabel *labelCurrentTitle;
@property (nonatomic, strong) UILabel *labelTotalNumber;
@property (nonatomic, strong) UILabel *labelTotalTitle;
@property (nonatomic, strong) UILabel *labelLackNumber;
@property (nonatomic, strong) UILabel *labelLackTitle;

@end

@implementation FoundsProgressCardCell
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:@"noimage"];
    }
    return _imageView;
}

- (UILabel *)labelPrice {
    if (_labelPrice == nil) {
        _labelPrice = [[UILabel alloc] init];
        _labelPrice.numberOfLines = 0;
        _labelPrice.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPrice.textAlignment = NSTextAlignmentCenter;
        _labelPrice.textColor = DSBlackColor;
        _labelPrice.font = [UIFont systemFontOfSize:14];
        _labelPrice.text = @"";
    }
    return _labelPrice;
}

- (UIProgressView *)progress {
    if (_progress == nil) {
        _progress = [[UIProgressView alloc] init];
        _progress.tintColor = DSColor;
        [_progress setProgress:0.6];
    }
    return _progress;
}

- (UILabel *)labelCurrentNumber {
    if (_labelCurrentNumber == nil) {
        _labelCurrentNumber = [[UILabel alloc] init];
        _labelCurrentNumber.numberOfLines = 0;
        _labelCurrentNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelCurrentNumber.textAlignment = NSTextAlignmentCenter;
        _labelCurrentNumber.textColor = DSBlackColor;
        _labelCurrentNumber.font = [UIFont systemFontOfSize:14];
        _labelCurrentNumber.text = @"124";
    }
    return _labelCurrentNumber;
}

- (UILabel *)labelCurrentTitle {
    if (_labelCurrentTitle == nil) {
        _labelCurrentTitle = [[UILabel alloc] init];
        _labelCurrentTitle.numberOfLines = 0;
        _labelCurrentTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelCurrentTitle.textAlignment = NSTextAlignmentCenter;
        _labelCurrentTitle.textColor = DSBlackColor;
        _labelCurrentTitle.font = [UIFont systemFontOfSize:14];
        _labelCurrentTitle.text = @"以参与";
    }
    return _labelCurrentTitle;
}

- (UILabel *)labelTotalNumber {
    if (_labelTotalNumber == nil) {
        _labelTotalNumber = [[UILabel alloc] init];
        _labelTotalNumber.numberOfLines = 0;
        _labelTotalNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTotalNumber.textAlignment = NSTextAlignmentCenter;
        _labelTotalNumber.textColor = DSBlackColor;
        _labelTotalNumber.font = [UIFont systemFontOfSize:14];
        _labelTotalNumber.text = @"44";
    }
    return _labelTotalNumber;
}

- (UILabel *)labelTotalTitle {
    if (_labelTotalTitle == nil) {
        _labelTotalTitle = [[UILabel alloc] init];
        _labelTotalTitle.numberOfLines = 0;
        _labelTotalTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTotalTitle.textAlignment = NSTextAlignmentCenter;
        _labelTotalTitle.textColor = DSBlackColor;
        _labelTotalTitle.font = [UIFont systemFontOfSize:14];
        _labelTotalTitle.text = @"总需人次";
    }
    return _labelTotalTitle;
}

- (UILabel *)labelLackNumber {
    if (_labelLackNumber == nil) {
        _labelLackNumber = [[UILabel alloc] init];
        _labelLackNumber.numberOfLines = 0;
        _labelLackNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelLackNumber.textAlignment = NSTextAlignmentCenter;
        _labelLackNumber.textColor = DSBlackColor;
        _labelLackNumber.font = [UIFont systemFontOfSize:14];
        _labelLackNumber.text = @"55";
    }
    return _labelLackNumber;
}

- (UILabel *)labelLackTitle {
    if (_labelLackTitle == nil) {
        _labelLackTitle = [[UILabel alloc] init];
        _labelLackTitle.numberOfLines = 0;
        _labelLackTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelLackTitle.textAlignment = NSTextAlignmentCenter;
        _labelLackTitle.textColor = DSBlackColor;
        _labelLackTitle.font = [UIFont systemFontOfSize:14];
        _labelLackTitle.text = @"剩余";
    }
    return _labelLackTitle;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageView.frame = CGRectMake(10, 10, 100, 100);
    self.labelPrice.frame = CGRectMake(0, self.imageView.ctBottom + 10, 120, 20);
    self.progress.frame = CGRectMake(5, self.labelPrice.ctBottom + 5, 110, 15);
    self.labelCurrentNumber.frame = CGRectMake(5, self.progress.ctBottom, 40, 15);
    self.labelCurrentTitle.frame = CGRectMake(5, self.labelCurrentNumber.ctBottom, 40, 15);
    self.labelTotalNumber.frame = CGRectMake(40, self.progress.ctBottom, 40, 15);
    self.labelTotalTitle.frame = CGRectMake(40, self.labelTotalNumber.ctBottom, 40, 15);
    self.labelLackNumber.frame = CGRectMake(80, self.progress.ctBottom, 40, 15);
    self.labelLackTitle.frame = CGRectMake(80, self.labelLackNumber.ctBottom, 40, 15);
    
    [self addSubview:self.imageView];
    [self addSubview:self.labelPrice];
    [self addSubview:self.progress];
    [self addSubview:self.labelCurrentNumber];
    [self addSubview:self.labelCurrentTitle];
    [self addSubview:self.labelTotalNumber];
    [self addSubview:self.labelTotalTitle];
    [self addSubview:self.labelLackNumber];
    [self addSubview:self.labelLackTitle];
}

- (void)configViewWithData:(id) data {
    
}

- (CGFloat)fetchViewHeight {
    return 0;
}


@end
