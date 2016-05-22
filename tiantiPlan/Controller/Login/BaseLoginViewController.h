//
//  BaseLoginViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSConfig.h"
#import "UIViewController+Loading.h"
#import "UserCacheBean.h"
#import "BaseViewController.h"


@interface BaseLoginViewController : BaseViewController

@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) UIButton *buttonDismiss;

@property (nonatomic, copy) loginResultBlock loginBlock;

- (void)goBackView;

- (void)didmissLoginView;

- (void)sendUserActionLog:(NSString *) logid;

@end
