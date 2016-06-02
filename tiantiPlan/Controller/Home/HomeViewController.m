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
#import "FoundsTypeListViewController.h"
#import "FoundsApiManager.h"
#import "DSSegmentView.h"
#import "HomeHeaderView.h"
#import "HomeModel.h"
#import "FoundsModel.h"
#import "FoundsInfoCell.h"
#import "ThrowLineTool.h"
#import "FoundsCarManager.h"
#import "MJRefresh.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, HomeHeaderViewDelegate, HomeSecondViewCellDelegate, DSSegmentViewDelegate, FoundsInfoCellDelegate, ThrowLineToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeHeaderView *viewHeader;
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, strong) DSSegmentView *viewSegement;
@property (nonatomic, strong) UIButton *buttonCar;
@property (nonatomic, strong) NSMutableArray *arrayMainEnter;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *type;

@end

@implementation HomeViewController

- (HomeHeaderView *)viewHeader {
    if (_viewHeader == nil) {
        _viewHeader = [[HomeHeaderView alloc] init];
        _viewHeader.delegate = self;
    }
    return _viewHeader;
}

- (DSSegmentView *)viewSegement {
    if (_viewSegement == nil) {
        _viewSegement = [[DSSegmentView alloc] init];
        _viewSegement.backgroundColor = [UIColor whiteColor];
        _viewSegement.delegate = self;
        [_viewSegement setTitles:@[@"热门",@"人气",@"推荐",@"新品"] Frame:CGRectMake(0,0,SCREENWIDTH, 40)];
    }
    return _viewSegement;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];

    }
    return _tableView;
}

- (UIButton *)buttonCar {
    if (_buttonCar == nil) {
        _buttonCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCar setImage:[UIImage imageNamed:@"icon_car"] forState:UIControlStateNormal];
        [_buttonCar setImage:[UIImage imageNamed:@"icon_car_seleted"] forState:UIControlStateHighlighted];
        [_buttonCar addTarget:self action:@selector(onClickFoundsCar) forControlEvents:UIControlEventTouchUpInside];
        _buttonCar.selected = NO;
        [_buttonCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonCar.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonCar;
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

- (void)dealloc {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)headerRefresh {
    self.index = 1;
    [self requestData];
}

- (void)footerRefresh {
    self.index ++;
    [self requestData];
}

- (void)initData {
    self.arrayMainEnter = [NSMutableArray array];
    self.index = 1;
    self.type = @"1";
    FoundsModel *founds1 = [[FoundsModel alloc] init];
    founds1.images = @"icon_type_1";
    founds1.name = @"汽车专区";
    founds1.type = @"一元秒车";
    
    FoundsModel *founds2 = [[FoundsModel alloc] init];
    founds2.images = @"icon_type_2";
    founds2.name = @"手机专区";
    founds2.type = @"一元买iPhone 6S";
    
    FoundsModel *founds3 = [[FoundsModel alloc] init];
    founds3.images = @"icon_type_3";
    founds3.name = @"手表专区";
    founds3.type = @"一元变高富帅";
    
    FoundsModel *founds4 = [[FoundsModel alloc] init];
    founds4.images = @"icon_type_4";
    founds4.name = @"都市丽人";
    founds4.type = @"一元变白富美";
    
    [self.arrayMainEnter addObject:founds1];
    [self.arrayMainEnter addObject:founds2];
    [self.arrayMainEnter addObject:founds3];
    [self.arrayMainEnter addObject:founds4];
    
}

- (void)initUI {
    [self setTitle:@"首页"];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.viewSegement.frame  =CGRectMake(0, 64, SCREENWIDTH, 40);
    self.viewHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 370);
    self.tableView.tableHeaderView = self.viewHeader;
    self.buttonCar.frame = CGRectMake(0, 0, 50, 50);
//    [self.view addSubview:self.buttonCar];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonCar];
    
}

- (void)onClickFoundsCar {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

- (void)requestData {
    [FoundsApiManager requestAllFoundsType:self.type AtIndex:[NSString stringWithFormat:@"%ld",self.index] InfoModel:^(id response) {
        HomeModel *homeModel = [[HomeModel alloc] init];
        [homeModel configModelWithDic:response];
        self.homeModel = homeModel;
        [self.viewHeader configViewWithData:self.arrayMainEnter];
        [self.tableView reloadData];
        if (homeModel.arrayOver.count < [self.type integerValue] * 20) {
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
    return self.homeModel.arrayActivity.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.viewSegement;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"HomeSecondViewCell";
    FoundsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[FoundsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.delegate = self;
//        [cell showUnderLineAt:140];
//        cell.delegate = self;
    }
    [cell configCellWithData:self.homeModel.arrayOver[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoundsModel *foundsModel = self.homeModel.arrayOver[indexPath.row];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = foundsModel.identify;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - HomeHeaderViewDelegate
- (void)homeHeaderViewCell:(HomeHeaderView *) cell atIndex:(NSInteger) index {
    FoundsModel *founds = self.arrayMainEnter[index];
    FoundsTypeListViewController *controller = [[FoundsTypeListViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.title = founds.name;
    controller.type = index + 1;
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

#pragma mark - DSSegmentViewDelegate
- (void)didSelectedSegmentAtIndex:(NSInteger) index {
    switch (index) {
        case 0:
        {
            self.type = @"1";
        }
            break;
        case 1:
        {
            self.type = @"2";
        }
            break;
        case 2:
        {
            self.type = @"3";
        }
            break;
        case 3:
        {
            self.type = @"4";
        }
            break;
        default:
            break;
    }
    [self headerRefresh];
}

- (void)foundsInfoCell:(FoundsInfoCell *)foundsCell  {
    //通过坐标转换得到抛物线的起点和终点
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(foundsCell.imageOffice.ctLeft, foundsCell.imageOffice.ctTop, foundsCell.imageOffice.ctWidth, foundsCell.imageOffice.ctHeight)];
    image.image = foundsCell.imageOffice.image;
    CGRect parentRectA = [foundsCell convertRect:foundsCell.imageOffice.frame toView:[UIApplication sharedApplication].keyWindow];
    CGRect parentRectB = [self.navigationController.view convertRect:self.buttonCar.frame toView:[UIApplication sharedApplication].keyWindow];
    [self.navigationController.view addSubview:image];
    [ThrowLineTool sharedTool].delegate = self;
    [[ThrowLineTool sharedTool] throwObject:image from:parentRectA.origin to:parentRectB.origin];
    
    FoundsModel *founds = [[FoundsModel alloc] init];
    founds.identify = foundsCell.foundsData.identify;
    founds.images = foundsCell.foundsData.images;
    founds.isover = foundsCell.foundsData.isover;
    founds.lastid = foundsCell.foundsData.lastid;
    founds.name = foundsCell.foundsData.name;
    founds.nown = foundsCell.foundsData.nown;
    founds.totaln = foundsCell.foundsData.totaln;
    founds.type = foundsCell.foundsData.type;
    founds.localNumner = @"1";
    [[FoundsCarManager share] addFoundsToCar:founds];
}

- (void)animationDidFinish {
    
    
    
}

@end
