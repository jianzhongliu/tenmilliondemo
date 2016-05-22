//
//  UserCenterViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserCenterViewController.h"
#import "SettingViewController.h"
#import "MyFoundsHistoryListViewController.h"
#import "MyOwnerHistoryViewController.h"
#import "AddressManagerViewController.h"
#import "UserCenterHeaderView.h"
#import "CommonViewCell.h"
#import "UserInfoViewController.h"
#import "MoneyHistoryViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface UserCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserCenterHeaderView *viewHeader;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation UserCenterViewController

- (UserCenterHeaderView *)viewHeader {
    if (_viewHeader == nil) {
        _viewHeader = [[UserCenterHeaderView alloc] init];
    }
    return _viewHeader;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
    }
    return _tableView;
}
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
    self.array = [NSMutableArray arrayWithObjects:@"我的云购记录",@"中奖记录",@"地址管理", nil];
}

- (void)initUI {
    [self setTitle:@"我的"];
    self.viewHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    self.tableView.frame = self.view.bounds;
    self.tableView.tableHeaderView = self.viewHeader;
    [self.view addSubview:self.tableView];
    
    [self setRightButtonWithIcon:[UIImage imageNamed:@"ic_setting"]];
}

- (void)didRightClick {
    SettingViewController *controller = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getMoney {
//    [JOYConnect getConnect:@"24c9a1d87a0d51afd7b86753fe85e6b3" pid:@"appstore" userID:@"xguang"];
//    [JOYConnect sharedJOYConnect].delegate=self;
//    [JOYConnect showList:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    CommonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CommonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell showUnderLineAt:60];
    }
    [cell configCellWithData:self.array[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
                MyFoundsHistoryListViewController *controller = [[MyFoundsHistoryListViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;
        case 1:
        {
            [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
                MyOwnerHistoryViewController *controller = [[MyOwnerHistoryViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;
        case 2:
        {
            [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
                AddressManagerViewController *controller = [[AddressManagerViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;
        case 3:
        {
            [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
                MoneyHistoryViewController *controller = [[MoneyHistoryViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;

        default:
            break;
    }
}

@end
