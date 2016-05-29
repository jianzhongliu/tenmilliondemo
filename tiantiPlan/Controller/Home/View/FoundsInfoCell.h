//
//  HomeHotOfficeViewCell.h
//  3laz
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewCell.h"
#import "FoundsModel.h"
@class FoundsInfoCell;
@protocol FoundsInfoCellDelegate <NSObject>

- (void)foundsInfoCell:(FoundsInfoCell *)foundsCell;

@end

@interface FoundsInfoCell : BaseViewCell
@property (nonatomic, strong) UIImageView *imageOffice;
@property (nonatomic, strong) FoundsModel *foundsData;
@property (nonatomic, strong) UIButton *buttonAdd;
@property (nonatomic, assign) id<FoundsInfoCellDelegate> delegate;
- (void)configCellWithData:(FoundsModel *) foundsModel;
- (CGFloat)fetchCellHight;

@end
