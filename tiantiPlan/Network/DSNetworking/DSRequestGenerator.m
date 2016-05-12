//
//  DSRequestGenerator.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import "DSRequestGenerator.h"
#import "DSAFNetworkingConfig.h"
#import "DSSignatureGenerator.h"
#import "FilePathManager.h"
#import "DSConfig.h"
#import "NSString+Hash.h"
#import "DeviceModel.h"
#import "Utils.h"

@interface DSRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation DSRequestGenerator
#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

+ (instancetype)shareInstance {
    static DSRequestGenerator *reqest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (reqest == nil) {
            reqest = [[DSRequestGenerator alloc] init];
        }
    });
    return reqest;
}

- (NSURLRequest *)generateGETRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //参数表按字母排序，拼接成字符串
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [DSSignatureGenerator compomentParamsAndOrder:dicParams];
    NSString *paramString = [dicOrder TY_urlParamsStringSignature:YES];
    
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrderSigneture = [NSDictionary dictionary];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    dicOrderSigneture = [DSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *currentTime = [Utils getCurrentTime];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, DPSIGNATURE];
    sign = [[Utils MD5:sign] uppercaseString];
    
    NSString *signature = sign;
    //[DSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *urlString = @"";
    if ([url rangeOfString:@"?"].length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@%@&signature=%@",DPHOST, url, paramString,
                    signature];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@?%@&signature=%@",DPHOST, url, paramString, signature];
    }
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *)requestParams
{
    //参数
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //签名
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [DSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrder TY_urlParamsStringSignature:YES];
    NSString *signature = [DSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",DPHOST, url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);

    //加上签名串
    [dicParams setValue:signature forKey:@"signature"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:dicParams error:NULL];
    [self setCommonHeaderInfo:request];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return request;
}

- (NSURLRequest *)generateDELETERequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //参数表按字母排序，拼接成字符串
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [DSSignatureGenerator compomentParamsAndOrder:dicParams];
    NSString *paramString = [dicOrder TY_urlParamsStringSignature:YES];
    
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrderSigneture = [NSDictionary dictionary];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    dicOrderSigneture = [DSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrderSigneture TY_urlParamsStringSignature:YES];
    NSString *signature = [DSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *urlString = @"";
    if ([url rangeOfString:@"?"].length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@%@&signature=%@",DPHOST, url, paramString,
                     signature];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@?%@&signature=%@",DPHOST, url, paramString,
                     signature];
    }
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generateUploadImageRequestWithServiceData:(UIImage *)image
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:@{}];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    //签名
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [DSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrder TY_urlParamsStringSignature:YES];
    NSString *signature = [DSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];

    NSString *url = @"/upload/image?";
    NSString *urlString = [NSString stringWithFormat:@"%@%@",DPHOST, url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加上签名串
    [dicParams setValue:signature forKey:@"signature"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dicParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"filedata" fileName:[NSString stringWithFormat:@"%@_ds.jpg",[self getNowTime]] mimeType:@"image/jpg"];
    } error:nil];
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generateDownloadFileWithServiceUrl:(NSString *)url
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", DPHOST, url];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:requestUrl parameters:@{} error:NULL];
    [self setCommonHeaderInfo:request];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return request;
}

/**签名是参数+User-Agent加密组成的，而实际的网络请求参数中不包含User-Agent，User-Agent仅仅参与签名与header*/
- (NSString *)componentHeaderWithParamString:(NSString *) paramString {
    NSString *stringSign = [NSString stringWithFormat:@"%@&useragent=%@", paramString, [self commonHeader]];
    return stringSign;
}

/**公共参数放在这里*/
-(NSDictionary *)commonParams
{
#pragma mark - 修改参数
    NSMutableDictionary *dicCommonParams = [NSMutableDictionary dictionary];
    [dicCommonParams setValue:[NSNumber numberWithInt:(long)[self getRandomPositiveInteger]] forKey:@"nonce"];
    [dicCommonParams setValue:@2 forKey:@"app_id"];
    [dicCommonParams setValue:[self getNowTime] forKey:@"timestamp"];
    //暂留
    return dicCommonParams;
}

/**给request设置一个User-Agent值，给后台做数据统计用*/
- (void)setCommonHeaderInfo:(NSMutableURLRequest *) request {
    NSString *requestHeader = [self commonHeader];
    [request setValue:requestHeader forHTTPHeaderField:@"User-Agent"];
}

- (NSString *)commonHeader {
    NSString *stringHeader = [NSString stringWithFormat:@"%@/%@ (OS:iOS %@;Model:%@;UUID:%@;NetType:%@;GPS:%@)", APPNAME, [DeviceModel appVersion], [DeviceModel iosVersion], [DeviceModel iosType], [DeviceModel uniqueIdentifier], [DeviceModel networkStatus], [DeviceModel getLocationStatus]];
    return stringHeader;
}

//获取当前时间戳
- (NSString *)getNowTime
{
    //获取系统当前的时间戳
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%lld", recordTime];
    //    NSLog(@"%ld", [timeStr integerValue]);
    return timeStr;
}

//生成随机正整数
- (NSInteger)getRandomPositiveInteger
{
    return  (NSInteger)(1 + (arc4random() % (100 - 1 + 1)));
}

@end

