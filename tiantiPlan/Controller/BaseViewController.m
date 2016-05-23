//
//  BaseViewController.m
//  PropertyProject
//
//  Created by liujianzhong on 15/11/26.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterViewController.h"
#import "UserCacheBean.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIViewController+Loading.h"
#import <POP/POP.h>
#import "NSObject+AddKeyValueToObject.h"
//#import "LoginView.h"
#import "LGActionSheet.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelSubTitle;
@property (nonatomic, strong) UIControl *controlPop;
@property (nonatomic, strong) UIControl *controlPopBottom;
//@property (nonatomic, strong) LoginView *viewLogin;

@end

@implementation BaseViewController

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.textColor = [UIColor blackColor];
        _labelTitle.font = [UIFont systemFontOfSize:16];
        _labelTitle.text = @"";
        _labelTitle.backgroundColor = DSRedColor;
    }
    return _labelTitle;
}

- (UILabel *)labelSubTitle {
    if (_labelSubTitle == nil) {
        _labelSubTitle = [[UILabel alloc] init];
        _labelSubTitle.numberOfLines = 0;
        _labelSubTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelSubTitle.textAlignment = NSTextAlignmentLeft;
        _labelSubTitle.textColor = DSBlackColor;
        _labelSubTitle.font = [UIFont systemFontOfSize:12];
        _labelSubTitle.text = @"";
    }
    return _labelSubTitle;
}

//- (LoginView *)viewLogin {
//    if (_viewLogin == nil) {
//        _viewLogin = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 30, 280)];
//        _viewLogin.delegate = self;
//    }
//    return _viewLogin;
//}

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self adjustNavigationUI:self.navigationController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self resetBackButton];
}

- (void)resetBackButton {
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0 && previousViewControllerIndex < viewControllerArray.count) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
}

- (void)setTitle:(NSString *)title withSubTitle:(NSString *) subTitle{
    self.labelTitle.text = title;
    
    
}

- (void)adjustNavigationUI:(UINavigationController *) nav {
    [[UINavigationBar appearance] setBarTintColor:DSNavi];
//    nav.navigationBar.translucent = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
    NSShadow *shadow = [[NSShadow alloc] init];
    //    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
//    nav.navigationItem.titleView = self.labelTitle;

}

- (UINavigationController *)newNavigationControllerWithRootController:(UIViewController *) controller {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self adjustNavigationUI:nav];
    return nav;
}

- (void)setRightButtonWithTitle:(NSString *) title  {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(didRightClick)];
    [rightBar setTintColor:DSColor];
    [rightBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [rightBar setTitlePositionAdjustment:UIOffsetMake(-10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)setRightButtonWithIcon:(UIImage *) image {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(didRightClick)];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)setLeftButtonWithIcon:(UIImage *) image {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(didLeftClick)];
    [self.navigationItem setLeftBarButtonItem:leftBar];
}

