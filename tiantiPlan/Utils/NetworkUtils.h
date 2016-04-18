//
//  NetworkUtils.h
//  DianSongBDTool
//
//  Created by liujianzhong on 15/7/30.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUtils : NSObject
+ (instancetype)share;

/**检测网络状态*/
- (BOOL)netWorkStatus;

@end
