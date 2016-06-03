//
//  FoundsTypeListViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/2.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsTypeListViewController.h"
#import "FoundsDetailViewController.h"
#import "FoundsApiManager.h"
#import "FoundsInfoCell.h"
#import "FoundsCarManager.h"
#import "ThrowLineTool.h"

@interface FoundsTypeListViewController () <UITableViewDelegate, UITableViewDataSource, FoundsInfoCellDelegate, ThrowLineToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) UIButton *buttonCar;
@property (nonatomic, strong) UILabel *labelNumber;

@end

@implementation FoundsTypeListViewController
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

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        
    }
    return _tableView;
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
    [self headerRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.index = 1;
    self.arrayData = [NSMutableArray array];
}

- (void)initUI {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    self.buttonCar.frame = CGRectMake(0, 0, 50, 50);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonCar];
    self.labelNumber.frame = CGRectMake(30, 0, 20, 20);
    [self.buttonCar addSubview:self.labelNumber];
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];

}

- (void)footerRefresh {
    self.index ++;
    [self requestFounds];
}

- (void)headerRefresh {
    self.index = 1;
    [self requestFounds];
}

- (void)onClickFoundsCar {
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

#pragma mark - HTTPRequest
- (void)requestFounds {
    NSString *category = @"1";
    switch (self.type) {
        case FOUNDSTYPECAR:
        {
            category = @"1";
        }
            break;
        case FOUNDSTYPEPHONE:
        {
            category = @"2";
        }
            break;
        case FOUNDSTYPEWATCH:
        {
            category = @"3";
        }
            break;
        case FOUNDSTYPEGIRL:
        {
            category = @"4";
        }
            break;
        default:
            break;
    }
    [FoundsApiManager requestFoundsWithCategory:category AtIndex:[NSString stringWithFormat:@"%ld",self.index] InfoModel:^(id response) {
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
    return 114;
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
    FoundsModel *foundsModel = self.arrayData[indexPath.row];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = foundsModel.identify;
    [self.navigationController pushViewController:controller animated:YES];
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
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
}

@end
