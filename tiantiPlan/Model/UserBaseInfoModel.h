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
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *phone;

- (NSDictionary *)getUserInfoDictionary;
- (void)configUserInfoModelWithDic:(NSDictionary *) dic;

@end
