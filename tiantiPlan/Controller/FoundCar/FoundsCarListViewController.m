//
//  FoundsCarListViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/22.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsCarListViewController.h"
#import "FoundsDetailViewController.h"
#import "FoundsCarViewCell.h"
#import "FoundsCarManager.h"
#import "FoundsApiManager.h"

@interface FoundsCarListViewController () <UITableViewDataSource, UITableViewDelegate,FoundsCarViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *viewBanner;
@property (nonatomic, strong) UILabel *labelTotal;
@property (nonatomic, strong) UIButton *buttonPay;
@property (nonatomic, strong) UIView *viewLine;

@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, assign) NSInteger totalAmount;
@end

@implementation FoundsCarListViewController

- (UIView *)viewBanner {
    if (_viewBanner == nil) {
        _viewBanner = [[UIView alloc] init];
        _viewBanner.backgroundColor = [UIColor whiteColor];
    }
    return _viewBanner;
}

- (UILabel *)labelTotal {
    if (_labelTotal == nil) {
        _labelTotal = [[UILabel alloc] init];
        _labelTotal.numberOfLines = 0;
        _labelTotal.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTotal.textAlignment = NSTextAlignmentLeft;
        _labelTotal.textColor = DSBlackColor;
        _labelTotal.font = [UIFont systemFontOfSize:14];
        _labelTotal.text = @"合计：0";
    }
    return _labelTotal;
}

- (UIButton *)buttonPay {
    if (_buttonPay == nil) {
        _buttonPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPay addTarget:self action:@selector(onClickButtonPay) forControlEvents:UIControlEventTouchUpInside];
        _buttonPay.selected = NO;
        [_buttonPay setTitle:@"去支付" forState:UIControlStateNormal];
        _buttonPay.backgroundColor = [UIColor redColor];
        _buttonPay.layer.cornerRadius = 6;
        [_buttonPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonPay.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonPay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonPay;
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

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = DSLineSepratorColor;
    }
    return _viewLine;
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
    [self reloadData];
}

- (void)initData {
    self.totalAmount = 0;
    self.arrayData = [NSMutableArray array];
}

- (void)reloadData {
    self.totalAmount = 0;
    [self.arrayData removeAllObjects];
    NSArray *array = [[FoundsCarManager share] fetchLocalFoundsCar];
    for (FoundsModel *founds in array) {
        self.totalAmount +=[founds.localNumner integerValue];
    }
    self.labelTotal.text = [NSString stringWithFormat:@"总计：%ld", self.totalAmount];
    if (self.totalAmount > 0) {
        self.buttonPay.hidden = NO;
    } else {
        self.buttonPay.hidden = YES;
    }
    [self.arrayData addObjectsFromArray:array];
    [self.tableView reloadData];
}

- (void)initUI {
    [self setTitle:@"购物车"];
    self.tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 50);
    [self.view addSubview:self.tableView];
    
    self.viewBanner.frame = CGRectMake(0, self.view.ctBottom - 100, SCREENWIDTH, 50);
    self.labelTotal.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 50);
    self.buttonPay.frame = CGRectMake(SCREENWIDTH - 100, 10, 80, 30);
    self.viewLine.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
    [self.view addSubview:self.viewBanner];
    [self.viewBanner addSubview:self.labelTotal];
    [self.viewBanner addSubview:self.buttonPay];
    [self.viewBanner addSubview:self.viewLine];
}

- (void)onClickButtonPay {
    [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
        NSArray *array = [NSArray arrayWithArray:[[FoundsCarManager share] fetchLocalFoundsCar]];
        [self showLoading];
        for (FoundsModel *foundsDetail in array) {
            [[FoundsCarManager share] deleteLocalCar:foundsDetail.identify];
            [FoundsApiManager requestHistoryFoundsById:foundsDetail.identify userId:[UserCacheBean share].userInfo.userId buyNumber:foundsDetail.localNumner ResultListModel:^(id response) {
                [self hiddenLoading];
                [self showToastInfo:@"支付成功"];
            }];
        }
        [self reloadData];
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    FoundsCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[FoundsCarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell showUnderLineAt:120];
        cell.delegate = self;
    }
    [cell configCellWithData:self.arrayData[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoundsModel *founds = self.arrayData[indexPath.row];
    FoundsDetailViewController *controller = [[FoundsDetailViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.foundsId = founds.identify;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell didDelete:(FoundsModel *) foundsDetail {
    [[FoundsCarManager share] deleteLocalCar:foundsDetail.identify];
    [self reloadData];
}

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell doAddNumber:(FoundsModel *) foundsDetail {
    FoundsModel *founds = [[FoundsModel alloc] init];
    founds.identify = foundsDetail.identify;
    founds.images = foundsDetail.images;
    founds.isover = foundsDetail.isover;
    founds.lastid = foundsDetail.lastid;
    founds.name = foundsDetail.name;
    founds.nown = foundsDetail.nown;
    founds.totaln = foundsDetail.totaln;
    founds.type = foundsDetail.type;
    founds.localNumner = @"1";
    [[FoundsCarManager share] addFoundsToCar:founds];
    [self reloadData];
}

- (void)foundsCarCell:(FoundsCarViewCell *) foundsCell doDeleteNumber:(FoundsModel *) foundsDetail {
    FoundsModel *founds = [[FoundsModel alloc] init];
    founds.identify = foundsDetail.identify;
    founds.images = foundsDetail.images;
    founds.isover = foundsDetail.isover;
    founds.lastid = foundsDetail.lastid;
    founds.name = foundsDetail.name;
    founds.nown = foundsDetail.nown;
    founds.totaln = foundsDetail.totaln;
    founds.type = foundsDetail.type;
    founds.localNumner = @"1";
    [[FoundsCarManager share] deleteFoundsToCar:founds];
    [self reloadData];
}

@end
