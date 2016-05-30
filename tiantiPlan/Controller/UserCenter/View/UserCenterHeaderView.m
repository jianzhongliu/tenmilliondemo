//
//  UserCenterHeaderView.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/22.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserCenterHeaderView.h"
#import "UIImageView+AFNetworking.h"
#import "UserCacheBean.h"
#import "DSConfig.h"

@interface UserCenterHeaderView ()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UIView *viewLine;


@end

@implementation UserCenterHeaderView

- (UIImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
        _imageIcon.layer.cornerRadius = 30;
        _imageIcon.clipsToBounds = YES;
    }
    return _imageIcon;
}

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = DSLineSepratorColor;
    }
    return _viewLine;
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
    self.imageIcon.frame = CGRectMake((SCREENWIDTH - 60)/2, (150-60)/2, 60, 60);
    [self addSubview:self.imageIcon];
    self.viewLine.frame = CGRectMake(0, 149, SCREENWIDTH, 0.5);
    [self addSubview:self.viewLine];
}

- (void)configViewWithData:(id) data {
    [self.imageIcon setImageWithURL:[NSURL URLWithString:[UserCacheBean share].userInfo.icon] placeholderImage:[UIImage imageNamed:@"icon_search_property_selected"]];
}

- (CGFloat)fetchViewHeight {
    return 0;
}
@end
