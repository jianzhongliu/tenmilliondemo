//
//  AgentInfoModel.m
//  3laz
//
//  Created by liujianzhong on 16/1/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "AgentInfoModel.h"

@implementation AgentInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"contactId" : @"id",
             @"easemobUsername" : @"easemob_username",
             @"logo" : @"logo",
             @"mobile" : @"mobile",
             @"realName" : @"real_name",
             @"workYearsLabel":@"work_years_label"
             };
}

@end
