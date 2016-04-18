//
//  NetworkUtils.m
//  DianSongBDTool
//
//  Created by liujianzhong on 15/7/30.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "NetworkUtils.h"
#import "AFNetworking.h"

@implementation NetworkUtils

+ (instancetype)share {
    static NetworkUtils *utils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (utils == nil) {
            utils = [[NetworkUtils alloc] init];
        }
    });
    return utils;
}

/**检测网络状态*/
- (BOOL)netWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __block AFNetworkReachabilityStatus statusNew = status;
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {

        }
        //当网络发生变化时都会走到这里，我们把当前的网络状态设置到reachability中
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus statuss) {
            statuss = statusNew;
        }];
        //        NSLog(@"%ld", status);
        if (status == -1 || status == 0) {
            
        }else{
            
        }
    }];
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

@end
