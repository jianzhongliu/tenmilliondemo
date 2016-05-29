//
//  FoundsCarViewCell.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/22.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewCell.h"
#import "FoundsModel.h"

@class FoundsCarViewCell;

@protocol FoundsCarViewCellDelegate <NSObject>

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell didDelete:(FoundsModel *) foundsDetail;

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell doAddNumber:(FoundsModel *) foundsDetail;

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell doDeleteNumber:(FoundsModel *) foundsDetail;

@end

@interface FoundsCarViewCell : BaseViewCell
@property (nonatomic, assign) id<FoundsCarViewCellDelegate> delegate;
- (void)configCellWithData:(FoundsModel *) celldata;

@end
