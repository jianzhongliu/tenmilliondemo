//
//  DSSegmentView.m
//  DianSongBDTool
//
//  Created by liujianzhong on 15/7/31.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "DSSegmentView.h"

@interface DSSegmentView ()

@property (nonatomic, strong) UIView *viewIndicator;

@property (nonatomic, strong) UIView *viewBottomLine;
@property (nonatomic, strong) UIView *viewTopLine;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation DSSegmentView

- (UIView *)viewIndicator {
    if (_viewIndicator == nil) {
        _viewIndicator = [[UIView alloc] init];
        _viewIndicator.backgroundColor = DSColor;
    }
    return _viewIndicator;
}

- (UIView *)viewBottomLine {
    if (_viewBottomLine == nil) {
        _viewBottomLine  = [[UIView alloc] init];
        _viewBottomLine.backgroundColor = DSColorFromHex(0xebebeb);
    }
    return _viewBottomLine;
}

- (UIView *)viewTopLine {
    if (_viewTopLine == nil) {
        _viewTopLine = [[UIView alloc] init];
        _viewTopLine.backgroundColor = DSColorFromHex(0xebebeb);
    }
    return _viewTopLine;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
        self.currentSelectedIndex = 0;
    }
    return self;
}

- (void)initUI {

}

- (void)setTitles:(NSArray *) array Frame:(CGRect) frame {
    self.frame = frame;
    NSArray *arrayView = [self subviews];
    for (UIView *view in arrayView) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
   CGFloat segmentWidth = frame.size.width / (CGFloat)array.count;
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setBackgroundColor:self.backgroundColor];
        [button setTitleColor:DSGrayColor3 forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:DSColor forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(didClickSegment:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*segmentWidth, 0, segmentWidth, 40);
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(button.ctRight - 1, 10, 1, 20)];
        viewLine.backgroundColor = DSColorFromHex(0xebebeb);
        [self addSubview:button];
        [self addSubview:viewLine];
    }
    self.viewTopLine.frame = CGRectMake(0, 1, SCREENWIDTH, 1);
    self.viewIndicator.frame = CGRectMake(0, 38, SCREENWIDTH / array.count - 30, 1.5);
    self.viewBottomLine.frame = CGRectMake(0, self.viewIndicator.ctBottom, SCREENWIDTH, 1);
//    [self addSubview:self.viewTopLine];
    [self addSubview:self.viewBottomLine];
    [self addSubview:self.viewIndicator];
}

- (void)reloadTitle:(NSArray *)array {
    for (int index = 0; index < array.count; index ++) {
        NSArray *arrayView = [self subviews];
        for (UIView *view in arrayView) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (index + 100 == view.tag) {
                    [button setTitle:array[index] forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)setSelectedIndex:(NSInteger ) index {
    [self didClickSegment:(UIButton *)[self viewWithTag:index + 100]];
    self.currentSelectedIndex = index;
}

- (void)didClickSegment:(UIButton *) sender {
    NSArray *arrayButton  = [self subviews];
    for (int index = 0; index < arrayButton.count; index ++ ) {
        if ([arrayButton[index] isKindOfClass:[UIButton class]]) {
            UIButton *buttonCurrent = (UIButton *)arrayButton[index];
            [buttonCurrent setTitleColor:DSGrayColor3 forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewIndicator.center = CGPointMake(sender.center.x, self.viewIndicator.center.y);
    } completion:^(BOOL finished) {
        
    }];
    [sender setTitleColor:DSColor forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedSegmentAtIndex:)]) {
        [_delegate didSelectedSegmentAtIndex:sender.tag - 100];
        self.currentSelectedIndex = sender.tag - 100;
    }
}

- (void)configViewWithData:(id) data {
    
}

- (CGFloat)fetchViewHeight {
    return 0;
}

- (NSInteger)currentIndex {
    return self.currentSelectedIndex;
}

@end
