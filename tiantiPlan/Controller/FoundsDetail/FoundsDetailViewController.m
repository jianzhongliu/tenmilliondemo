//
//  FoundsDetailViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsHistoryOwnerListViewController.h"
#import "FoundsDetailViewController.h"
#import "FoundsDetailInfoViewCell.h"
#import "HistoryOwnerInfoViewCell.h"
#import "FoundsResultViewController.h"
#import "CommonViewCell.h"
#import "UIImageView+WebCache.h"
#import "JXBAdPageView.h"
#import "FoundsApiManager.h"
#import "FoundsDetailModel.h"
#import "FoundsCarManager.h"
#import "AppDelegate.h"

@interface FoundsDetailViewController () <UITableViewDelegate, UITableViewDataSource, JXBAdPageViewDelegate, HistoryOwnerInfoViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JXBAdPageView *viewAD;
@property (nonatomic, strong) NSMutableArray *arrayEnter;
@property (nonatomic, strong) UIButton *buttonAddToCar;
@property (nonatomic, strong) UIButton *buttonBuy;
@property (nonatomic, strong) FoundsDetailModel *foundsDetailModel;
@property (nonatomic, strong) UIButton *buttonCar;
@property (nonatomic, strong) UILabel *labelNumber;

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
        _viewAD = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, ImageHight)];
        _viewAD.delegate = self;
        _viewAD.iDisplayTime = 5;
        _viewAD.bWebImage = YES;
    }
    return _viewAD;
}

- (UIButton *)buttonAddToCar {
    if (_buttonAddToCar == nil) {
        _buttonAddToCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonAddToCar addTarget:self action:@selector(addFoundsToCar) forControlEvents:UIControlEventTouchUpInside];
        _buttonAddToCar.selected = NO;
        [_buttonAddToCar setBackgroundColor:DSRedColor];
        [_buttonAddToCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonAddToCar.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonAddToCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        _buttonAddToCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonAddToCar;
}

- (UIButton *)buttonBuy {
    if (_buttonBuy == nil) {
        _buttonBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonBuy addTarget:self action:@selector(onClickFoundsCar) forControlEvents:UIControlEventTouchUpInside];
        _buttonBuy.selected = NO;
        [_buttonBuy setBackgroundColor:DSColor];
        [_buttonBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonBuy.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _buttonBuy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonBuy;
}

- (UIButton *)buttonCar {
    if (_buttonCar == nil) {
        _buttonCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCar setImage:[UIImage imageNamed:@"icon_car"] forState:UIControlStateNormal];
        [_buttonCar setImage:[UIImage imageNamed:@"icon_car_seleted"] forState:UIControlStateHighlighted];
        [_buttonCar addTarget:self action:@selector(onClickFoundsCar) forControlEvents:UIControlEventTouchUpInside];
        _buttonCar.selected = NO;
        [_buttonCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonCar.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonCar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonCar;
}

- (UILabel *)labelNumber {
    if (_labelNumber == nil) {
        _labelNumber = [[UILabel alloc] init];
        _labelNumber.numberOfLines = 0;
        _labelNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelNumber.textAlignment = NSTextAlignmentCenter;
        _labelNumber.textColor = [UIColor whiteColor];
        _labelNumber.font = [UIFont systemFontOfSize:14];
        _labelNumber.text = @"";
        _labelNumber.layer.cornerRadius = 10;
        _labelNumber.clipsToBounds = YES;
        _labelNumber.backgroundColor = [UIColor redColor];
    }
    return _labelNumber;
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
    [self requestData];
}

- (void)dealloc {
    self.viewAD.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.arrayEnter = [NSMutableArray arrayWithObjects:@"往期揭晓", nil];
}

- (void)initUI {
    [self setTitle:@"商品详情"];
    self.tableView.frame = CGRectMake(0, 0 , SCREENWIDTH, self.view.ctHeight - 50);
    [self.view addSubview:self.tableView];
//    self.viewAD.frame = CGRectMake(0, 0, SCREENWIDTH, ImageHight);
    self.tableView.tableHeaderView = self.viewAD;
    
    self.buttonAddToCar.frame = CGRectMake(0, self.view.ctBottom - 50, SCREENWIDTH / 2, 50);
    self.buttonBuy.frame = CGRectMake(SCREENWIDTH/2, self.view.ctBottom - 50, SCREENWIDTH/2, 50);
    [self.view addSubview:self.buttonAddToCar];
    [self.view addSubview:self.buttonBuy];
    
    self.buttonCar.frame = CGRectMake(0, 0, 50, 50);
    self.labelNumber.frame = CGRectMake(30, 0, 20, 20);
    [self.buttonCar addSubview:self.labelNumber];
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonCar];

}

- (void)reloadData {
    NSArray *arrayImage = [self.foundsDetailModel.foundsDetailInfoModel.images componentsSeparatedByString:@"|"];
    [self.viewAD startAdsWithBlock:arrayImage block:^(NSInteger clickIndex){
        
    }];
    
    [self.tableView reloadData];
}

- (void)onClickFoundsCar {
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:NO];

    [[AppDelegate share] switchToTabBarItemIndex:1];
}

- (void)addFoundsToCar {
    FoundsModel *founds = [[FoundsModel alloc] init];
    founds.identify = self.foundsDetailModel.foundsDetailInfoModel.identify;
    founds.images = self.foundsDetailModel.foundsDetailInfoModel.images;
    founds.isover = self.foundsDetailModel.foundsDetailInfoModel.isover;
    founds.lastid = self.foundsDetailModel.foundsDetailInfoModel.lastid;
    founds.name = self.foundsDetailModel.foundsDetailInfoModel.name;
    founds.nown = self.foundsDetailModel.foundsDetailInfoModel.nown;
    founds.totaln = self.foundsDetailModel.foundsDetailInfoModel.totaln;
    founds.type = self.foundsDetailModel.foundsDetailInfoModel.type;
    founds.localNumner = @"1";
    [[FoundsCarManager share] addFoundsToCar:founds];
    self.labelNumber.text = [NSString stringWithFormat:@"%ld", [[FoundsCarManager share] foundsNumber]];
}

#pragma mark - HTTPRequest
- (void)requestData {
    [FoundsApiManager requestFoundsById:self.foundsId DetailInfoModel:^(id response) {
        if ([response isKindOfClass:[FoundsDetailModel class]]) {
            self.foundsDetailModel = response;
            [self reloadData];
        }
    }];
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
            [cell configCellWithData:self.foundsDetailModel.foundsDetailInfoModel];
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
            [cell configCellWithData:self.foundsDetailModel];
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
    switch (indexPath.section) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    FoundsHistoryOwnerListViewController *controller = [[FoundsHistoryOwnerListViewController alloc] init];
                    controller.foundsId = self.foundsId;
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger ) index {
    if (self == nil) {
        return;
    }
    NSArray *arrayImage = [self.foundsDetailModel.foundsDetailInfoModel.images componentsSeparatedByString:@"|"];
    NSURL *url = [NSURL URLWithString:arrayImage[index]];
    [imgView sd_setImageWithURL:url];
}

- (void)didViewResultDetail {
    FoundsResultViewController *controller = [[FoundsResultViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
