//
//  FoundsApiManager.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsApiManager.h"
#import "FoundsDetailModel.h"
#import "FoundsHistoryOwnerListModel.h"
#import "UserBuyHistoryListModel.h"
#import "FoundsModel.h"

@implementation FoundsApiManager

/**获取首页列表*/
+ (void)requestAllFoundsType:(NSString *)type AtIndex:(NSString *) index InfoModel:(responseModel ) responseBlock {
    NSString *url = [NSString stringWithFormat:@"founds/getHomeFounds"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"type":type ,@"index":index,@"limit":@"20"} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (responseBlock) {
            responseBlock(response.content);
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseBlock) {
            responseBlock(nil);
        }
    }];
}

/**按类别获取商品*/
+ (void)requestFoundsWithCategory:(NSString *)category AtIndex:(NSString *) index InfoModel:(responseModel ) responseBlock {
    NSString *url = [NSString stringWithFormat:@"founds/getTypeFounds"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"category":category ,@"index":index,@"limit":@"20"} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        NSMutableArray *arrayFounds = [NSMutableArray array];
        if ([response.content[@"overArray"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.content[@"overArray"]) {
                NSError *error = nil;
                FoundsModel *found = [MTLJSONAdapter modelOfClass:FoundsModel.class fromJSONDictionary:dic error:&error];
                [arrayFounds addObject:found];
            }
        }
        if (responseBlock) {
            responseBlock(arrayFounds);
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
+ (void)requestHistoryFoundsById:(NSString *)foundsId Atindex:(NSString *) index ResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"founds/getHistoryFoundsResultList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":foundsId,@"index":index, @"limit":@"20"} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            NSMutableArray *arrayResult = [NSMutableArray array];
            if ([response.content[@"historyOwnerFounds"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"historyOwnerFounds"];
                NSError *error = nil;
                FoundsHistoryOwnerInfoModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dic error:&error];
                
//                FoundsHistoryOwnerListModel *historyOwnerInfo = [[FoundsHistoryOwnerListModel alloc] init];
//                [historyOwnerInfo configFoundsDetailModelWithDic:dic];
                [arrayResult addObject:historyOwnerInfo];
            } else if ([response.content[@"historyOwnerFounds"] isKindOfClass:[NSArray class]]) {
                NSArray *arrayItem = response.content[@"historyOwnerFounds"];
                for (NSDictionary *dicHistory in arrayItem) {
                    NSError *error = nil;
                    FoundsHistoryOwnerInfoModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dicHistory error:&error];
//                    FoundsHistoryOwnerListModel *historyOwnerInfo = [[FoundsHistoryOwnerListModel alloc] init];
//                    [historyOwnerInfo configFoundsDetailModelWithDic:dicHistory];
                    [arrayResult addObject:historyOwnerInfo];
                }
            }
            if (responseModel) {
                responseModel(arrayResult);
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

/**购买商品*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId userId:(NSString *) userID buyNumber:(NSString *) buyNumber ResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"orderCenter/payOrder"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"foundsId":foundsId,@"userId":userID, @"buyNumber":buyNumber} isShowLoading:NO successCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

/**购买历史*/
+ (void)requestUserHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"orderCenter/getUserRecordList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":userID} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            NSMutableArray *arrayResult = [NSMutableArray array];
            if ([response.content[@"recordList"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"recordList"];
                NSError *error;
                UserBuyHistoryListModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:UserBuyHistoryListModel.class fromJSONDictionary:dic error:&error];
                [arrayResult addObject:historyOwnerInfo];
            } else if ([response.content[@"recordList"] isKindOfClass:[NSArray class]]) {
                NSArray *arrayItem = response.content[@"recordList"];
                for (NSDictionary *dicHistory in arrayItem) {
                    NSError *error;
                    UserBuyHistoryListModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:UserBuyHistoryListModel.class fromJSONDictionary:dicHistory error:&error];                    [arrayResult addObject:historyOwnerInfo];
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
        
    }];
}

/**中奖历史*/
+ (void)requestUserOwnerHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"orderCenter/getUserOwnerFoundsList"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{@"userId":userID} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
        if (response.content && [response.content[@"code"] integerValue] == 0) {
            NSMutableArray *arrayResult = [NSMutableArray array];
            if ([response.content[@"ownerRecordList"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = response.content[@"ownerRecordList"];
                NSError *error;
                FoundsHistoryOwnerInfoModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dic error:&error];
                [arrayResult addObject:historyOwnerInfo];
            } else if ([response.content[@"ownerRecordList"] isKindOfClass:[NSArray class]]) {
                NSArray *arrayItem = response.content[@"ownerRecordList"];
                for (NSDictionary *dicHistory in arrayItem) {
                    NSError *error;
                    FoundsHistoryOwnerInfoModel *historyOwnerInfo = [MTLJSONAdapter modelOfClass:FoundsHistoryOwnerInfoModel.class fromJSONDictionary:dicHistory error:&error];                    [arrayResult addObject:historyOwnerInfo];
                }
            }
            if (responseModel) {
                responseModel(arrayResult);
            }
        }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

+ (void)requestUtilResultListModel:(responseModel ) responseModel {
    NSString *url = [NSString stringWithFormat:@"util/startThread"];
    [[DSAPIProxy shareProxy] callGETWithUrl:url Params:@{} isShowLoading:YES successCallBack:^(DSURLResponse *response) {
            if (responseModel) {
                responseModel(response);
            }
    } faildCallBack:^(DSURLResponse *response) {
        if (responseModel) {
            responseModel(nil);
        }
    }];
}

@end
