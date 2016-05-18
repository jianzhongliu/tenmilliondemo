//
//  FoundsModel.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsModel.h"

@implementation FoundsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identify":@"identify",
             @"images":@"images",
             @"isover":@"isover",
             @"lastid":@"lastid",
             @"name":@"name",
             @"nown":@"nown",
             @"totaln":@"totaln",
             @"type":@"type"
             };
}
@end
