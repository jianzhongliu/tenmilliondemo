//
//  FoundsApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsApiManager.h"
#import "FoundsDetailModel.h"

@implementation FoundsApiManager

/**获取首页列表*/
+ (void)requestAllFoundsInfoModel:(responseModel ) responseBlock {
    NSString *url = [NSString stringWithFormat:@"founds/getHomeFounds"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (responseBlock) {
            responseBlock(response.content);
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseBlock) {
            responseBlock(nil);
        }
    }];
}

/**获取商品详情*/
+ (void)requestFoundsById:(NSString *)foundsId DetailInfoModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"founds/getFoundsDetail"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":foundsId==nil?@"":foundsId} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            FoundsDetailModel *foundsDetailModel = [[FoundsDetailModel alloc] init];
            [foundsDetailModel configFoundsDetailModelWithDic:response.content];
            if (responseModel) {
                responseModel(foundsDetailModel);
            }
        }
        if (responseModel) {
            responseModel(nil);
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

/**获取商品往期揭晓列表*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId ResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"founds/getHistoryFoundsResultList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":foundsId} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            NSMutableArray *arrayResult = [NSMutableArray array];
            if ([response.content[@"historyResult"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"historyResult"];
                NSError *error;
                FoundsHistoryOwnerInfoModel *historyModel = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dic error:&error];
                [arrayResult addObject:historyModel];
            } else if ([response.content[@"historyResult"] isKindOfClass:[NSArray class]]) {
                NSArray *arrayItem = response.content[@"historyResult"];
                for (NSDictionary *dicHistory in arrayItem) {
                    NSError *error;
                    FoundsHistoryOwnerInfoModel *historyModel = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dicHistory error:&error];
                    [arrayResult addObject:historyModel];
                }
            }
            if (responseModel) {
                responseModel(arrayResult);
            }
        }
        if (responseModel) {
            responseModel(nil);
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

/**购买商品*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId userId:(NSString *) userID buyNumber:(NSString *) buyNumber ResultListModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"orderCenter/payOrder"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":@"392840234802",@"userId":userID, @"buyNumber":buyNumber} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**购买历史*/
+ (void)requestUserHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"orderCenter/getUserRecordList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":userID} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

/**中奖历史*/
+ (void)requestUserOwnerHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) response {
    NSString *url = [NSString stringWithFormat:@"orderCenter/getUserOwnerFoundsList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":userID} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        
    } faildCallBack:^(DSURLResponse *response) {
        
    }];
}

@end
