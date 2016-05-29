//
//  HomeFirstViewCell.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"

@class HomeFirstViewCell;

@protocol HomeFirstViewCellDelegate <NSObject>

- (void)homeFirstViewCell:(HomeFirstViewCell *) cell clickData:(id) clickData;

@end

@interface HomeFirstViewCell : UIView

@property (nonatomic, assign) id<HomeFirstViewCellDelegate> delegate;
- (void)configCellWithData:(id) celldata;

@end
