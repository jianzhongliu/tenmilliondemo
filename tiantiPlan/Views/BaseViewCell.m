//
//  BaseViewCell.m
//  DianSongBDTool
//
//  Created by liujianzhong on 15/8/1.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewCell.h"

@interface BaseViewCell ()

@property (nonatomic, strong) UIView *viewLine;

@end

@implementation BaseViewCell

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = DSLineSepratorColor;
//        _viewLine.layer.shadowColor = DSLineSepratorColor.CGColor;
//        _viewLine.layer.shadowOffset = CGSizeMake(SCREENWIDTH, 2);
    }
    return _viewLine;
}


#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initBaseUI];
    }
    return self;
}

- (void)initBaseUI {
//    self.viewBackGround.frame = self.contentView.bounds;
//    self.viewBackGround.ctTop = 13;
//    self.viewBackGround.ctWidth = SCREENWIDTH;
//    self.viewBackGround.ctHeight = 0;
//    [self.contentView addSubview:self.viewBackGround];
}

- (void)configCellWithData:(id) celldata {
    
}

- (CGFloat)fetchCellHight {
    
    return 0;
}

- (void)showUnderLineAt:(CGFloat) Y {
    [self.viewLine removeFromSuperview];
    self.viewLine.frame = CGRectMake(0, Y - 1, SCREENWIDTH, 1);
    [self.contentView addSubview:self.viewLine];
}

- (void)showUnderLineAt:(CGFloat) Y withX:(CGFloat) X{
    [self.viewLine removeFromSuperview];
    self.viewLine.frame = CGRectMake(X, Y - 1, SCREENWIDTH - X, 1);
    [self.contentView addSubview:self.viewLine];
}

- (void)addLineToCellAt:(CGFloat) Y {
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, Y-1, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = DSColorAlphaMake(0, 0, 0, 0.1);
    [self.contentView addSubview:viewLine];
}

@end
