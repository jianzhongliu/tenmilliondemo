//
//  ALLFoundsListViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/17.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "ALLFoundsListViewController.h"
#import "UpdateFoundsInfoViewController.h"
#import "FoundsApiManager.h"
#import "FoundsInfoCell.h"
#import "HomeModel.h"

@interface ALLFoundsListViewController () <FoundsInfoCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation ALLFoundsListViewController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
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
    [self headerRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.arrayData = [NSMutableArray array];
}

- (void)initUI {
    [self setTitle:@"所有商品"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)headerRefresh {
    self.index = 1;
    [self reqestAllFounds];
}

- (void)footerRefresh {
    self.index ++;
    [self reqestAllFounds];
}

- (void)reqestAllFounds {
    [FoundsApiManager requestAllFoundsForDBManagerAtIndex:[NSString stringWithFormat:@"%ld",self.index] ResultListModel:^(id response) {
        if (self.index == 1) {
            [self.arrayData removeAllObjects];
        }
        if ([response isKindOfClass:[NSArray class]]) {
            [self.arrayData addObjectsFromArray:response];
            [self.tableView reloadData];
        }
        if (self.arrayData.count < self.index *20) {
            _tableView.mj_footer = nil;
        } else {
            _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    FoundsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[FoundsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        //        [cell showUnderLineAt:104];
        cell.delegate = self;
    }
    [cell configCellWithData:self.arrayData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UpdateFoundsInfoViewController *controler = [[UpdateFoundsInfoViewController alloc] init];
    controler.foundsModel = self.arrayData[indexPath.row];
    [self.navigationController pushViewController:controler animated:YES];
}


#pragma makr - FoundsInfoCellDelegate
- (void)foundsInfoCell:(FoundsInfoCell *)foundsCell {
    
}

@end
