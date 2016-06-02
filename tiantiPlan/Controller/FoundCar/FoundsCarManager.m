//
//  FoundsCarManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/27.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsCarManager.h"

@interface FoundsCarManager ()

@property (nonatomic, strong) NSMutableArray *arrayCar;

@end

@implementation FoundsCarManager

- (NSMutableArray *)arrayCar {
    if (_arrayCar == nil) {
        _arrayCar = [NSMutableArray array];
        [self fetchLocalCar];
    }
    return _arrayCar;
}

+ (instancetype)share {
    static FoundsCarManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FoundsCarManager alloc] init];
    });
    return manager;
}

- (void)addFoundsToCar:(FoundsModel *) founds {
    NSMutableArray *arrayFounds = [NSMutableArray array];
    BOOL isLocaledFounds = NO;
    for (FoundsModel *foundsItem in self.arrayCar) {
        if ([founds.identify isEqualToString:foundsItem.identify]) {
            foundsItem.localNumner = [NSString stringWithFormat:@"%d", [foundsItem.localNumner integerValue] + [founds.localNumner integerValue]];
            [arrayFounds addObject:foundsItem];
            isLocaledFounds = YES;
        } else {
            [arrayFounds addObject:foundsItem];
        }
    }
    if (isLocaledFounds == NO) {
        [arrayFounds addObject:founds];
    }
    [self.arrayCar removeAllObjects];
    [self.arrayCar addObjectsFromArray:arrayFounds];
    [self saveCarLocal];
}

- (void)deleteFoundsToCar:(FoundsModel *) founds {
    NSMutableArray *arrayFounds = [NSMutableArray array];
    BOOL isLocaledFounds = NO;
    for (FoundsModel *foundsItem in self.arrayCar) {
        if ([founds.identify isEqualToString:foundsItem.identify]) {
            if ([foundsItem.localNumner integerValue] > 1) {
                foundsItem.localNumner = [NSString stringWithFormat:@"%d", [foundsItem.localNumner integerValue] - 1];
            }
            [arrayFounds addObject:foundsItem];
            isLocaledFounds = YES;
        } else {
            [arrayFounds addObject:foundsItem];
        }
    }
    if (isLocaledFounds == NO) {
        [arrayFounds addObject:founds];
    }
    [self.arrayCar removeAllObjects];
    [self.arrayCar addObjectsFromArray:arrayFounds];
    [self saveCarLocal];
}

- (NSArray *)fetchLocalFoundsCar {
    return self.arrayCar;
}

- (void)saveCarLocal {
    NSMutableArray *arrayStorage = [NSMutableArray array];
    for (FoundsModel *founds in self.arrayCar) {
        NSDictionary *dicFounds = [MTLJSONAdapter JSONDictionaryFromModel:founds error:nil];
        [arrayStorage addObject:dicFounds];
    }
    [UserDefaultCashe casheArrayWith:arrayStorage forKey:LocalFoundsCar];
}

- (void)fetchLocalCar {
    [_arrayCar removeAllObjects];
    NSArray *arrlocal = [UserDefaultCashe fetchArrayWithKey:LocalFoundsCar];
    for (NSDictionary *dic in arrlocal) {
        FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:nil];
        [_arrayCar addObject:founds];
    }
}

- (void)deleteLocalCar:(NSString *) identify {
    NSMutableArray *arrayTemp = [NSMutableArray array];
    [arrayTemp addObjectsFromArray:self.arrayCar];
    for (FoundsModel *founds in arrayTemp) {
        if ([founds.identify isEqualToString:identify]) {
            [self.arrayCar removeObject:founds];
            [self saveCarLocal];
        }
    }
}

- (NSInteger)foundsNumber {
    NSInteger number = 0;
    for (FoundsModel *foundsItem in self.arrayCar) {
        number += [foundsItem.localNumner integerValue];
    }
    return number;
}

@end
