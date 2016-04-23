//
//  AddressManagerViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/23.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "AddressManagerViewController.h"

@interface AddressManagerViewController ()

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
    self.textName.frame = CGRectMake(0, 74, SCREENWIDTH, 60);
    self.textPhone.frame = CGRectMake(0, self.textName.ctBottom + 10, SCREENWIDTH, 60);
    self.textAddress.frame = CGRectMake(0, self.textPhone.ctBottom + 10, SCREENWIDTH, 60);
    [self.view addSubview:self.textName];
    [self.view addSubview:self.textPhone];
    [self.view addSubview:self.textAddress];
}

- (void)didRightClick {
    
}

@end
