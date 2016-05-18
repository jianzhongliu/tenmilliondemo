//
//  UserCenterApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserCenterApiManager.h"

@implementation UserCenterApiManager
/**登录并获取用户信息*/
+ (void)requestLoginUserInfoById:(NSString *)userId InfoModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"userCenter/dologin"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId": userId} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**修改用户信息*/
+ (void)requestUpdateUserInfo:(NSDictionary *)dic InfoModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"userCenter/updateUserInfo"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":dic[@"userId"], @"name":dic[@"name"], @"icon":dic[@"icon"], @"address":dic[@"address"], @"date":dic[@"date"], @"phone":dic[@"phone"]} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        //存储用户信息
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

@end
