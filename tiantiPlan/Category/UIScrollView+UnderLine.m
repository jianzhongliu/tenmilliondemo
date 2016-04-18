//
//  UIScrollView+UnderLine.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/3.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "UIScrollView+UnderLine.h"

@implementation UIScrollView (UnderLine)

- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y{
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, SCREENWIDTH - 2*x, 1)];
    viewLine.backgroundColor = DSLineSepratorColor;
    [self addSubview:viewLine];
}

- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y withColor:(UIColor *) color width:(CGFloat) width{
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 1)];
    viewLine.backgroundColor = color;
    [self addSubview:viewLine];
}

- (void)drawLineAtX:(CGFloat) x andY:(CGFloat) y withColor:(UIColor *) color{
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, SCREENWIDTH - 2*x, 1)];
    viewLine.backgroundColor = color;
    [self addSubview:viewLine];
}

- (void)drawRightLineAtX:(CGFloat) x andY:(CGFloat) y{
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(x, y, SCREENWIDTH - x, 1)];
    viewLine.backgroundColor = DSLineSepratorColor;
    [self addSubview:viewLine];
}


@end
