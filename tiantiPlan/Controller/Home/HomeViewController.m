//
//  HomeViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeViewController.h"
#import "JXBAdPageView.h"
#import "UIImageView+WebCache.h"
#import "HomeFirstViewCell.h"
#import "HomeSecondViewCell.h"
#import "HomeThirdViewCell.h"
#import "FoundsDetailViewController.h"
#import "FoundsApiManager.h"
#import "HomeModel.h"
#import "FoundsModel.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, JXBAdPageViewDelegate, HomeFirstViewCellDelegate, HomeSecondViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXBAdPageView *viewAD;
@property (nonatomic, strong) HomeModel *homeModel;

@end

@implementation HomeViewController
- (JXBAdPageView *)viewAD {
    if (_viewAD == nil) {
        _viewAD = [[JXBAdPageView alloc] init];
        _viewAD.delegate = self;
        _viewAD.iDisplayTime = 3;
        _viewAD.bWebImage = YES;
    }
    return _viewAD;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

- (void)dealloc {
    self.viewAD.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)initData {
    
}

- (void)initUI {
    [self setTitle:@"首页"];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    self.tableView.tableHeaderView = self.viewAD;
    [self.viewAD startAdsWithBlock:@[@"www", @"www"] block:^(NSInteger clickIndex){
//        if (arrayData.count > clickIndex) {
//            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedADitem:)]) {
//                [_delegate didSelectedADitem:data[clickIndex]];
//            }
//        }
    }];
}

- (void)requestData {
    [FoundsApiManager requestAllFoundsInfoModel:^(id response) {
        HomeModel *homeModel = [[HomeModel alloc] init];
        [homeModel configModelWithDic:response];
        self.homeModel = homeModel;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 210;
        }
            break;
        case 1:
        {
            return 210;
        }
            break;
        case 2:
        {
            return 210;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            static NSString *identify = @"HomeFirstViewCell";
            HomeFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[HomeFirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:140];
                cell.delegate = self;
            }
            [cell configCellWithData:self.homeModel.arrayOver];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *identify = @"HomeSecondViewCell";
            HomeSecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[HomeSecondViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:140];
                cell.delegate = self;
            }
            [cell configCellWithData:self.homeModel.arrayActivity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *identify = @"HomeThirdViewCell";
            HomeThirdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[HomeThirdViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:140];
            }
            [cell configCellWithData:self.homeModel.arrayHot];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger ) index {
    if (self == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://img.1yyg.com/Poster/20140918182340689.jpg"];
    [imgView sd_setImageWithURL:url];
}

#pragma mark - HomeFirstViewCellDelegate
- (void)homeFirstViewCell:(HomeFirstViewCell *) cell clickData:(id) clickData {
    FoundsModel *founds = clickData;
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = founds.identify;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma makr - HomeSecondViewCellDelegate
- (void)homeSecondViewCell:(HomeSecondViewCell *) cell clickData:(id) clickData {
    FoundsModel *founds = clickData;
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = founds.identify;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
