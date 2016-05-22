//
//  UserCenterApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserCenterApiManager.h"
#import "UserBaseInfoModel.h"
#import "UserCacheBean.h"

@implementation UserCenterApiManager
/**登录并获取用户信息*/
+ (void)requestLoginUserInfoById:(NSString *)userId InfoModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"userCenter/dologin"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId": userId} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            if ([response.content[@"userInfo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"userInfo"];
                NSError *error;
                UserBaseInfoModel *userInfo = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:dic error:&error];
                [[UserCacheBean share] setUserInfo:userInfo];
                if (responseModel) {
                    responseModel(userInfo);
                }
            }
        }
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**修改用户信息*/
+ (void)requestUpdateUserInfo:(NSDictionary *)dic InfoModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"userCenter/updateUserInfo"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":dic[@"userId"], @"name":dic[@"name"], @"icon":dic[@"icon"], @"address":dic[@"address"], @"date":dic[@"date"], @"phone":dic[@"phone"]} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        //存储用户信息UserBaseInfoModel
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            if ([response.content[@"userInfo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"userInfo"];
                NSError *error;
                UserBaseInfoModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:dic error:&error];
                [[UserCacheBean share] setUserInfo:historyOwnerInfo];
                if (responseModel) {
                    responseModel(historyOwnerInfo);
                }
            }
        }
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

@end
