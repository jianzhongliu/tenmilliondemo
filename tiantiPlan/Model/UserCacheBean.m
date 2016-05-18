//
//  UserCacheBean.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "UserCacheBean.h"
#import "UserDefaultCashe.h"
#import "UserBaseInfoModel.h"

@implementation UserCacheBean
@synthesize userInfo = _userInfo;

- (UserBaseInfoModel *)userInfo {
    if (_userInfo == nil) {
        _userInfo = [[UserBaseInfoModel alloc] init];
    }
    return _userInfo;
}

- (void)setUserInfo:(UserBaseInfoModel *)userInfo {
    _userInfo = userInfo;
    NSDictionary *dic = [userInfo getUserInfoDictionary];
    [UserDefaultCashe casheDicWith:dic forKey:@"userinfo"];
}

- (NSMutableDictionary *)dicConfig {
    if (_dicConfig == nil) {
        _dicConfig = [NSMutableDictionary dictionary];
    }
    return _dicConfig;
}

- (NSMutableArray *)arrayFriend {
    if (_arrayFriend == nil) {
        _arrayFriend = [NSMutableArray array];
    }
    return _arrayFriend;
}

- (NSMutableArray *)priceItem {
    if (_priceItem == nil) {
        _priceItem = [NSMutableArray array];
    }
    return _priceItem;
}

+ (void)load {
    [[UserCacheBean share] getUserInfoByCashe];
}

+ (instancetype)share {
    static UserCacheBean *userCachebean = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userCachebean == nil) {
            userCachebean = [[UserCacheBean alloc] init];
        }
    });
    return userCachebean;
}

- (void)getUserInfoByCashe {
    NSDictionary *dic = [UserDefaultCashe fetchDicWithKey:@"userinfo"];
    if (dic.count < 2) {
        return;
    }
    UserBaseInfoModel *user = [[UserBaseInfoModel alloc] init];
    [user configUserInfoModelWithDic:dic];
    [[UserCacheBean share] setUserInfo:user];
}

- (BOOL)isLogin {
    if (self.userInfo.userId.length > 0) {
        return YES;
    }
    return NO;
}

- (void)loginOut {
    UserBaseInfoModel *userInfo = [[UserBaseInfoModel alloc] init];
    [UserCacheBean share].userInfo = userInfo;
    [self setUserInfo:userInfo];
}

- (AgentInfoModel *)fetchFriendWithChaterId:(NSString *) chaterId {
    if (self.arrayFriend.count > 0) {
        for (AgentInfoModel *agent in self.arrayFriend) {
            if ([agent.easemobUsername isEqualToString:chaterId]) {
                return agent;
            }
        }
        return nil;
    } else {
        return nil;
    }
}

@end
