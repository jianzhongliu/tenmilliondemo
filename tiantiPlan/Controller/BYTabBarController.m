//
//  BYTabBarController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BYTabBarController.h"
#import "HomeViewController.h"
#import "HistoryListViewController.h"
#import "UserCenterViewController.h"
#import "AppDelegate.h"
#import "BYTabBarItem.h"

@interface BYTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) UIControl *control;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;//最后一次响铃时间

@end

@implementation BYTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self configureTabBarController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)adjustNavigationUI:(UINavigationController *) nav {
    [[UINavigationBar appearance] setBarTintColor:DSNavi];
    nav.navigationBar.translucent = YES;
    [[UINavigationBar appearance] setTintColor:DSColor];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
    NSShadow *shadow = [[NSShadow alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor blackColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
}

-(void) configureTabBarController
{
    BYTabBarItem *homeItem;
    BYTabBarItem *messageItem;
    BYTabBarItem *myItem;
    [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DSColor, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:10], NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DSColorFromHex(0x9999999), NSForegroundColorAttributeName, [UIFont systemFontOfSize:10], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.tabBar.tintColor = DSColor;
    homeItem = [[BYTabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_home_home"] selectedImage:[UIImage imageNamed:@"icon_home_home_selected"]];
    
    messageItem = [[BYTabBarItem alloc]initWithTitle:@"微聊" image:[UIImage imageNamed:@"icon_home_message"] selectedImage:[UIImage imageNamed:@"icon_home_message_selected"]];
    
    myItem = [[BYTabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_home_me"] selectedImage:[UIImage imageNamed:@"icon_home_me_selected"]];
    
    //home tab
    HomeViewController *homeController = [[HomeViewController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    homeController.navigationController.navigationBar.translucent = YES;
    homeItem.highlightedImage = [UIImage imageNamed:@"icon_home_home_selected"];
    homeNavController.tabBarItem = homeItem;
    [self adjustNavigationUI:homeNavController];
    
    //tab
    HistoryListViewController *messageController = [[HistoryListViewController alloc] init];
    UINavigationController *messageNavController = [[UINavigationController alloc] initWithRootViewController:messageController];
    messageController.navigationController.navigationBar.translucent = YES;
    messageItem.highlightedImage = [UIImage imageNamed:@"icon_home_message_selected.png"];
    messageNavController.tabBarItem = messageItem;
    [self adjustNavigationUI:messageNavController];
    
    //我
    UserCenterViewController *myController = [[UserCenterViewController alloc] init];
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:myController];
    myController.navigationController.navigationBar.translucent = YES;
    myItem.highlightedImage = [UIImage imageNamed:@"icon_home_me_selected"];
    myNavController.tabBarItem = myItem;
    [self adjustNavigationUI:myNavController];
    
    self.viewControllers = @[homeNavController, messageNavController, myNavController];
    [self.tabBar setBackgroundColor:[UIColor clearColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.selectedIndex = 0;
}

//- (void)doLoginWithBlock:(loginResultBlock) resultBlock {
//    if ([[UserCachBean share] isLogin] == YES) {
//        resultBlock([UserCachBean share], LOGINSTATUSSUCCESS);
//    } else {
//        LoginHomeViewController *controller = [[LoginHomeViewController alloc] init];
//        controller.loginBlock = resultBlock;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//        [self presentViewController:nav animated:YES completion:nil];
//    }
//    
//}

#pragma mark - tabBarController delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0) {
        self.currentIndex = tabBarController.selectedIndex;
    } else if (tabBarController.selectedIndex == 1){
        self.currentIndex = tabBarController.selectedIndex;
    } else if (tabBarController.selectedIndex == 2) {
        self.currentIndex = tabBarController.selectedIndex;
    }
}

@end
