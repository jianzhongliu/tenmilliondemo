//
//  FoundsCarViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/22.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "FoundsCarViewCell.h"

@interface FoundsCarViewCell ()

@property (nonatomic, strong) UIImageView *imageicon;
@property (nonatomic, strong) UILabel *lableTitle;
@property (nonatomic, strong) UITextView *textNumber;
@property (nonatomic, strong) UIButton *buttonAdd;
@property (nonatomic, strong) UIButton *buttonDelete;
@property (nonatomic, strong) UILabel *labelTotal;
@property (nonatomic, strong) UILabel *labelLess;
@property (nonatomic, strong) UIButton *buttonDealloc;
@property (nonatomic, strong) FoundsModel *foundsModel;

@end

@implementation FoundsCarViewCell
- (UIImageView *)imageicon {
    if (_imageicon == nil) {
        _imageicon = [[UIImageView alloc] init];
        _imageicon.clipsToBounds = YES;
        _imageicon.userInteractionEnabled = YES;
    }
    return _imageicon;
}

- (UILabel *)lableTitle {
    if (_lableTitle == nil) {
        _lableTitle = [[UILabel alloc] init];
        _lableTitle.numberOfLines = 0;
        _lableTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _lableTitle.textAlignment = NSTextAlignmentLeft;
        _lableTitle.textColor = DSBlackColor;
        _lableTitle.font = [UIFont systemFontOfSize:14];
        _lableTitle.text = @"";
    }
    return _lableTitle;
}

- (UITextView *)textNumber {
    if (_textNumber == nil) {
        _textNumber = [[UITextView alloc] init];
        _textNumber.font = [UIFont systemFontOfSize:13];
        _textNumber.textAlignment = NSTextAlignmentCenter;
//        _textNumber.borderStyle = UITextBorderStyleNone;
        _textNumber.layer.borderColor = DSColorMake(85, 185, 62).CGColor;
        _textNumber.layer.borderWidth = 1;
        _textNumber.editable = NO;
        _textNumber.layer.cornerRadius = 4;
        _textNumber.textColor = DSBlackColor;
//        _textNumber.placeholder = @"";
        _textNumber.text = @"1";
    }
    return _textNumber;
}

