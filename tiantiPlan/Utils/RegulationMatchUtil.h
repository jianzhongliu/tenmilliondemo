//
//  RegulationMatchUtil.h
//  PropertyProject
//
//  Created by liujianzhong on 15/12/7.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegulationMatchUtil : NSObject

+ (instancetype)share;

- (BOOL)regexMobilePhone:(NSString *) mobile;

- (BOOL)regexName:(NSString *) name;
@end
