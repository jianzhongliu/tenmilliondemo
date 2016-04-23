//
//  MoneyHistoryViewCell.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/23.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "MoneyHistoryViewCell.h"

@implementation MoneyHistoryViewCell

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)configCellWithData:(id) celldata{
    
}

- (CGFloat)fetchCellHight {
    return 0;
}


@end
