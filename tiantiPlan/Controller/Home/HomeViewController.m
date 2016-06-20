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
#import "FoundsCarManager.h"
#import "ToolMainViewController.h"
#import "FoundsDetailViewController.h"
#import "FoundsTypeListViewController.h"
#import "FoundsApiManager.h"
#import "DSSegmentView.h"
#import "HomeHeaderView.h"
#import "HomeModel.h"
#import "FoundsModel.h"
#import "FoundsInfoCell.h"
#import "ThrowLineTool.h"
#import "MJRefresh.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, HomeHeaderViewDelegate, DSSegmentViewDelegate, FoundsInfoCellDelegate, ThrowLineToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeHeaderView *viewHeader;
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, strong) DSSegmentView *viewSegement;
@property (nonatomic, strong) UIButton *buttonCar;
@property (nonatomic, strong) UILabel *labelNumber;
@property (nonatomic, strong) NSMutableArray *arrayMainEnter;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray *arrayFounds;
@property (nonatomic, strong) NSMutableArray *arrayAD;

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
        [_viewSegement setSelectedIndex:0];
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
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];

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

- (UILabel *)labelNumber {
    if (_labelNumber == nil) {
        _labelNumber = [[UILabel alloc] init];
        _labelNumber.numberOfLines = 0;
        _labelNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelNumber.textAlignment = NSTextAlignmentCenter;
        _labelNumber.textColor = [UIColor whiteColor];
        _labelNumber.font = [UIFont systemFontOfSize:14];
        _labelNumber.text = @"";
        _labelNumber.layer.cornerRadius = 10;
        _labelNumber.clipsToBounds = YES;
        _labelNumber.backgroundColor = [UIColor redColor];
    }
    return _labelNumber;
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
//    [self headerRefresh];
}

- (void)dealloc {
    [ThrowLineTool sharedTool].delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
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
    self.arrayAD = [NSMutableArray array];
    self.arrayFounds = [NSMutableArray array];
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
    founds3.name = @"电子产品";
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
    self.viewHeader.frame = CGRectMake(0, 0, SCREENWIDTH, [self.viewHeader fetchViewHeight]);
    self.tableView.tableHeaderView = self.viewHeader;
    self.buttonCar.frame = CGRectMake(0, 0, 50, 50);
    self.labelNumber.frame = CGRectMake(30, 0, 20, 20);
    [self.buttonCar addSubview:self.labelNumber];
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonCar];
    [self.viewHeader configViewWithData:self.arrayMainEnter];

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.frame = CGRectMake(10, 400, 50, 50);
//    button.backgroundColor = [UIColor yellowColor];
//    [button addTarget:self action:@selector(didShowTool) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
#ifdef DEBUG_slaz
    
#endif
    
    
}

- (void)onClickFoundsCar {
    [self.tabBarController setSelectedIndex:1];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)reloadData {
    [self.viewHeader configAD:self.homeModel.arrayHot];
    [self.tableView reloadData];
}

- (void)didShowTool {
    ToolMainViewController *controller = [[ToolMainViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)requestData {
    [FoundsApiManager requestAllFoundsType:self.type AtIndex:[NSString stringWithFormat:@"%ld",self.index] InfoModel:^(id response) {
        if (self.index == 1) {
            [self.arrayFounds removeAllObjects];
        }
        HomeModel *homeModel = [[HomeModel alloc] init];
        [homeModel configModelWithDic:response];
        self.homeModel = homeModel;
        [self.arrayFounds addObjectsFromArray:self.homeModel.arrayOver];
        [self reloadData];
        if (self.arrayFounds.count < self.index * 20) {
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
    return self.arrayFounds.count;
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
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"FoundsInfoCell";
    FoundsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[FoundsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.delegate = self;
//        [cell showUnderLineAt:140];
//        cell.delegate = self;
    }
    [cell configCellWithData:self.arrayFounds[indexPath.row]];
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

- (void)homeHeaderViewCell:(HomeHeaderView *) cell didSelectADatIndex:(NSInteger) index {
    FoundsModel *foundsModel = self.homeModel.arrayHot[index];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = foundsModel.identify;
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
    if (self.navigationController.view == nil) {
        return;
    }
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
    [ThrowLineTool sharedTool].delegate = nil;
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
}

@end
