//
//  DSSignatureGenerator.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import "DSSignatureGenerator.h"
#import "NSString+Hash.h"
#import "DSConfig.h"

@implementation DSSignatureGenerator
/**
 加密字符串，用于签名
 签名时把参数拼接成字符串，传到这个方法加密，返回的就是签名
 */
+ (NSString *)signGETRestfulRequestWithSignParams:(NSString *) signature{
    // 加密字符串
    NSString *encryptStr = [signature hmacSHA1StringWithKey:DPSIGNATURE];
    return encryptStr;
}

+ (NSDictionary *)compomentParamsAndOrder:(NSDictionary *) originParam {
    NSMutableDictionary *dictionaryResult = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionarySign = [NSMutableDictionary dictionaryWithDictionary:originParam];
    NSMutableArray *keys = [[NSMutableArray alloc]initWithCapacity:5];
    [keys addObjectsFromArray:[dictionarySign allKeys]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [keys  sortUsingDescriptors:sortDescriptors];
    for(NSString* key in keys){
        NSString *val = [dictionarySign objectForKey:key];
        [dictionaryResult setValue:val forKey:key];
    }
    return dictionaryResult;
}

+ (NSString *)getAccessToken {
//    MemberEntity *mem = [[TYConfigManager shared] getMember];
//    NSString *token = mem.accessToken;
//    if (token.length == 0) {
//        token = @"";
//    }
    return @"";
}

+ (NSString *)paramStringWithDictionary:(NSDictionary *) dicSign {
    NSDictionary *dicParam = [DSSignatureGenerator compomentParamsAndOrder:dicSign];
    NSMutableString *signature  = [NSMutableString string];
    NSArray *keys = [dicParam allKeys];
    for(NSString* key in keys){
        NSString *val = [dicSign objectForKey:key];
        if ([signature length] <= 0) {
            //第一个参数
        }else{
            [signature appendString:@"&"];
        }
        [signature appendFormat:@"%@=%@", key, val];
    }
    return signature;
}

@end
