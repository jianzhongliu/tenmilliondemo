//
//  FoundsCarListViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/22.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsCarListViewController.h"
#import "FoundsCarViewCell.h"

@interface FoundsCarListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *viewBanner;
@property (nonatomic, strong) UILabel *labelTotal;
@property (nonatomic, strong) UIButton *buttonPay;
@property (nonatomic, strong) UIView *viewLine;

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
        _labelTotal.text = @"合计：123";
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
}

- (void)initData {
    
}

- (void)initUI {
    [self setTitle:@"购物车"];
    self.tableView.frame = self.view.bounds;
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
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    }
    [cell configCellWithData:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
