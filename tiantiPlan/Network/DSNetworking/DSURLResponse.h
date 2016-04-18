//
//  DSURLResponse.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSAFNetworkingConfig.h"

@interface DSURLResponse : NSObject
@property (nonatomic, copy) id value;//经过处理之后的结果

@property (nonatomic, assign, readonly) ResponseStatus status;//请求状态，目前只分成功和失败，
@property (nonatomic, copy, readonly) NSData *responseData;//请求返回原始结果，NSdata类型
@property (nonatomic, copy, readonly) NSString *contentString;//请求返回原始结果，json字符串类型
@property (nonatomic, copy, readonly) id content;//请求返回原始结果，id类型
@property (nonatomic, assign, readonly) NSInteger requestId;//请求ID
@property (nonatomic, copy, readonly) NSURLRequest *request;//请求url
@property (nonatomic, copy) NSDictionary *requestParams;//请求参数
@property (nonatomic, assign, readonly) BOOL isCache;//是否缓存数据

//成功
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(ResponseStatus)status;

//失败
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

@end
