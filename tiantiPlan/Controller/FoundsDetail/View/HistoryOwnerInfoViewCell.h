//
//  HistoryOwnerInfoViewCell.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewCell.h"
@class HistoryOwnerInfoViewCell;
@protocol HistoryOwnerInfoViewCellDelegate <NSObject>

- (void)didViewResultDetail;

@end
@interface HistoryOwnerInfoViewCell : BaseViewCell

@property (nonatomic, assign) id<HistoryOwnerInfoViewCellDelegate> delegate;

- (void)configCellWithData:(id) celldata;

@end
