//
//  FoundsCarManager.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/27.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoundsModel.h"
#import "UserDefaultCashe.h"
#import "DSConfig.h"

@interface FoundsCarManager : NSObject

+ (instancetype)share;

- (void)addFoundsToCar:(FoundsModel *) founds;

- (void)deleteFoundsToCar:(FoundsModel *) founds;

- (NSArray *)fetchLocalFoundsCar;

- (void)deleteLocalCar:(NSString *) identify;

- (NSInteger)foundsNumber;

@end
