//
//  HomeModel.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "DSBaseModel.h"

@interface HomeModel : DSBaseModel

@property (nonatomic, strong) NSMutableArray *arrayActivity;//活跃
@property (nonatomic, strong) NSMutableArray *arrayAll;//其他
@property (nonatomic, strong) NSMutableArray *arrayHot;//热门
@property (nonatomic, strong) NSMutableArray *arrayOver;//剩余

- (void)configModelWithDic:(NSDictionary *) dicData;

@end
