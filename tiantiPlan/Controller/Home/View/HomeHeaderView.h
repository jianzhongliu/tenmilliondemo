//
//  HomeHeaderView.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/24.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@class HomeHeaderView;
@protocol HomeHeaderViewDelegate <NSObject>

- (void)homeHeaderViewCell:(HomeHeaderView *) cell atIndex:(NSInteger) index;
- (void)homeHeaderViewCell:(HomeHeaderView *) cell didSelectADatIndex:(NSInteger) index;

@end

@interface HomeHeaderView : UIView

@property (nonatomic, assign) id<HomeHeaderViewDelegate> delegate;

- (void)configViewWithData:(id) data;

- (void)configAD:(NSArray *) array;
- (CGFloat)fetchViewHeight;

@end
