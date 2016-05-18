//
//  UserCenterApiManager.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseApi.h"

@interface UserCenterApiManager : BaseApi

/**登录并获取用户信息*/
+ (void)requestLoginUserInfoById:(NSString *)userId InfoModel:(responseModel ) response;
/**修改用户信息*/
+ (void)requestUpdateUserInfo:(NSDictionary *)dic InfoModel:(responseModel ) response;

@end
