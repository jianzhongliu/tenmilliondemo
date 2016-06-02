//
//  BaseViewController.h
//  PropertyProject
//
//  Created by liujianzhong on 15/11/26.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CTExtensions.h"
#import "DSAPIProxy.h"
#import "UIScrollView+UnderLine.h"
#import "UserBaseInfoModel.h"
#import "UserCacheBean.h"
#import "BaseViewCell.h"
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, LOGINSTATUS) {
    LOGINSTATUSSUCCESS = 1, //登录成功
    LOGINSTATUSFAIL = 2    //登录失败
};

typedef void (^loginResultBlock) (UserCacheBean *userInfo, LOGINSTATUS status);

typedef void(^loginComplited)();

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIViewController *fromController;//上级页面

- (void)resetBackButton;//去掉返回按钮上的字
- (void)showLoading;
- (void)hiddenLoading;
- (void)showToastInfo:(NSString *)info;
- (void)showToastInfoDetail:(NSString *)info;

- (void)setRightButtonWithTitle:(NSString *) title;
- (void)setRightButtonWithIcon:(UIImage *) image;
- (void)setLeftButtonWithIcon:(UIImage *) image;
- (void)setLeftButtonWithTitle:(NSString *) title;
- (void)didRightClick;
- (void)didLeftClick;

- (void)doLogin;
- (void)doLoginWithBlock:(loginResultBlock) resultBlock;
- (void)doCheckPhoneNumber:(loginComplited) complited;
- (void)didCheckPhoneNumberShow;//打log需要
- (void)didClickCheckNumber;//打log需要
- (void)didClickCommit;//打log需要

- (UINavigationController *)newNavigationControllerWithRootController:(UIViewController *) controller ;
- (void)adjustNavigationUI:(UINavigationController *) nav;

/**返回到上一级controller*/
- (void)popViewControllerDelay;

/**返回到根controller*/
- (void)popRootViewControllerDelay;
/**在屏幕中央弹出一个view*/
- (void)popView:(UIView *)view withOffset:(CGFloat) offset;
- (void)hidPopView;

- (void)showViewBottom:(UIView *) view ;
- (void)hiddenBottomView;
//改变导航栏透明度
- (void)adjustNavigationAlpha:(CGFloat) alpha;

@end
