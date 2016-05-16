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
+ (void)requestAllFoundsById:(NSString *)foundsId InfoModel:(responseModel ) response;
/**获取商品详情*/
+ (void)requestFoundsById:(NSString *)foundsId DetailInfoModel:(responseModel ) response;
/**获取商品往期揭晓列表*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId ResultListModel:(responseModel ) response;
/**购买商品*/
+ (void)requestHistoryFoundsById:(NSString *)foundsId userId:(NSString *) userID buyNumber:(NSString *) buyNumber ResultListModel:(responseModel ) response;
@end
