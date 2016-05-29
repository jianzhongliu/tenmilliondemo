//
//  ProgressView.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/24.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "ProgressView.h"
#import "UIView+CTExtensions.h"
#import "DSConfig.h"

@interface ProgressView ()

@property (nonatomic, strong) UIView *viewBg;
@property (nonatomic, strong) UIView *viewRate;
@property (nonatomic, strong) UILabel *labeRate;


@end

@implementation ProgressView

- (UIView *)viewBg {
    if (_viewBg == nil) {
        _viewBg = [[UIView alloc] init];
        _viewBg.backgroundColor = DSColorAlphaFromHex(0xe36062, 0.4);
    }
    return _viewBg  ;
}

- (UIView *)viewRate {
    if (_viewRate == nil) {
        _viewRate = [[UIView alloc] init];
        _viewRate.backgroundColor = DSRedColor;
    }
    return _viewRate;
}

- (UILabel *)labeRate {
    if (_labeRate == nil) {
        _labeRate = [[UILabel alloc] init];
        _labeRate.numberOfLines = 0;
        _labeRate.lineBreakMode = NSLineBreakByCharWrapping;
        _labeRate.textAlignment = NSTextAlignmentLeft;
        _labeRate.textColor = [UIColor whiteColor];
        _labeRate.font = [UIFont systemFontOfSize:8];
        _labeRate.text = @"";
    }
    return _labeRate;
}

#pragma mark - lifeCycleMethods
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.viewBg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.viewBg.layer.cornerRadius = self.frame.size.height/2.0f;
    self.viewBg.layer.borderColor = DSRedColor.CGColor;
    self.viewBg.layer.borderWidth = 1;
    self.viewRate.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    self.viewRate.layer.cornerRadius = self.frame.size.height/2.0f;
    self.labeRate.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
    [self addSubview:self.viewBg];
    [self addSubview:self.viewRate];
    [self addSubview:self.labeRate];
}

- (void)setProgress:(CGFloat) rate {
    self.viewRate.frame = CGRectMake(0, 0, self.frame.size.width * rate, self.frame.size.height);
    self.labeRate.text = [NSString stringWithFormat:@" %.f%@",rate*100,@"%"];
}

@end
