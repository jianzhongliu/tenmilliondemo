//
//  AgentInfoModel.h
//  3laz
//
//  Created by liujianzhong on 16/1/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "DSBaseModel.h"

@interface AgentInfoModel : DSBaseModel
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *easemobUsername;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *workYearsLabel;

@end
