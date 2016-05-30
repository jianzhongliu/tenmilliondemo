//
//  HomeHeaderView.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/24.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeHeaderView.h"
#import "JXBAdPageView.h"
#import "HomeFirstViewCell.h"
#import "UIImageView+WebCache.h"
#import "DSConfig.h"

@interface HomeHeaderView () <JXBAdPageViewDelegate>

@property (nonatomic, strong) JXBAdPageView *viewAD;
@property (nonatomic, strong) HomeFirstViewCell *viewFirst;

@end

@implementation HomeHeaderView

- (HomeFirstViewCell *)viewFirst {
    if (_viewFirst == nil) {
        _viewFirst = [[HomeFirstViewCell alloc] init];
    }
    return _viewFirst;
}

- (JXBAdPageView *)viewAD {
    if (_viewAD == nil) {
        _viewAD = [[JXBAdPageView alloc] init];
        _viewAD.delegate = self;
        _viewAD.iDisplayTime = 5;
        _viewAD.bWebImage = YES;
    }
    return _viewAD;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)dealloc {
    self.viewAD.delegate = nil;
}

- (void)initUI {
    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    self.viewFirst.frame = CGRectMake(0, self.viewAD.ctBottom, SCREENWIDTH, 210);
    [self addSubview:self.viewAD];
    [self addSubview:self.viewFirst];
    [self.viewAD startAdsWithBlock:@[@"www", @"www"] block:^(NSInteger clickIndex){
        //        if (arrayData.count > clickIndex) {
        //            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedADitem:)]) {
        //                [_delegate didSelectedADitem:data[clickIndex]];
        //            }
        //        }
    }];
}

- (void)configViewWithData:(id) data {
    if ([data isKindOfClass:[HomeModel class]]) {
        HomeModel *homeModel = (HomeModel *)data;
        [self.viewFirst configCellWithData:homeModel.arrayOver];
    }
}

- (CGFloat)fetchViewHeight {
    return 360;
}

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger ) index {
    if (self == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://img.1yyg.com/Poster/20140918182340689.jpg"];
    [imgView sd_setImageWithURL:url];
}

@end
