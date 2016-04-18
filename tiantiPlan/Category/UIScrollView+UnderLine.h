//
//  UIScrollView+UnderLine.h
//  PropertyProject
//
//  Created by liujianzhong on 15/12/3.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSConfig.h"

@interface UIScrollView (UnderLine)

- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y;
- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y withColor:(UIColor *) color width:(CGFloat) width;
- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y withColor:(UIColor *) color;
- (void)drawRightLineAtX:(CGFloat) x andY:(CGFloat) y;

@end
