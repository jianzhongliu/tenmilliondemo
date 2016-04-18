//
//  DSRequestCenter.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSURLResponse.h"

typedef void(^RequestResult)(DSURLResponse *response);

@interface DSRequestCenter : NSObject

@property (nonatomic, strong) RequestResult requestResult;

+(DSRequestCenter *)share;

@end
