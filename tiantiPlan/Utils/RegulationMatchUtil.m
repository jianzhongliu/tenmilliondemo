//
//  RegulationMatchUtil.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/7.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "RegulationMatchUtil.h"

@implementation RegulationMatchUtil

+ (instancetype)share {
    static RegulationMatchUtil *regulation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (regulation == nil) {
            regulation = [[RegulationMatchUtil alloc] init];
        }
    });
    return regulation;
}

- (BOOL)regexMobilePhone:(NSString *) mobile {
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

- (BOOL)regexName:(NSString *) name {
    NSString *regex = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:name];
    return isMatch;
}


@end
