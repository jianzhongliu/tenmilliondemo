//
//  HomeSecondViewCell.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
@class HomeSecondViewCell;

@protocol HomeSecondViewCellDelegate <NSObject>

- (void)homeSecondViewCell:(HomeSecondViewCell *) cell clickData:(id) clickData;

@end

@interface HomeSecondViewCell : BaseViewCell
@property (nonatomic, assign) id<HomeSecondViewCellDelegate> delegate;
- (void)configCellWithData:(id) celldata;

@end
