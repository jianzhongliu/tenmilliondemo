//
//  FoundsHistoryOwnerListModel.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsHistoryOwnerListModel.h"

@implementation FoundsHistoryOwnerListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ };
}

- (void)configFoundsDetailModelWithDic:(NSDictionary *) dic {
    if (dic == nil) {
        return;
    }
    NSError *error;
    self.historyFoundsInfo = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dic[@"historyOwnerFounds"] error:&error];
    
    self.userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:dic[@"historyOwnerUser"] error:&error];
}

@end
