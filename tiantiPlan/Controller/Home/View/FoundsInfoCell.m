//
//  HomeHotOfficeViewCell.m
//  3laz
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsInfoCell.h"
#import "UIImageView+AFNetworking.h"
#import "UILabel+HightLight.h"
#import "ProgressView.h"
#import "NSString+RTStyle.h"
#import "RTLabel.h"

@interface FoundsInfoCell ()

@property (nonatomic, strong) ProgressView *viewProgress;
@property (nonatomic, strong) UILabel *labelBuildingName;
@property (nonatomic, strong) UILabel *labelLackNumber;
@property (nonatomic, strong) UIView *viewLine;

@end

@implementation FoundsInfoCell

- (ProgressView *)viewProgress {
    if (_viewProgress == nil) {
        _viewProgress = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, 90, 10)];
    }
    return _viewProgress;
}

- (UIImageView *)imageOffice {
    if (_imageOffice == nil) {
        _imageOffice = [[UIImageView alloc] init];
        _imageOffice.clipsToBounds = YES;
        _imageOffice.userInteractionEnabled = YES;
        _imageOffice.backgroundColor = DSColor;
    }
    return _imageOffice;
}

- (UILabel *)labelBuildingName {
    if (_labelBuildingName == nil) {
        _labelBuildingName = [[UILabel alloc] init];
        //        _labelBuildingName.numberOfLines = 0;
        //        _labelBuildingName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelBuildingName.textAlignment = NSTextAlignmentLeft;
        _labelBuildingName.textColor = DSGrayColor3;
        _labelBuildingName.font = [UIFont boldSystemFontOfSize:17];
        _labelBuildingName.text = @"";
    }
    return _labelBuildingName;
}

- (UILabel *)labelLackNumber {
    if (_labelLackNumber == nil) {
        _labelLackNumber = [[UILabel alloc] init];
        _labelLackNumber.numberOfLines = 0;
        _labelLackNumber.lineBreakMode = NSLineBreakByCharWrapping;
        _labelLackNumber.textAlignment = NSTextAlignmentLeft;
        _labelLackNumber.textColor = DSRedColor;
        _labelLackNumber.font = [UIFont systemFontOfSize:10];
        _labelLackNumber.text = @"";
    }
    return _labelLackNumber;
}

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.layer.borderWidth = 1;
        _viewLine.layer.borderColor = DSLineSepratorColor.CGColor;
    }
    return _viewLine;
}


- (UIButton *)buttonAdd {
    if (_buttonAdd == nil) {
        _buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonAdd addTarget:self action:@selector(onClickButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _buttonAdd.selected = NO;
        [_buttonAdd setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_buttonAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonAdd.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonAdd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonAdd;
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
    self.imageOffice.frame = CGRectMake(15, 15, 109, 73);
    self.labelBuildingName.frame = CGRectMake(self.imageOffice.ctRight + 10, 12, SCREENWIDTH-150, 22);
    self.viewProgress.frame = CGRectMake(self.imageOffice.ctRight + 10, self.labelBuildingName.ctBottom + 12 , 90, 10);
    self.labelLackNumber.frame = CGRectMake(self.imageOffice.ctRight + 10, self.viewProgress.ctBottom+12, 200, 18);

    self.viewLine.frame = CGRectMake(15, self.imageOffice.ctBottom + 15, SCREENWIDTH - 30, 1);
    self.buttonAdd.frame = CGRectMake(SCREENWIDTH - 60, (104 - 40)/2, 40, 40);
    [self.contentView addSubview:self.viewLine];
    [self.contentView addSubview:self.imageOffice];
    [self.contentView addSubview:self.labelBuildingName];
    [self.contentView addSubview:self.viewProgress];
    [self.contentView addSubview:self.labelLackNumber];
    [self.contentView addSubview:self.buttonAdd];

}

- (void)onClickButtonAction {
    if (_delegate && [_delegate respondsToSelector:@selector(foundsInfoCell:)]) {
        [_delegate foundsInfoCell:self];
    }
}

- (void)configCellWithData:(FoundsModel *) foundsModel{
    self.foundsData = foundsModel;
    self.labelBuildingName.text = foundsModel.name;

    NSArray *arrayImage = [foundsModel.images componentsSeparatedByString:@"|"];
    if (arrayImage.count > 1) {
        [self.imageOffice setImageWithURL:[NSURL URLWithString:arrayImage[0]] placeholderImage:[UIImage imageNamed:@"icon_building_list"]];
    }
    CGFloat rate = [foundsModel.nown floatValue] / [foundsModel.totaln floatValue];
    if (rate >= 0 && rate <= 1) {
        [self.viewProgress setProgress:rate];
    }
    
    self.labelLackNumber.text = [NSString stringWithFormat:@"剩余%ld人次", [foundsModel.totaln integerValue] - [foundsModel.nown integerValue]];
    
}

- (CGFloat)fetchCellHight {
    return 104;
}


@end
