//
//  UserBaseInfoModel.h
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

@interface UserBaseInfoModel : DSBaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *easemobUsername;
@property (nonatomic, strong) NSString *easemobPassword;

- (NSDictionary *)getUserInfoDictionary;
- (void)configUserInfoModelWithDic:(NSDictionary *) dic;

@end
