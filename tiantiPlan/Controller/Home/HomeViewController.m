//
//  HomeViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeViewController.h"
#import "JXBAdPageView.h"
#import "UIImageView+WebCache.h"
#import "HomeFirstViewCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, JXBAdPageViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXBAdPageView *viewAD;

@end

@implementation HomeViewController
- (JXBAdPageView *)viewAD {
    if (_viewAD == nil) {
        _viewAD = [[JXBAdPageView alloc] init];
        _viewAD.delegate = self;
        _viewAD.iDisplayTime = 3;
        _viewAD.bWebImage = YES;
    }
    return _viewAD;
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
    [self setTitle:@"首页"];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    self.tableView.tableHeaderView = self.viewAD;
    [self.viewAD startAdsWithBlock:@[@1,@2] block:^(NSInteger clickIndex){
//        if (arrayData.count > clickIndex) {
//            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedADitem:)]) {
//                [_delegate didSelectedADitem:data[clickIndex]];
//            }
//        }
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    HomeFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[HomeFirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell showUnderLineAt:140];
    }
    [cell configCellWithData:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger ) index {
    if (self == nil) {
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://img.1yyg.com/Poster/20140918182340689.jpg"];
    [imgView sd_setImageWithURL:url];
}

@end
