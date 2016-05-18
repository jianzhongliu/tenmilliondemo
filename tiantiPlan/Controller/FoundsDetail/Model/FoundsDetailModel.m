//
//  FoundsDetailModel.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsDetailModel.h"

@implementation FoundsDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ };
}

- (void)configFoundsDetailModelWithDic:(NSDictionary *) dic {
    if (dic == nil) {
        return;
    }
    NSError *error;
    self.foundsDetailInfoModel = [MTLJSONAdapter modelOfClass:FoundsDetailInfoModel.class fromJSONDictionary:dic[@"foundsDetail"] error:&error];

    self.foundsHistoryInfoModel = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dic[@"historyOwner"] error:&error];
    
    self.userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:dic[@"userInfo"] error:&error];
}

@end

@implementation FoundsDetailInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identify":@"identify",
             @"images":@"images",
             @"isover":@"isover",
             @"lastid":@"lastid",
             @"name":@"name",
             @"nown":@"nown",
             @"overtime":@"overtime",
             @"ownerid":@"ownerid",
             @"resulttime":@"resulttime",
             @"totaln":@"totaln",
             @"type":@"type"
             };
}

@end

@implementation FoundsHistoryOwnerInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identify":@"identify",
             @"foundsId":@"foundsId",
             @"images":@"images",
             @"isover":@"isover",
             @"lastid":@"lastid",
             @"name":@"name",
             @"nown":@"nown",
             @"overtime":@"overtime",
             @"ownerBuyNumber":@"ownerBuyNumber",
             @"ownerid":@"ownerid",
             @"resulttime":@"resulttime",
             @"timeidentify":@"timeidentify",
             @"totaln":@"totaln",
             @"type":@"type"
             };
}

@end