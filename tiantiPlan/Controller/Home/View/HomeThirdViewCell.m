//
//  HomeThirdViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/19.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "HomeThirdViewCell.h"
#import "FoundsTypeCell.h"

@interface HomeThirdViewCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imageArrow;
@property (nonatomic, strong) UIView *viewLine;

@end

@implementation HomeThirdViewCell
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"热门分类";
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
#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.labelTitle.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 30);
    self.imageArrow.frame = CGRectMake(SCREENWIDTH - 18, 7, 8, 15);
    self.viewLine.frame = CGRectMake(0, self.labelTitle.ctBottom, SCREENWIDTH, 1);
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.imageArrow];
    [self.contentView addSubview:self.viewLine];
}

- (void)configCellWithData:(id) celldata{
    if ([celldata isKindOfClass:[NSArray class]]) {
        NSArray *arrayData = celldata;
        for (NSInteger index = 0; index < 4; index ++) {
            FoundsTypeCell *cell = [[FoundsTypeCell alloc] init];
            cell.frame = CGRectMake(index % 2 * SCREENWIDTH/2 - 0.5, index/2 * 90 + 30, SCREENWIDTH/2 + 1, 90+1);
            cell.layer.borderColor = DSRedColor.CGColor;
            cell.layer.borderWidth = 1;
            [cell configViewWithData:arrayData[index]];
            [self.contentView addSubview:cell];
        }
    }
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
