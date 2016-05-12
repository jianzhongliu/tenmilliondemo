//
//  FoundsApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsApiManager.h"

@implementation FoundsApiManager

+ (void)requestAllFoundsInfoModel:(responseModel ) response {
    
    NSString *url = [NSString stringWithFormat:@"founds/getHomeFounds"];
    
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

@end
