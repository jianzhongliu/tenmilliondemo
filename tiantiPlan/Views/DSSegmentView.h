//
//  DSSegmentView.h
//  DianSongBDTool
//
//  Created by liujianzhong on 15/7/31.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//
/**
 [self.segmentView setTitles:@[@"待抢单",@"已完成",@"已取消"] Frame:CGRectMake(0, 0, SCREENWIDTH, 44)];
 [self.segmentView setSelectedIndex:0];
 [self.view addSubview:self.segmentView];
 */

#import <UIKit/UIKit.h>
#import "BaseViewCell.h"

@protocol DSSegmentViewDelegate <NSObject>

- (void)didSelectedSegmentAtIndex:(NSInteger) index;

@end

@interface DSSegmentView : UIView

@property (nonatomic, assign) id<DSSegmentViewDelegate> delegate;

- (void)reloadTitle:(NSArray *)array;

- (void)setTitles:(NSArray *) array Frame:(CGRect) frame;

- (void)setSelectedIndex:(NSInteger ) index;

- (NSInteger)currentIndex;

@end
