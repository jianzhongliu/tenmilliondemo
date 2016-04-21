//
//  CommonViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/21.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "CommonViewCell.h"

@interface CommonViewCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *imageDerector;

@end

@implementation CommonViewCell
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.textColor = DSBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:14];
        _labelTitle.text = @"";
    }
    return _labelTitle;
}

- (UIImageView *)imageDerector {
    if (_imageDerector == nil) {
        _imageDerector = [[UIImageView alloc] init];
        _imageDerector.clipsToBounds = YES;
        _imageDerector.userInteractionEnabled = YES;
        _imageDerector.image = [UIImage imageNamed:@"icon_derector"];
    }
    return _imageDerector;
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
    self.labelTitle.frame = CGRectMake(15, 0, SCREENWIDTH - 30, 60);
    self.imageDerector.frame = CGRectMake(SCREENWIDTH - 22, 22, 7, 15);
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.imageDerector];
}

- (void)configCellWithData:(NSString *) title {
    self.labelTitle.text = title;
}

- (CGFloat)fetchCellHight {
    return 0;
}


@end
