//
//  FadbackViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/5/31.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FadbackViewController.h"

@interface FadbackViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation FadbackViewController
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = DSGrayColor3;
        _textView.text = @"一元云宝运营服务部联系方式\n\n邮箱：503519050@qq.com  \n   qq：503519050 \n";
//        _textView.editable = NO;
    }
    return _textView;
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
    [self setTitle:@"意见反馈"];
    self.textView.frame = CGRectMake(15, 200, SCREENWIDTH - 30, 200);
    self.textView.editable = NO;
    self.textView.dataDetectorTypes = UIDataDetectorTypeAddress;
    [self.view addSubview:self.textView];
}

@end
