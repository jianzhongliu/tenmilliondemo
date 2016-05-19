//
//  FoundsHistoryOwnerListModel.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "DSBaseModel.h"
#import "FoundsDetailModel.h"

@interface FoundsHistoryOwnerListModel : DSBaseModel

@property (nonatomic, strong) FoundsHistoryOwnerInfoModel *historyFoundsInfo;
@property (nonatomic, strong) UserBaseInfoModel *userInfoModel;

- (void)configFoundsDetailModelWithDic:(NSDictionary *) dic;

@end
