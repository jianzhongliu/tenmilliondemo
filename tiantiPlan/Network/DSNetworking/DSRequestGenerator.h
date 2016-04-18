//
//  DSRequestGenerator.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DSRequestGenerator : NSObject
+ (instancetype)shareInstance;
/**
 组建51版GET请求
 */
- (NSURLRequest *)generateGETRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;
/**
 组建51版POST请求
 */
- (NSURLRequest *)generatePOSTRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *)requestParams;
/**
 组建51版DELETE请求
 */
- (NSURLRequest *)generateDELETERequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;
/**
 组建51版上传图片
 */
- (NSURLRequest *)generateUploadImageRequestWithServiceData:(UIImage *)image;
/**
 组建51版下载文件
 */
- (NSURLRequest *)generateDownloadFileWithServiceUrl:(NSString *)url;

@end
