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

@interface OrderPayDetailViewController () <IapppayKitPayRetDelegate>

@property (nonatomic, strong) NSString *mCheckResultKey;    //验签密钥

@end

@implementation OrderPayDetailViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(10, 400, 50, 50);
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(didShowTool) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)didShowTool {
    IapppayOrderUtils *orderInfo = [[IapppayOrderUtils alloc] init];
    orderInfo.appId         = mOrderUtilsAppId;
    orderInfo.cpPrivateKey  = mOrderUtilsCpPrivateKey;
    orderInfo.notifyUrl     = mOrderUtilsNotifyurl;
    orderInfo.cpOrderId     = [self generateTradeNO];
    orderInfo.waresId       = @"1";
    orderInfo.price         = @"0.1";
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
    
}

- (void)initUI {
    [self setTitle:@""];
    
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
            [self showToastInfo:@"支付成功，验签失败"];
        }
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