- (UIButton *)buttonAdd {
    if (_buttonAdd == nil) {
        _buttonAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonAdd addTarget:self action:@selector(addNumber) forControlEvents:UIControlEventTouchUpInside];
        _buttonAdd.selected = NO;
        [_buttonAdd setImage:[UIImage imageNamed:@"addNumImage_s"] forState:UIControlStateHighlighted];
        [_buttonAdd setImage:[UIImage imageNamed:@"addNumImage"] forState:UIControlStateNormal];
        [_buttonAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonAdd.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonAdd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonAdd;
}

- (UIButton *)buttonDelete {
    if (_buttonDelete == nil) {
        _buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDelete addTarget:self action:@selector(deleteNumber) forControlEvents:UIControlEventTouchUpInside];
        _buttonDelete.selected = NO;
        [_buttonDelete setImage:[UIImage imageNamed:@"subNumImage_s"] forState:UIControlStateHighlighted];
        [_buttonDelete setImage:[UIImage imageNamed:@"subNumImage"] forState:UIControlStateNormal];
        [_buttonDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonDelete.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonDelete.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonDelete;
}

- (UILabel *)labelTotal {
    if (_labelTotal == nil) {
        _labelTotal = [[UILabel alloc] init];
        _labelTotal.numberOfLines = 0;
        _labelTotal.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTotal.textAlignment = NSTextAlignmentLeft;
        _labelTotal.textColor = DSGrayColor9;
        _labelTotal.font = [UIFont systemFontOfSize:12];
        _labelTotal.text = @"总需：0";
    }
    return _labelTotal;
}

- (UILabel *)labelLess {
    if (_labelLess == nil) {
        _labelLess = [[UILabel alloc] init];
        _labelLess.numberOfLines = 0;
        _labelLess.lineBreakMode = NSLineBreakByCharWrapping;
        _labelLess.textAlignment = NSTextAlignmentLeft;
        _labelLess.textColor = DSRedColor;
        _labelLess.font = [UIFont systemFontOfSize:12];
        _labelLess.text = @"剩余：0";
    }
    return _labelLess;
}

- (UIButton *)buttonDealloc {
    if (_buttonDealloc == nil) {
        _buttonDealloc = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDealloc addTarget:self action:@selector(deallocFounds) forControlEvents:UIControlEventTouchUpInside];
        _buttonDealloc.selected = NO;
        [_buttonDealloc setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_buttonDealloc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonDealloc.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonDealloc.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonDealloc;
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
    self.imageicon.frame = CGRectMake(10, 10, 100, 100);
    self.lableTitle.frame = CGRectMake(self.imageicon.ctRight + 6, 10, SCREENWIDTH - 80, 30);
    self.labelTotal.frame = CGRectMake(self.imageicon.ctRight + 6, self.lableTitle.ctBottom , 100, 16);
    self.labelLess.frame = CGRectMake(self.imageicon.ctRight + 6, self.labelTotal.ctBottom, 100, 16);

    self.buttonDealloc.frame = CGRectMake(SCREENWIDTH - 50, (120 - 40)/2, 40, 40);
    
    self.textNumber.frame = CGRectMake(self.imageicon.ctRight + 10, self.labelLess.ctBottom + 10, 120, 30);
    self.buttonAdd.frame = CGRectMake(120-30, 0, 30, 30);
    self.buttonDelete.frame = CGRectMake(0, 0, 30, 30);
    [self.contentView addSubview:self.imageicon];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.textNumber];
    [self.contentView addSubview:self.labelTotal];
    [self.contentView addSubview:self.labelLess];
    [self.textNumber addSubview:self.buttonAdd];
    [self.textNumber addSubview:self.buttonDelete];
    [self.contentView addSubview:self.buttonDealloc];
}

- (void)addNumber {
    NSInteger currentNumber = [self.textNumber.text integerValue];
    if (currentNumber < 100) {
        self.textNumber.text = [NSString stringWithFormat:@"%ld", currentNumber + 1];
        if (_delegate && [_delegate respondsToSelector:@selector(foundsCarCell:doAddNumber:)]) {
            [_delegate foundsCarCell:self doAddNumber:self.foundsModel];
        }
    }

}

- (void)deleteNumber {
    NSInteger currentNumber = [self.textNumber.text integerValue];
    if (currentNumber > 1) {
        self.textNumber.text = [NSString stringWithFormat:@"%ld", currentNumber - 1];
        if (_delegate && [_delegate respondsToSelector:@selector(foundsCarCell:doDeleteNumber:)]) {
            [_delegate foundsCarCell:self doDeleteNumber:self.foundsModel];
        }
    }
}

- (void)deallocFounds {
    if (_delegate && [_delegate respondsToSelector:@selector(foundsCarCell:didDelete:)]) {
        [_delegate foundsCarCell:self didDelete:self.foundsModel];
    }
}

- (void)configCellWithData:(FoundsModel *) celldata {
    self.foundsModel = celldata;
    NSArray *arrayImage = [celldata.images componentsSeparatedByString:@"|"];
    if (arrayImage.count > 0) {
        [self.imageicon setImageWithURL:[NSURL URLWithString:arrayImage[0]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    }
    self.labelLess.text = [NSString stringWithFormat:@"剩余：%ld 人次", [celldata.totaln integerValue] - [celldata.nown integerValue]];
    self.labelTotal.text = [NSString stringWithFormat:@"总需：%@ 人次", celldata.totaln];
    self.lableTitle.text = celldata.name;
    self.textNumber.text = celldata.localNumner;
}

- (CGFloat)fetchCellHight {
    return 0;
}

@end
