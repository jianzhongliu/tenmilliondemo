//
//  UserBaseInfoModel.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "UserBaseInfoModel.h"

@implementation UserBaseInfoModel
- (NSString *)token {
    if (_token == nil || _token.length == 0) {
        _token = @"";
    }
    return _token;
}

- (NSString *)userId {
    if (_userId == nil) {
        _userId = @"";
    }
    return _userId;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId" : @"id",
             @"easemobPassword" : @"easemob_password",
             @"easemobUsername" : @"easemob_username",
             @"logo" : @"logo",
             @"cityId" : @"city_id",
             @"realName" : @"real_name",
             @"mobile" : @"mobile",
             @"token" : @"token"
             };
}

- (NSDictionary *)getUserInfoDictionary {
    if (self.token == nil) {
        return @{};
    }
    NSDictionary *dic = @{
                          @"userId" : self.userId == nil ?@"":self.userId,
                          @"mobile" : self.mobile == nil?@"":self.mobile,
                          @"token" : self.token == nil?@"":self.token,
                          @"cityId" : self.cityId == nil?@0:self.cityId,
                          @"realName" : self.realName == nil?@"":self.realName,
                          @"logo" : self.logo == nil ?@"":self.logo,
                          @"easemobUsername" : self.easemobUsername == nil?@"":self.easemobUsername,
                          @"easemobPassword" : self.easemobPassword == nil?@"":self.easemobPassword
                          };
    return dic;
}

- (void)configUserInfoModelWithDic:(NSDictionary *) dic {
    self.userId = dic[@"userId"];
    self.mobile = dic[@"mobile"];
    self.token = dic[@"token"];
    self.cityId = dic[@"cityId"];
    self.realName = dic[@"realName"];
    self.logo = dic[@"logo"];
    self.easemobUsername = dic[@"easemobUsername"];
    self.easemobPassword = dic[@"easemobPassword"];
}

@end
