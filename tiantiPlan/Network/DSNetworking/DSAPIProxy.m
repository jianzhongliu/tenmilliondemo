//
//  DSAPIProxy.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import "DSAPIProxy.h"
#import "DSRequestGenerator.h"
#import "DSURLResponse.h"
#import "FilePathManager.h"
#import "UIViewController+Loading.h"
#import "FunctionMethodsUtil.h"

@implementation DSAPIProxy

#pragma mark - getter && setter
- (NSMutableDictionary *)mapRequestList {
    if (_mapRequestList == nil) {
        _mapRequestList = [NSMutableDictionary dictionary];
    }
    return _mapRequestList;
}

- (NSMutableArray *)arrayLodingControllers {
    if (_arrayLodingControllers == nil) {
        return [NSMutableArray array];
    }
    return _arrayLodingControllers;
}

- (AFHTTPRequestOperationManager *)requestOperationManager {
    if (_requestOperationManager == nil) {
        _requestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
    }
    return _requestOperationManager;
}

- (NSNumber *)generateRequestId
{
    if (_requestID == nil) {
        _requestID = @(1);
    } else {
        if ([_requestID integerValue] == NSIntegerMax) {
            _requestID = @(1);
        } else {
            _requestID = @([_requestID integerValue] + 1);
        }
    }
    return _requestID;
}

#pragma mark - mainMethods

+ (instancetype)shareProxy {
    static DSAPIProxy *proxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (proxy == nil) {
            proxy = [[DSAPIProxy alloc] init];
            proxy.arrayLodingControllers = [NSMutableArray array];
        }
    });
    return proxy;
}

/**
 GET请求
 */
- (NSInteger)callGETWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock) fail {
    NSURLRequest *request = [[DSRequestGenerator shareInstance] generateGETRequestWithServiceUrl:url requestParams:params];
    return [self callAPIWithRequest:request isShowLoading:isShow successCallBack:success faildCallBack:fail];
}

/**
 POST 请求
 */
- (NSInteger)callPOSTWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail{
    NSURLRequest *request = [[DSRequestGenerator shareInstance] generatePOSTRequestWithServiceUrl:url requestParams:params];
    return [self callAPIWithRequest:request isShowLoading:isShow successCallBack:success faildCallBack:fail];
}

/**
 DELETE请求
 */
- (NSInteger)callDELETEWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock) fail {
    NSURLRequest *request = [[DSRequestGenerator shareInstance] generateDELETERequestWithServiceUrl:url requestParams:params];
    return [self callAPIWithRequest:request isShowLoading:isShow successCallBack:success faildCallBack:fail];
}

/**
 上传图片
 */
- (NSInteger)callUploadImage:(UIImage *)image isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail {
    NSURLRequest *request = [[DSRequestGenerator shareInstance] generateUploadImageRequestWithServiceData:image];
    return [self callAPIWithRequest:request isShowLoading:isShow successCallBack:success faildCallBack:fail];
}

/**
 图片下载
 */
- (NSInteger)callDownloadImageWithUrl:(NSString *)url isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail {
    if (isShow == YES) {
        [self showLoading];
    }
    NSNumber *requestID = [self generateRequestId];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error ) {
        [self hiddenLoading];
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (success != nil) {
                DSURLResponse *response = [[DSURLResponse alloc] initWithResponseString:nil
                                                                              requestId:requestID
                                                                                request:request
                                                                           responseData:data
                                                                                 status:ResponseStatusSuccess];
                response.value = image;
                success(response);
            }
        } else {
            if (fail != nil) {
                DSURLResponse *response = [[DSURLResponse alloc] initWithResponseString:nil
                                                                              requestId:requestID
                                                                                request:request
                                                                           responseData:data
                                                                                 status:ResponseStatusErrorFail];
                fail(response);
            }
        }
    }];
    return [requestID integerValue];
}

/**
 所有的服务最终都在这里发出，结果也在这里统一处理
 */
- (NSInteger)callAPIWithRequest:(NSURLRequest *) request isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock) fail {
    if (isShow == YES) {
        [self showLoading];
    }
    NSNumber *requestID = [self generateRequestId];
    
    AFHTTPRequestOperation *requestOperation = [self.requestOperationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self hiddenLoading];
        AFHTTPRequestOperation *storeOperation = self.mapRequestList[requestID];
        if (storeOperation == nil) {
            return ;
        } else {
            [self.mapRequestList removeObjectForKey:requestID];
        }
        [FunctionMethodsUtil doLoginCheckWithData:operation.responseData isShow:isShow];//处理登录逻辑
        DSURLResponse *response = [[DSURLResponse alloc] initWithResponseString:operation.responseString
                                                                      requestId:requestID
                                                                        request:operation.request
                                                                   responseData:operation.responseData
                                                                         status:ResponseStatusSuccess];
        if (success != nil) {
            success(response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self hiddenLoading];
        if (isShow == YES) {
            [self showInfo:@"网络连接失败,请重试"];
        }
        
        AFHTTPRequestOperation *storeOperation = self.mapRequestList[requestID];
        if (storeOperation == nil) {
            return ;
        } else {
            [self.mapRequestList removeObjectForKey:requestID];
        }
        
        DSURLResponse *response = [[DSURLResponse alloc] initWithResponseString:operation.responseString
                                                                      requestId:requestID
                                                                        request:operation.request
                                                                   responseData:operation.responseData
                                                                          error:error];
        if (fail != nil) {
            fail(response);
        }
    }];
    
    [[self.requestOperationManager operationQueue] addOperation:requestOperation];
    self.mapRequestList[requestID] = requestOperation;
    return [requestID integerValue];
}

- (void)showLoading {
    UIViewController *viewController = [FunctionMethodsUtil getCurrentRootViewController];
    if (viewController == nil && ![viewController isKindOfClass:[UIViewController class]])
    {
        return;
    }
    [self.arrayLodingControllers addObject:viewController];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    });
}

- (void)hiddenLoading {
    
    for (UIViewController *controller in self.arrayLodingControllers) {
        [MBProgressHUD hideHUDForView:controller.view animated:YES];
    }
    UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
    [MBProgressHUD hideHUDForView:controller.view animated:YES];
    [self.arrayLodingControllers removeAllObjects];
}

- (void)showInfo:(NSString *) info {
    if ([FunctionMethodsUtil getCurrentRootViewController] != nil) {
        UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
        [controller showInfo:info];
    }
}

- (NSString *)getNetworkingStatus {
    NSString *networkStatus = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];
    if ([networkStatus rangeOfString:@"WiFi"].length > 0) {
        return @"WiFi";
    } else if ([networkStatus rangeOfString:@"WWAN"].length > 0) {
        return @"2G/3G";
    } else {
        return @"unknow";
    }
}

- (void)cancelRequestByRequestID:(NSInteger) identify {
    NSNumber *requestID = [NSNumber numberWithInteger:identify];
    AFHTTPRequestOperation *operation = self.mapRequestList[requestID];
    [operation cancel];
    [self.mapRequestList removeObjectForKey:requestID];
}

- (void)cancelAllRequest {
    NSArray *arrayRequestKey = [self.mapRequestList allKeys];
    [arrayRequestKey enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AFHTTPRequestOperation *operation = self.mapRequestList[obj];
        [operation cancel];
        [self.mapRequestList removeObjectForKey:obj];
    }];
}

#pragma maik - utilMehods

@end

