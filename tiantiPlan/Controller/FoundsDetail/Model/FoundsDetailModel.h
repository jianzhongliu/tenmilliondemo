//
//  FoundsDetailModel.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "DSBaseModel.h"
#import "UserBaseInfoModel.h"
@class FoundsDetailInfoModel;
@class FoundsHistoryOwnerInfoModel;

@interface FoundsDetailModel : DSBaseModel

@property (nonatomic, strong) UserBaseInfoModel *userInfoModel;
@property (nonatomic, strong) FoundsDetailInfoModel *foundsDetailInfoModel;
@property (nonatomic, strong) FoundsHistoryOwnerInfoModel *foundsHistoryInfoModel;

- (void)configFoundsDetailModelWithDic:(NSDictionary *) dic;

@end

@interface FoundsDetailInfoModel : DSBaseModel

@property (nonatomic, strong) NSString *identify;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *isover;
@property (nonatomic, strong) NSString *lastid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nown;
@property (nonatomic, strong) NSString *overtime;
@property (nonatomic, strong) NSString *ownerid;
@property (nonatomic, strong) NSString *resulttime;
@property (nonatomic, strong) NSString *totaln;
@property (nonatomic, strong) NSString *type;

@end

@interface FoundsHistoryOwnerInfoModel : DSBaseModel

@property (nonatomic, strong) NSString *identify;
@property (nonatomic, strong) NSString *foundsId;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *isover;
@property (nonatomic, strong) NSString *lastid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nown;
@property (nonatomic, strong) NSString *overtime;
@property (nonatomic, strong) NSString *ownerBuyNumber;
@property (nonatomic, strong) NSString *ownerid;
@property (nonatomic, strong) NSString *resulttime;
@property (nonatomic, strong) NSString *timeidentify;
@property (nonatomic, strong) NSString *totaln;
@property (nonatomic, strong) NSString *type;

@end
