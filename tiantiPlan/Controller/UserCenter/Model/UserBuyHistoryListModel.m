//
//  UserBuyHistoryListModel.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserBuyHistoryListModel.h"

@implementation UserBuyHistoryListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identify":@"identify",
             @"foundsId":@"foundsId",
             @"name":@"name",
             @"images":@"images",
             @"numberString":@"numberString",
             @"time":@"time",
             @"userIcon":@"userIcon",
             @"isOver":@"isOver",
             @"ownerName":@"ownerName",
             @"timeidentify":@"timeidentify"
             };
}

@end
