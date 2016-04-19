//
//  BaseViewCell.h
//  DianSongBDTool
//
//  Created by liujianzhong on 15/8/1.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSConfig.h"
#import "UIView+CTExtensions.h"
#import "NSDictionary+TYAFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface BaseViewCell : UITableViewCell

//显示cell的下划线
- (void)showUnderLineAt:(CGFloat) Y ;

- (void)showUnderLineAt:(CGFloat) Y withX:(CGFloat) X;

//在cell上画一条线，每次调用都会画
- (void)addLineToCellAt:(CGFloat) Y ;

@end
