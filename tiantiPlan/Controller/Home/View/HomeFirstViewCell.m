//
//  HomeFirstViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeFirstViewCell.h"
#import "FoundsCardCell.h"
#import "NSObject+AddKeyValueToObject.h"

@interface HomeFirstViewCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imageArrow;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation HomeFirstViewCell
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"即将结束";
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

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.labelTitle.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 30);
    self.imageArrow.frame = CGRectMake(SCREENWIDTH - 18, 7, 8, 15);
    self.viewLine.frame = CGRectMake(0, self.labelTitle.ctBottom, SCREENWIDTH, 1);
    [self addSubview:self.labelTitle];
    [self addSubview:self.imageArrow];
    [self addSubview:self.viewLine];
}

- (void)configCellWithData:(id) celldata{
    NSArray *arrayData = celldata;
    [self.arrayData removeAllObjects];
    [self.arrayData addObjectsFromArray:arrayData];
    if ([celldata isKindOfClass:[NSArray class]]) {
        for (NSInteger index = 0; index < 4 && arrayData.count >=4; index ++) {
            FoundsCardCell *cell = [[FoundsCardCell alloc] init];
            cell.frame = CGRectMake(index % 2 * SCREENWIDTH/2 - 0.5, index/2 * 90 + 30, SCREENWIDTH/2 + 1, 90+1);
            cell.layer.borderColor = DSRedColor.CGColor;
            cell.layer.borderWidth = 1;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFounds:)];
            [tap setObjectDSValue:@(index + 100)];
            [cell addGestureRecognizer:tap];
            [cell configViewWithData:arrayData[index]];
            [self addSubview:cell];
        }
    }

}

- (void)didTapFounds:(UITapGestureRecognizer *) gesture {
    NSInteger index = [gesture.objectDSValue integerValue] - 100;
    if (_delegate && [_delegate respondsToSelector:@selector(homeFirstViewCell:clickData:)]) {
        [_delegate homeFirstViewCell:self clickData:self.arrayData[index]];
    }
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
