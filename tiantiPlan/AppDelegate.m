//
//  AppDelegate.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "AppDelegate.h"
#import "BYTabBarController.h"
#import "DSConfig.h"
//掌淘科技
#import <SMS_SDK/SMS_SDK.h>
#import <BmobMessageSDK/Bmob.h>
#import "WXApi.h"

#import "UMSocial.h"

#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import <IapppayKit/IapppayKit.h>

#define ztappKey @"6ec614bbd5cf"
#define ztappSecret @"3c146fc7fc48754b2583d2daa389d772"

@interface AppDelegate () <WXApiDelegate>
{
    BYTabBarController *_mainTabController;

}
@end

@implementation AppDelegate

static AppDelegate *appDelegate;

+ (instancetype)share {
    return appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    appDelegate = self;
    
    //爱贝设置支付宝回调地址
    [[IapppayKit sharedInstance] setAppAlipayScheme:@"iapppay.alipay.com.AiBei.IapppayExample"];
    
    //bmob支付sdk注册
    [Bmob registerWithAppKey:@"9420c531761d609e1bb635b02713ece5"];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    //打开新浪微博的SSO开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WeiBoKey secret:WeiBoAppSecret RedirectURL:nil];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXAppSecret url:@"http://m.tieyou.com"];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:WeiXinAppID appSecret:WeiXinAppSecret url:@"http://m.tieyou.com"];
    
    //注册微信sdk
    [WXApi registerApp:WeiXinAppID];
    
    //掌淘短信验证初始化应用，appKey和appSecret从后台申请得到
    [SMS_SDK registerApp:ztappKey
              withSecret:ztappSecret];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainTabController = [[BYTabBarController alloc] init];
    self.window.rootViewController = _mainTabController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)switchToTabBarItemIndex:(NSInteger ) index {
    [self performSelector:@selector(tabbarIndex:) withObject:@(index) afterDelay:0.1];
}

- (void)tabbarIndex:(id) index {
    _mainTabController.selectedViewController = [_mainTabController.viewControllers objectAtIndex:[index integerValue]];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //此方法在某一时刻弃用，使用application:openURL:sourceApplication:annotation:代替
    [[IapppayKit sharedInstance] handleOpenUrl:url];
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //此方法为代替application:handleOpenURL:
    [[IapppayKit sharedInstance] handleOpenUrl:url];
    return [WXApi handleOpenURL:url delegate:self];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return [[IapppayKit sharedInstance] application:application supportedInterfaceOrientationsForWindow:window];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
