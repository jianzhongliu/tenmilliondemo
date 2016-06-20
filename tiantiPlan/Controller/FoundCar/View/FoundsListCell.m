//
//  FoundsListCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/20.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsListCell.h"

@interface FoundsListCell ()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPrice;

@end

@implementation FoundsListCell
- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.textColor = DSBlackColor;
        _labelName.font = [UIFont systemFontOfSize:16];
        _labelName.text = @"";
    }
    return _labelName;
}

- (UILabel *)labelPrice {
    if (_labelPrice == nil) {
        _labelPrice = [[UILabel alloc] init];
        _labelPrice.numberOfLines = 0;
        _labelPrice.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPrice.textAlignment = NSTextAlignmentRight;
        _labelPrice.textColor = DSGrayColor9;
        _labelPrice.font = [UIFont systemFontOfSize:13];
        _labelPrice.text = @"";
    }
    return _labelPrice;
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
    self.labelName.frame = CGRectMake(15, 0, SCREENWIDTH - 100, 50);
    self.labelPrice.frame = CGRectMake(0, 0, SCREENWIDTH - 15, 50);
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelPrice];
}

- (void)configCellWithData:(FoundsModel *) celldata{
    self.labelName.text = celldata.name;
    self.labelPrice.text = [NSString stringWithFormat:@"%@ 人次",celldata.localNumner];
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
