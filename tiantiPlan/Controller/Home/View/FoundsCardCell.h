//
//  FoundsCardCell.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSConfig.h"
#import "UIView+CTExtensions.h"

typedef NS_ENUM(NSInteger, CARDTYPE) {
    CARDTYPEIMAGERIGHT = 1,
    CARDTYPEIMAGETOP = 2,
    CARDTYPEIMAGELEFT = 3
};

@interface FoundsCardCell : UIView

@property (nonatomic, assign) CARDTYPE cardType;

- (void)configViewWithData:(id) data;

@end
