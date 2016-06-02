//
//  FoundsApiManager.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/12.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseApi.h"

@interface FoundsApiManager : BaseApi

/**获取首页列表*/
+ (void)requestAllFoundsType:(NSString *)type AtIndex:(NSString *) index InfoModel:(responseModel ) responseBlock;
/**按类别获取商品*/
+ (void)requestFoundsWithCategory:(NSString *)category AtIndex:(NSString *) index InfoModel:(responseModel ) responseBlock;
/**获取商品详情*/
+ (void)requestFoundsById:(NSString *)foundsId DetailInfoModel:(responseModel ) response;
/**获取商品往期揭晓列表*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId ResultListModel:(responseModel ) response;
/**购买商品*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId userId:(NSString *) userID buyNumber:(NSString *) buyNumber ResultListModel:(responseModel ) response;
/**购买历史*/
+ (void)requestUserHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) response;
/**中奖历史*/
+ (void)requestUserOwnerHistoryFoundsByUserId:(NSString *) userID ResultListModel:(responseModel ) response;
@end