- (void)setLeftButtonWithTitle:(NSString *) title  {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(didLeftClick)];
    [leftBar setTintColor:DSColor];
    [leftBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [leftBar setTitlePositionAdjustment:UIOffsetMake(10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:leftBar];
}

- (void)didRightClick {
    
}

- (void)didLeftClick {

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showLoading {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hiddenLoading {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showToastInfo:(NSString *)info {
    [self showInfo:info];
}

- (void)showToastInfoDetail:(NSString *)info {
    [self showInfoDetail:info];
}

- (void)doLogin {
    if (NO == [[UserCacheBean share] isLogin]) {
        RegisterViewController *controller = [[RegisterViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self adjustNavigationUI:nav];
        [self presentViewController:controller animated:YES completion:nil];
    }
}


- (void)doLoginWithBlock:(loginResultBlock) resultBlock {
    if ([[UserCacheBean share] isLogin] == YES) {
        resultBlock([UserCacheBean share], LOGINSTATUSSUCCESS);
    } else {
        RegisterViewController *controller = [[RegisterViewController alloc] init];
        controller.loginBlock = resultBlock;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

//- (void)doCheckPhoneNumber:(loginComplited) complited {
//    if ([[UserCacheBean share] isLogin]) {
//        if (complited) {
//            complited();
//        }
//        return;
//    }
//    self.viewLogin.loginResult = complited;
//    [self popView:self.viewLogin withOffset:100];
//    [self didCheckPhoneNumberShow];
//    [self.viewLogin.textName becomeFirstResponder];
//}

- (void)didCheckPhoneNumberShow {
    
}

- (void)popView:(UIView *)view withOffset:(CGFloat) offset {
    self.controlPop = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.controlPop.backgroundColor = DSColorAlphaMake(0, 0, 0, 0.2);
    [self.controlPop addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchDown];
    [self.controlPop addSubview:view];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.controlPop];
    
    CGRect frame = CGRectMake((SCREENWIDTH - view.ctWidth) / 2, (SCREENHEIGHT - view.ctHeight)/2 - offset, view.ctWidth, view.ctHeight);
//    view.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:frame];
    anim.toValue = [NSValue valueWithCGRect:frame];
    [view.layer pop_addAnimation:anim forKey:@"size"];
    //传递数据
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:anim.toValue forKey:@"toValue"];
    [dic setValue:anim.fromValue forKey:@"fromValue"];
    [dic setValue:view forKey:@"view"];
    [dic setValue:@2 forKey:@"type"];
    [self.controlPop setObjectDSValue:dic];
}

- (void)hidPopView {
    NSDictionary *dic = (NSDictionary *)self.controlPop.objectDSValue;
    if ([dic[@"type"] integerValue] == 1) {
        UIView *view = dic[@"view"];
        [UIView animateWithDuration:0.3 animations:^{
            view.frame = CGRectMake(0, SCREENHEIGHT , view.ctWidth, view.ctHeight);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
            [view.layer removeAllAnimations];
            self.controlPop.backgroundColor = [UIColor clearColor];
            [self.controlPop removeFromSuperview];
            self.controlPop = nil;
        }];
    } else {
        UIView *view = dic[@"view"];
        [view.layer removeAllAnimations];
        self.controlPop.backgroundColor = [UIColor clearColor];
        [self.controlPop removeFromSuperview];
        self.controlPop = nil;
    }
}

- (void)hiddenBottomView {
    NSDictionary *dicView = self.controlPopBottom.objectDSValue;
    UIView *view = dicView[@"view"];
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = CGRectMake(0, SCREENHEIGHT , view.ctWidth, view.ctHeight);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [view.layer removeAllAnimations];
        self.controlPopBottom.backgroundColor = [UIColor clearColor];
        [self.controlPopBottom removeFromSuperview];
        self.controlPopBottom = nil;
    }];
}

- (void)showViewBottom:(UIView *) view {
    view.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, view.ctHeight);
    self.controlPopBottom = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.controlPopBottom.backgroundColor = DSColorAlphaMake(0, 0, 0, 0.2);
    [self.controlPopBottom addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchDown];
    [self.controlPopBottom addSubview:view];
    NSDictionary *dic = @{@"view":view, @"type":@1};
    [self.controlPopBottom setObjectDSValue:dic];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.controlPopBottom];
    
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = CGRectMake(0, SCREENHEIGHT - view.ctHeight, SCREENWIDTH, view.ctHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didClickCancel:(UIControl *)control {
    if (self.controlPop != nil) {
        [self hidPopView];
    } else {
        [self hiddenBottomView];
    }
}

- (void)goBackDelay {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goBackToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popViewControllerDelay {
    [self performSelector:@selector(goBackDelay) withObject:nil afterDelay:1.5];
}

- (void)popRootViewControllerDelay {
    [self performSelector:@selector(goBackToRoot) withObject:nil afterDelay:1.5];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)adjustNavigationAlpha:(CGFloat) alpha {
    if (alpha > 0) {
        UIColor *color = DSNavi;
        color = [color colorWithAlphaComponent:alpha];
        UIImage *iamge = [self createImageWithColor:color];
        [self.navigationController.navigationBar setBackgroundImage:iamge forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:iamge];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

#pragma mark - LoginViewDelegate
//- (void)onCloseloginView:(LoginView *) loginView {
//    [self hidPopView];
//}
//
//- (void)loginView:(LoginView *)loginView actionIndex:(NSInteger)index {
//    switch (index) {
//        case 1:
//        {
//            [self didClickCheckNumber];
//        }
//            break;
//        case 2:
//        {
//            [self hidPopView];
//            [self didClickCommit];
//        }
//            break;
//        default:
//            break;
//    }
//}

@end
