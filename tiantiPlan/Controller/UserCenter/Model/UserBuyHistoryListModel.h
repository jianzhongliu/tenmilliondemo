//
//  UserBuyHistoryListModel.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "DSBaseModel.h"

@interface UserBuyHistoryListModel : DSBaseModel

@property (nonatomic, strong) NSString *identify;
@property (nonatomic, strong) NSString *foundsId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *userIcon;
@property (nonatomic, strong) NSString *isOver;
@property (nonatomic, strong) NSString *ownerName;
@property (nonatomic, strong) NSString *timeidentify;

@end
