//
//  AddressManagerViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/23.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "UserCenterApiManager.h"

@interface AddressManagerViewController ()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPhone;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) UITextField *textName;
@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UITextField *textAddress;

@end

@implementation AddressManagerViewController
- (UITextField *)textName {
    if (_textName == nil) {
        _textName = [[UITextField alloc] init];
        _textName.font = [UIFont systemFontOfSize:13];
        _textName.borderStyle = UITextBorderStyleNone;
        _textName.textColor = DSBlackColor;
        _textName.placeholder = @"请输入收货人姓名";
        _textName.backgroundColor = [UIColor whiteColor];
        _textName.text = @"";
    }
    return _textName;
}

- (UITextField *)textPhone {
    if (_textPhone == nil) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.font = [UIFont systemFontOfSize:13];
        _textPhone.borderStyle = UITextBorderStyleNone;
        _textPhone.textColor = DSBlackColor;
        _textPhone.placeholder = @"请输入收货人电话";
        _textPhone.backgroundColor = [UIColor whiteColor];
        _textPhone.text = @"";
    }
    return _textPhone;
}
- (UITextField *)textAddress {
    if (_textAddress == nil) {
        _textAddress = [[UITextField alloc] init];
        _textAddress.font = [UIFont systemFontOfSize:13];
        _textAddress.borderStyle = UITextBorderStyleNone;
        _textAddress.textColor = DSBlackColor;
        _textAddress.placeholder = @"请输入收货地址";
        _textAddress.backgroundColor = [UIColor whiteColor];
        _textAddress.text = @"";
    }
    return _textAddress;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.textColor = DSGrayColor3;
        _labelName.font = [UIFont systemFontOfSize:13];
        _labelName.text = @"  收件人姓名：";
        _labelName.backgroundColor = [UIColor whiteColor];
    }
    return _labelName;
}

- (UILabel *)labelPhone {
    if (_labelPhone == nil) {
        _labelPhone = [[UILabel alloc] init];
        _labelPhone.numberOfLines = 0;
        _labelPhone.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPhone.textAlignment = NSTextAlignmentLeft;
        _labelPhone.textColor = DSBlackColor;
        _labelPhone.font = [UIFont systemFontOfSize:13];
        _labelPhone.text = @"  收件人电话：";
        _labelPhone.backgroundColor = [UIColor whiteColor];
    }
    return _labelPhone;
}

- (UILabel *)labelAddress {
    if (_labelAddress == nil) {
        _labelAddress = [[UILabel alloc] init];
        _labelAddress.numberOfLines = 0;
        _labelAddress.lineBreakMode = NSLineBreakByCharWrapping;
        _labelAddress.textAlignment = NSTextAlignmentLeft;
        _labelAddress.textColor = DSBlackColor;
        _labelAddress.font = [UIFont systemFontOfSize:13];
        _labelAddress.text = @"  收件人地址：";
        _labelAddress.backgroundColor = [UIColor whiteColor];
    }
    return _labelAddress;
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
    [self setRightButtonWithTitle:@"提交"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    
}

- (void)initUI {
    [self setTitle:@"地址管理"];
    self.view.backgroundColor = DSBackColor;
    self.labelName.frame = CGRectMake(0, 74, 90, 60);
    self.textName.frame = CGRectMake(90, 74, SCREENWIDTH, 60);
    self.labelPhone.frame = CGRectMake(0, self.textName.ctBottom + 10, 90, 60);
    self.textPhone.frame = CGRectMake(90, self.textName.ctBottom + 10, SCREENWIDTH, 60);
    self.labelAddress.frame = CGRectMake(0, self.textPhone.ctBottom + 10, 90, 60);
    self.textAddress.frame = CGRectMake(90, self.textPhone.ctBottom + 10, SCREENWIDTH, 60);
    [self.view addSubview:self.labelName];
    [self.view addSubview:self.textName];
    [self.view addSubview:self.labelPhone];
    [self.view addSubview:self.textPhone];
    [self.view addSubview:self.labelAddress];
    [self.view addSubview:self.textAddress];
    
    NSArray *arrayAddressItem = [[UserCacheBean share].userInfo.address componentsSeparatedByString:@"|"];
    if (arrayAddressItem.count == 3) {
        self.textName.text = arrayAddressItem[0];
        self.textPhone.text = arrayAddressItem[1];
        self.textAddress.text = arrayAddressItem[2];
    }
}

- (void)didRightClick {
    
    if (self.textName.text == nil) {
        [self showToastInfo:@"请输入收件人姓名"];
        return;
    }
    
    if (self.textPhone.text == nil) {
        [self showToastInfo:@"请输入收件人电话"];
        return;
    }
    
    if (self.textAddress.text == nil) {
        [self showToastInfo:@"请输入收件人详细地址"];
        return;
    }
    
    NSString *address = [NSString stringWithFormat:@"%@|%@|%@",self.textName.text,self.textPhone.text,self.textAddress.text];
    [UserCenterApiManager requestUpdateUserInfo:@{@"userId":[UserCacheBean share].userInfo.userId==nil?@"":[UserCacheBean share].userInfo.userId, @"name":[UserCacheBean share].userInfo.name==nil?@"":[UserCacheBean share].userInfo.name, @"icon":[UserCacheBean share].userInfo.icon==nil?@"":[UserCacheBean share].userInfo.icon, @"address":address, @"date":[UserCacheBean share].userInfo.date==nil?@"":[UserCacheBean share].userInfo.date, @"phone":[UserCacheBean share].userInfo.phone==nil?@"":[UserCacheBean share].userInfo.phone} InfoModel:^(id response) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
