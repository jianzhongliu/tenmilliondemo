//
//  UserBaseInfoModel.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "UserBaseInfoModel.h"

@implementation UserBaseInfoModel
- (NSString *)userId {
    if (_userId == nil) {
        _userId = @"";
    }
    return _userId;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId" : @"identify",
             @"name" : @"name",
             @"icon" : @"icon",
             @"address" : @"address",
             @"date" : @"date",
             @"phone" : @"phone",
             @"account" : @"account"
             };
}

- (NSDictionary *)getUserInfoDictionary {

    NSDictionary *dic = @{
                          @"userId" : self.userId == nil ?@"":self.userId,
                          @"name" : self.name == nil?@"":self.name,
                          @"icon" : self.icon == nil?@"":self.icon,
                          @"address" : self.address == nil?@0:self.address,
                          @"date" : self.date == nil?@"":self.date,
                          @"phone" : self.phone == nil ?@"":self.phone,
                          @"account" : self.account == nil?@"":self.account                          };
    return dic;
}

- (void)configUserInfoModelWithDic:(NSDictionary *) dic {
    self.userId = dic[@"userId"];
    self.name = dic[@"name"];
    self.icon = dic[@"icon"];
    self.address = dic[@"address"];
    self.date = dic[@"date"];
    self.phone = dic[@"phone"];
    self.account = dic[@"account"];
}

@end
