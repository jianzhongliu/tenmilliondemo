//
//  HomeSecondViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeSecondViewCell.h"
#import "FoundsProgressCardCell.h"
#import "NSObject+AddKeyValueToObject.h"

@interface HomeSecondViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imageArrow;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation HomeSecondViewCell
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = NO;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    }
    return _scrollView;
}

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"活跃区";
    }
    return _labelTitle;
}

- (UIImageView *)imageArrow {
    if (_imageArrow == nil) {
        _imageArrow = [[UIImageView alloc] init];
        _imageArrow.clipsToBounds = YES;
        _imageArrow.userInteractionEnabled = YES;
        _imageArrow.image = [UIImage imageNamed:@"icon_derector"];
    }
    return _imageArrow;
}

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = DSLineSepratorColor;
    }
    return _viewLine;
}

- (NSMutableArray *)arrayData {
    if (_arrayData == nil) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = CGRectMake(0, 30, SCREENWIDTH, 180);
    self.labelTitle.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 30);
    self.imageArrow.frame = CGRectMake(SCREENWIDTH - 18, 7, 8, 15);
    self.viewLine.frame = CGRectMake(0, self.labelTitle.ctBottom, SCREENWIDTH, 1);
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.imageArrow];
    [self.contentView addSubview:self.viewLine];
    [self.contentView addSubview:self.scrollView];
}

- (void)configCellWithData:(id) celldata{
    if ([celldata isKindOfClass:[NSArray class]]) {
        NSArray *arrayData = celldata;
        [self.arrayData removeAllObjects];
        [self.arrayData addObjectsFromArray:arrayData];
        for (NSInteger index = 0; index < arrayData.count; index ++ ) {
            FoundsProgressCardCell *cell = [[FoundsProgressCardCell alloc] init];
            cell.frame = CGRectMake(index* 120, 0, 120, 180);
            [cell configViewWithData:arrayData[index]];
            [self.scrollView addSubview:cell];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFounds:)];
            [tap setObjectDSValue:@(index + 100)];
            [cell addGestureRecognizer:tap];
            self.scrollView.contentSize = CGSizeMake(120 * (index + 1), 180);
        }
    }
}

- (void)didTapFounds:(UITapGestureRecognizer *) gesture {
    NSInteger index = [gesture.objectDSValue integerValue] - 100;
    if (_delegate && [_delegate respondsToSelector:@selector(homeSecondViewCell:clickData:)]) {
        [_delegate homeSecondViewCell:self clickData:self.arrayData[index]];
    }
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
