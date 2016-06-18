//
//  ToolMainViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/17.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "ToolMainViewController.h"
#import "ALLFoundsListViewController.h"

@interface ToolMainViewController ()

@end

@implementation ToolMainViewController

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    
}

- (void)initUI {
    [self setTitle:@"管理工具"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(10, 400, 50, 50);
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(viewAllFounds) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)viewAllFounds {
    ALLFoundsListViewController *controller = [[ALLFoundsListViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
