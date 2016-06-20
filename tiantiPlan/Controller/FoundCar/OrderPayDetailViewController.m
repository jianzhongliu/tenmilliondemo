//
//  OrderPayDetailViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/20.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "OrderPayDetailViewController.h"
#import <IapppayKit/IapppayOrderUtils.h>
#import <IapppayKit/IapppayKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "FoundsCarManager.h"
#import "PayMethodListCell.h"
#import "FoundsListCell.h"
#import "FoundsApiManager.h"

@interface OrderPayDetailViewController () <UITableViewDelegate,UITableViewDataSource,IapppayKitPayRetDelegate>

@property (nonatomic, strong) NSString *mCheckResultKey;    //验签密钥
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayFounds;

@property (nonatomic, strong) UIView *viewBanner;
@property (nonatomic, strong) UILabel *labelTotal;
@property (nonatomic, strong) UIButton *buttonPay;

@end

@implementation OrderPayDetailViewController

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

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mCheckResultKey = mOrderUtilsCheckResultKey;
    [[IapppayKit sharedInstance] setAppId:mOrderUtilsAppId mACID:mOrderUtilsChannel];
    [self initUI];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)onClickButtonPay {
    IapppayOrderUtils *orderInfo = [[IapppayOrderUtils alloc] init];
    orderInfo.appId         = mOrderUtilsAppId;
    orderInfo.cpPrivateKey  = mOrderUtilsCpPrivateKey;
    orderInfo.notifyUrl     = mOrderUtilsNotifyurl;
    orderInfo.cpOrderId     = [self generateTradeNO];
    orderInfo.waresId       = @"1";
    orderInfo.price         = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
    orderInfo.appUserId     = [UserCacheBean share].userInfo.userId;
    orderInfo.waresName     = @"商品名称";
    orderInfo.cpPrivateInfo = @"商品详细信息";
    
    NSString *trandInfo = [orderInfo getTrandData];
    [[IapppayKit sharedInstance] makePayForTrandInfo:trandInfo payDelegate:self];
}

/**
 * 获取订单号(此处是随机生成的唯一)
 **/
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)initData {
    self.arrayFounds = [NSMutableArray array];
    [self.arrayFounds addObjectsFromArray:[[FoundsCarManager share] fetchLocalFoundsCar]];
}

- (void)initUI {
    [self setTitle:@""];
    self.tableView.frame = CGRectMake(0, 0, SCREENWIDTH, self.view.ctHeight - 50);
    [self.view addSubview:self.tableView];
    self.viewBanner.frame = CGRectMake(0, self.view.ctBottom - 100, SCREENWIDTH, 50);
    self.labelTotal.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 50);
    self.buttonPay.frame = CGRectMake(SCREENWIDTH - 100, 10, 80, 30);
    [self.view addSubview:self.viewBanner];
    [self.viewBanner addSubview:self.labelTotal];
    [self.viewBanner addSubview:self.buttonPay];
    self.labelTotal.text = [NSString stringWithFormat:@"总计：%ld", [[FoundsCarManager share] foundsNumber]];
}

- (void)reqeustPaySuccess {
    [self doLoginWithBlock:^(UserCacheBean *userInfo, LOGINSTATUS status) {
        NSArray *array = [NSArray arrayWithArray:[[FoundsCarManager share] fetchLocalFoundsCar]];
        [self showLoading];
        for (FoundsModel *foundsDetail in array) {
            [[FoundsCarManager share] deleteLocalCar:foundsDetail.identify];
            [FoundsApiManager requestHistoryFoundsById:foundsDetail.identify userId:[UserCacheBean share].userInfo.userId buyNumber:foundsDetail.localNumner ResultListModel:^(id response) {
                [self hiddenLoading];
                [self showToastInfo:@"支付成功"];
                [self popViewControllerDelay];
            }];
        }
        
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.arrayFounds.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH, 40)];
    [view addSubview:label];
    switch (section) {
        case 0:
        {
            label.text = @"支付方式";
        }
            break;
        case 1:
        {
            label.text = @"商品详情";
            UILabel *labelTotal = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 30, 40)];
            labelTotal.text = [NSString stringWithFormat:@"￥ %ld", [[FoundsCarManager share] foundsNumber]];
            labelTotal.textAlignment = NSTextAlignmentRight;
            labelTotal.textColor = DSGrayColor9;
            [view addSubview:labelTotal];
        }
            break;
        default:
            break;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            static NSString *identify = @"identify";
            PayMethodListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[PayMethodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:50];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *identify = @"identify";
            FoundsListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[FoundsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:50];
            }
            [cell configCellWithData:self.arrayFounds[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - IapppayKitPayRetDelegate
- (void)iapppayKitRetPayStatusCode:(IapppayKitPayRetCodeType)statusCode
                        resultInfo:(NSDictionary *)resultInfo
{
    NSLog(@"statusCode : %d, resultInfo : %@", (int)statusCode, resultInfo);
    
    if (statusCode == IAPPPAY_PAYRETCODE_SUCCESS)
    {
        BOOL isSuccess = [IapppayOrderUtils checkPayResult:resultInfo[@"Signature"]
                                                withAppKey:self.mCheckResultKey];
        if (isSuccess) {
            //支付成功，验签成功
            [self showToastInfo:@"支付成功，验签成功"];
        } else {
            //支付成功，验签失败
//            [self showToastInfo:@"支付成功，验签失败"];
        }
        [self reqeustPaySuccess];
    }
    else if (statusCode == IAPPPAY_PAYRETCODE_FAILED)
    {
        //支付失败
        NSString *message = @"支付失败";
        if (resultInfo != nil) {
            message = [NSString stringWithFormat:@"%@:code:%@\n（%@）",message,resultInfo[@"RetCode"],resultInfo[@"ErrorMsg"]];
        }
        
        [self showToastInfo:message];
    }
    else
    {
        //支付取消
        NSString *message = @"支付取消";
        if (resultInfo != nil) {
            message = [NSString stringWithFormat:@"%@:code:%@\n（%@）",message,resultInfo[@"RetCode"],resultInfo[@"ErrorMsg"]];
        }
        [self showToastInfo:message];
    }
}

@end
