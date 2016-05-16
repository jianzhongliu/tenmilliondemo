//
//  FoundsApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsApiManager.h"

@implementation FoundsApiManager

/**获取首页列表*/
+ (void)requestAllFoundsById:(NSString *)foundsId InfoModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"founds/getHomeFounds"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**获取商品详情*/
+ (void)requestFoundsById:(NSString *)foundsId DetailInfoModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"founds/getFoundsDetail"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":@"392840234802"} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**获取商品往期揭晓列表*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId ResultListModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"founds/getHistoryFoundsResultList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":@"392840234802"} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**购买商品*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId userId:(NSString *) userID buyNumber:(NSString *) buyNumber ResultListModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"founds/payOrder"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":@"392840234802",@"userId":userID, @"buyNumber":buyNumber} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

@end
