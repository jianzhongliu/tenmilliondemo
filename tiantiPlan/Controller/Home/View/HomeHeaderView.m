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
#import "FoundsModel.h"

@interface HomeHeaderView () <JXBAdPageViewDelegate, HomeFirstViewCellDelegate>

@property (nonatomic, strong) JXBAdPageView *viewAD;
@property (nonatomic, strong) HomeFirstViewCell *viewFirst;

@end

@implementation HomeHeaderView

- (HomeFirstViewCell *)viewFirst {
    if (_viewFirst == nil) {
        _viewFirst = [[HomeFirstViewCell alloc] init];
        _viewFirst.delegate = self;
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
    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, ImageHight);
    self.viewFirst.frame = CGRectMake(0, self.viewAD.ctBottom, SCREENWIDTH, 210);
    [self addSubview:self.viewAD];
    [self addSubview:self.viewFirst];
}

- (void)configViewWithData:(id) data {
    if ([data isKindOfClass:[NSArray class]]) {
        [self.viewFirst configCellWithData:data];
    }
}

- (void)configAD:(NSArray *) array {
    NSMutableArray *arrayAD = [NSMutableArray array];
    for (FoundsModel *founds in array) {
        NSArray *arrayImage = [founds.images componentsSeparatedByString:@"|"];
        [arrayAD addObject:arrayImage[0]];
    }
    
    [self.viewAD startAdsWithBlock:arrayAD block:^(NSInteger clickIndex){
        if (_delegate && [_delegate respondsToSelector:@selector(homeHeaderViewCell:didSelectADatIndex:)]) {
            [_delegate homeHeaderViewCell:self didSelectADatIndex:clickIndex];
        }
    }];
}

- (CGFloat)fetchViewHeight {
    return ImageHight + 225;
}

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger ) index {
    if (self == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://img.1yyg.com/Poster/20140918182340689.jpg"];
    [imgView sd_setImageWithURL:url];
}

- (void)homeFirstViewCell:(HomeFirstViewCell *) cell clickData:(id) clickData atIndex:(NSInteger) index {
    if (_delegate && [_delegate respondsToSelector:@selector(homeHeaderViewCell:atIndex:)]) {
        [_delegate homeHeaderViewCell:self atIndex:index];
    }
}

@end
