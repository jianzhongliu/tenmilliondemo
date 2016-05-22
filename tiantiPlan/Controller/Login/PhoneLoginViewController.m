//
//  PhoneLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/29.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"

@interface PhoneLoginViewController ()

@property (nonatomic, strong) UIButton *buttonForgetPass;
@property (nonatomic, strong) UIButton *buttonRegister;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPass;

@property (nonatomic, strong) UITextField *textName;
@property (nonatomic, strong) UITextField *textPass;

@property (nonatomic, strong) UIButton *buttonLogin;

@end


@implementation PhoneLoginViewController
#pragma mark - getter&&setter

- (UIButton *)buttonForgetPass {
    if (_buttonForgetPass == nil) {
        _buttonForgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonForgetPass setTitle:@"忘记密码？" forState:UIControlStateNormal];
//        [_buttonForgetPass setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_buttonForgetPass setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonForgetPass addTarget:self action:@selector(didClickForgetPass) forControlEvents:UIControlEventTouchUpInside];
        _buttonForgetPass.font = [UIFont systemFontOfSize:13];
        _buttonForgetPass.selected = NO;
    }
    return _buttonForgetPass;
}

- (UIButton *)buttonRegister {
    if (_buttonRegister == nil) {
        _buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
//        [_buttonRegister setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_buttonRegister setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonRegister addTarget:self action:@selector(didClickRegister) forControlEvents:UIControlEventTouchUpInside];
        _buttonRegister.font = [UIFont systemFontOfSize:13];
        _buttonRegister.selected = NO;
    }
    return _buttonRegister;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = DSBackColor;
        _labelName.font = [UIFont systemFontOfSize:13];
    }
    return _labelName;
}

- (UILabel *)labelPass {
    if (_labelPass == nil) {
        _labelPass = [[UILabel alloc] init];
        _labelPass.numberOfLines = 0;
        _labelPass.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPass.textColor = DSBackColor;
        _labelPass.font = [UIFont systemFontOfSize:13];
    }
    return _labelPass;
}

- (UITextField *)textName {
    if (_textName == nil) {
        _textName = [[UITextField alloc] init];
        _textName.clearsOnBeginEditing = YES;
        _textName.font = [UIFont systemFontOfSize:13];
//        _textName.textColor = [UIColor whiteColor];
    }
    return _textName;
}

- (UITextField *)textPass {
    if (_textPass == nil) {
        _textPass = [[UITextField alloc] init];
        _textPass.clearsOnBeginEditing = YES;
        _textPass.secureTextEntry = YES;
    }
    return _textPass;
}


- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_name_pass"];
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)buttonLogin {
    if (_buttonLogin == nil) {
        _buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonLogin setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonLogin addTarget:self action:@selector(didClickLogin) forControlEvents:UIControlEventTouchUpInside];
        [_buttonLogin setTitle:@"登录" forState:UIControlStateNormal];
        _buttonLogin.selected = NO;
    }
    return _buttonLogin;
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
    self.buttonForgetPass.frame = CGRectMake(10, 80, 80, 20);
    [self.buttonForgetPass setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.view addSubview:self.buttonForgetPass];
    
    self.buttonRegister.frame = CGRectMake(SCREENWIDTH - 70, 80, 60, 30);
    [self.view addSubview:self.buttonRegister];
    
    self.imageView.frame = CGRectMake(10, self.buttonRegister.ctBottom + 10, SCREENWIDTH - 20, 86);
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    self.labelName.frame = CGRectMake(10, 10, 70, 20);
    self.labelName.text = @"用户名：";
    [self.imageView addSubview:self.labelName];
    
    self.textName.frame = CGRectMake(self.labelName.ctRight + 10, 10, SCREENWIDTH - 110, 25);
    self.textName.placeholder = @"手机号码";
    [self.imageView addSubview:self.textName];
    
    self.labelPass.frame = CGRectMake(10, 55, 70, 20);
    self.labelPass.text = @"密码：";
    [self.imageView addSubview:self.labelPass];
    
    self.textPass.frame = CGRectMake(self.labelPass.ctRight + 10, 55, SCREENWIDTH - 110, 25);
    [self.imageView addSubview:self.textPass];
    
    self.buttonLogin.frame = CGRectMake(10, self.imageView.ctBottom + 20, SCREENWIDTH - 20, 44);
    [self.view addSubview:self.buttonLogin];
}

- (void)didClickForgetPass {
    ForgetPasswordViewController *controller = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickRegister {
    RegisterViewController *controller = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickLogin {

}

@end
