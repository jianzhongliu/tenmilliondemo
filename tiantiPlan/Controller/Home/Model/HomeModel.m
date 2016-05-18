//
//  HomeModel.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeModel.h"
#import "FoundsModel.h"

@implementation HomeModel

- (NSMutableArray *)arrayActivity {
    if (_arrayActivity == nil) {
        _arrayActivity = [NSMutableArray array];
    }
    return _arrayActivity;
}

- (NSMutableArray *)arrayAll {
    if (_arrayAll == nil) {
        _arrayAll = [NSMutableArray array];
    }
    return _arrayAll;
}

- (NSMutableArray *)arrayHot {
    if (_arrayHot == nil) {
        _arrayHot = [NSMutableArray array];
    }
    return _arrayHot;
}

- (NSMutableArray *)arrayOver {
    if (_arrayOver == nil) {
        _arrayOver = [NSMutableArray array];
    }
    return _arrayActivity;
}

- (void)configModelWithDic:(NSDictionary *) dicData {
    if (dicData == nil) {
        return;
    }
    [self.arrayActivity removeAllObjects];
    [self.arrayAll removeAllObjects];
    [self.arrayOver removeAllObjects];
    [self.arrayHot removeAllObjects];
    
    if (dicData[@"activityArray"] != nil && [dicData[@"activityArray"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in dicData[@"activityArray"]) {
            NSError *error = nil;
            FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:&error];
            [self.arrayActivity addObject:founds];
        }
    } else if (dicData[@"activityArray"] != nil && [dicData[@"activityArray"] isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dicData[@"activityArray"] error:&error];
        [self.arrayActivity addObject:founds];
    }
    
    if (dicData[@"allArray"] != nil && [dicData[@"allArray"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in dicData[@"allArray"]) {
            NSError *error = nil;
            FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:&error];
            [self.arrayAll addObject:founds];
        }
    } else if (dicData[@"allArray"] != nil && [dicData[@"allArray"] isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dicData[@"allArray"] error:&error];
        [self.arrayAll addObject:founds];
    }
    
    if (dicData[@"hotArray"] != nil && [dicData[@"hotArray"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in dicData[@"hotArray"]) {
            NSError *error = nil;
            FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:&error];
            [self.arrayHot addObject:founds];
        }
    } else if (dicData[@"hotArray"] != nil && [dicData[@"hotArray"] isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dicData[@"hotArray"] error:&error];
        [self.arrayHot addObject:founds];
    }
    
    if (dicData[@"overArray"] != nil && [dicData[@"overArray"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in dicData[@"overArray"]) {
            NSError *error = nil;
            FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:&error];
            [self.arrayOver addObject:founds];
        }
    } else if (dicData[@"overArray"] != nil && [dicData[@"overArray"] isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        FoundsModel *founds = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dicData[@"overArray"] error:&error];
        [self.arrayOver addObject:founds];
    }
}

@end
