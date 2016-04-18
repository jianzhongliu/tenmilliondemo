//
//  BaseApi.h
//  3laz
//
//  Created by liujianzhong on 16/1/8.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseModel.h"
#import "DSAPIProxy.h"

typedef void(^responseModel)(id response);

@interface BaseApi : NSObject

+ (void)requestAccountInfoModel:(responseModel ) response;

@end
