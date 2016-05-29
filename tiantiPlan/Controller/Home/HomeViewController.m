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
#import "DSSegmentView.h"
#import "HomeHeaderView.h"
#import "HomeModel.h"
#import "FoundsModel.h"
#import "FoundsInfoCell.h"
#import "ThrowLineTool.h"
#import "FoundsCarManager.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, HomeFirstViewCellDelegate, HomeSecondViewCellDelegate, DSSegmentViewDelegate, FoundsInfoCellDelegate, ThrowLineToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeHeaderView *viewHeader;
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, strong) DSSegmentView *viewSegement;
@property (nonatomic, strong) UIButton *buttonCar;

@end

@implementation HomeViewController

- (HomeHeaderView *)viewHeader {
    if (_viewHeader == nil) {
        _viewHeader = [[HomeHeaderView alloc] init];
    }
    return _viewHeader;
}

- (DSSegmentView *)viewSegement {
    if (_viewSegement == nil) {
        _viewSegement = [[DSSegmentView alloc] init];
        _viewSegement.backgroundColor = [UIColor whiteColor];
        _viewSegement.delegate = self;
        [_viewSegement setTitles:@[@"房源",@"楼盘",@"工位",@"工位"] Frame:CGRectMake(0,0,SCREENWIDTH, 40)];
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
    }
    return _tableView;
}

- (UIButton *)buttonCar {
    if (_buttonCar == nil) {
        _buttonCar = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_buttonCar addTarget:self action:@selector(onClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [self requestData];

}

- (void)dealloc {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    
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

- (void)requestData {
    [FoundsApiManager requestAllFoundsInfoModel:^(id response) {
        HomeModel *homeModel = [[HomeModel alloc] init];
        [homeModel configModelWithDic:response];
        self.homeModel = homeModel;
        [self.viewHeader configViewWithData:self.homeModel];
        [self.tableView reloadData];
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
    [cell configCellWithData:self.homeModel.arrayActivity[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
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

#pragma mark - DSSegmentViewDelegate
- (void)didSelectedSegmentAtIndex:(NSInteger) index {
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
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
