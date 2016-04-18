//
//  UserCacheBean.h
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBaseInfoModel.h"
#import "AgentInfoModel.h"

@interface UserCacheBean : NSObject

@property (nonatomic, strong) UserBaseInfoModel *userInfo;
@property (nonatomic, strong) NSMutableDictionary *dicConfig;
@property (nonatomic, strong) NSMutableArray *priceItem;//价格选择区段
@property (nonatomic, strong) NSMutableArray *arrayFriend;//好友AgentInfoModel

+ (instancetype)share;
/**从缓存中通过微聊id获取对应的好友对象*/
- (AgentInfoModel *)fetchFriendWithChaterId:(NSString *) chaterId;

- (BOOL)isLogin;

- (void)loginOut;

@end
