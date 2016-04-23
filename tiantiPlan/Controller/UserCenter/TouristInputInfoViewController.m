//
//  TouristInputInfoViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/3.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristInputInfoViewController.h"
#import "DSConfig.h"

@interface TouristInputInfoViewController ()



@end

@implementation TouristInputInfoViewController

#pragma mark- getter&&setter

- (UITextField *)textContent {
    if (_textContent == nil) {
        _textContent = [[UITextField alloc] init];
        _textContent.textColor = [UIColor blackColor];
        _textContent.textAlignment = NSTextAlignmentLeft;
//        _textContent.layer.borderColor = DSGrayColor9.CGColor;
//        _textContent.layer.borderWidth = 1;
        _textContent.layer.cornerRadius = 6;
        _textContent.font = [UIFont systemFontOfSize:14];
        _textContent.backgroundColor = [UIColor whiteColor];
        _textContent.placeholder = @"请输入昵称";
    }
    return _textContent;
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
    self.view.backgroundColor = DSBackColor;
    self.textContent.frame = CGRectMake(0, 74, SCREENWIDTH, 40);
    [self.view addSubview:self.textContent];
    [self setRightButtonWithTitle:@"确定"];
}

- (void)didRightClick {
    if ([_delegate respondsToSelector:@selector(didUploadInfoWith:tag:)]) {
        [_delegate didUploadInfoWith:self.textContent.text tag:self.tag];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
