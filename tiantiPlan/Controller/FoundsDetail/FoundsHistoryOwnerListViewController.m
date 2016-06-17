//
//  FoundsHistoryOwnerListViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/18.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsHistoryOwnerListViewController.h"
#import "FoundsHistoryOwnerListCell.h"
#import "FoundsApiManager.h"

@interface FoundsHistoryOwnerListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayHistory;
@property (nonatomic, assign) NSInteger index;

@end

@implementation FoundsHistoryOwnerListViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
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
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.arrayHistory = [NSMutableArray array];
    self.index = 1;
}

- (void)initUI {
    [self setTitle:@"往期揭晓"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

- (void)headerRefresh {
    self.index = 1;
    [self requestData];
}

- (void)footerRefresh {
    self.index ++;
    [self requestData];
}


#pragma mark - HTTPRequest
- (void)requestData {
    [FoundsApiManager requestHistoryFoundsById:self.foundsId Atindex:[NSString stringWithFormat:@"%ld",self.index] ResultListModel:^(id response) {
        if (self.index == 1) {
            [self.arrayHistory removeAllObjects];
        }
        if ([response isKindOfClass:[NSArray class]]) {
            [self.arrayHistory addObjectsFromArray:response];
            [self.tableView reloadData];
        }
        
        if (self.arrayHistory.count < self.index * 20) {
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
    return self.arrayHistory.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    FoundsHistoryOwnerListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[FoundsHistoryOwnerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell showUnderLineAt:105];
    }
    if (self.arrayHistory.count > indexPath.row) {
        [cell configCellWithData:self.arrayHistory[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
