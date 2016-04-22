//
//  FoundsDetailViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsDetailViewController.h"
#import "FoundsDetailInfoViewCell.h"
#import "HistoryOwnerInfoViewCell.h"
#import "FoundsResultViewController.h"
#import "CommonViewCell.h"
#import "UIImageView+WebCache.h"
#import "JXBAdPageView.h"

@interface FoundsDetailViewController () <UITableViewDelegate, UITableViewDataSource, JXBAdPageViewDelegate, HistoryOwnerInfoViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXBAdPageView *viewAD;
@property (nonatomic, strong) NSMutableArray *arrayEnter;
@property (nonatomic, strong) UIButton *buttonCar;
@property (nonatomic, strong) UIButton *buttonBuy;

@end

@implementation FoundsDetailViewController

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

- (JXBAdPageView *)viewAD {
    if (_viewAD == nil) {
        _viewAD = [[JXBAdPageView alloc] init];
        _viewAD.delegate = self;
        _viewAD.iDisplayTime = 3;
        _viewAD.bWebImage = YES;
    }
    return _viewAD;
}

- (UIButton *)buttonCar {
    if (_buttonCar == nil) {
        _buttonCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCar addTarget:self action:@selector(onClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCar.selected = NO;
        [_buttonCar setBackgroundColor:DSRedColor];
        [_buttonCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonCar.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        _buttonCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonCar;
}

- (UIButton *)buttonBuy {
    if (_buttonBuy == nil) {
        _buttonBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonBuy addTarget:self action:@selector(onClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _buttonBuy.selected = NO;
        [_buttonBuy setBackgroundColor:DSColor];
        [_buttonBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonBuy.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _buttonBuy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonBuy;
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

- (void)dealloc {
    self.viewAD.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.arrayEnter = [NSMutableArray arrayWithObjects:@"往期揭晓",@"商品晒单", nil];
}

- (void)initUI {
    [self setTitle:@"商品详情"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    self.tableView.tableHeaderView = self.viewAD;
    [self.viewAD startAdsWithBlock:@[@"www",@"www"] block:^(NSInteger clickIndex){
        //        if (arrayData.count > clickIndex) {
        //            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedADitem:)]) {
        //                [_delegate didSelectedADitem:data[clickIndex]];
        //            }
        //        }
    }];
    
    self.buttonCar.frame = CGRectMake(0, self.view.ctBottom - 50, SCREENWIDTH / 2, 50);
    self.buttonBuy.frame = CGRectMake(SCREENWIDTH/2, self.view.ctBottom - 50, SCREENWIDTH/2, 50);
    [self.view addSubview:self.buttonCar];
    [self.view addSubview:self.buttonBuy];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return self.arrayEnter.count;
        }
            break;
        default:
            break;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 100;
        }
            break;
        case 1:
        {
            return 130;
        }
            break;
        case 2:
        {
            return 60;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            static NSString *identify = @"identify";
            FoundsDetailInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[FoundsDetailInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:100];
            }
            [cell configCellWithData:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *identify = @"identify";
            HistoryOwnerInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[HistoryOwnerInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:130];
                cell.delegate = self;
            }
            [cell configCellWithData:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *identify = @"identify";
            CommonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[CommonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:60];
            }
            [cell configCellWithData:self.arrayEnter[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
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

- (void)didViewResultDetail {
    FoundsResultViewController *controller = [[FoundsResultViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
