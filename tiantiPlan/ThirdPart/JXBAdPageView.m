//
//  JXBAdPageView.m
//  XBAdPageView
//
//  Created by Peter Jin mail:i@Jxb.name on 15/5/13.
//  Github ---- https://github.com/JxbSir
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "JXBAdPageView.h"

@interface JXBAdPageView()<UIScrollViewDelegate>
@property (nonatomic,assign)int                 indexShow;
@property (nonatomic,copy)NSArray               *arrImage;
@property (nonatomic,strong)UIScrollView        *scView;
@property (nonatomic,strong)UIImageView         *imgPrev;
@property (nonatomic,strong)UIImageView         *imgCurrent;
@property (nonatomic,strong)UIImageView         *imgNext;
@property (nonatomic,strong)NSTimer             *myTimer;
@property (nonatomic,strong)JXBAdPageCallback   myBlock;
@end

@implementation JXBAdPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [_scView setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:_scView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
    
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgPrev.contentMode = UIViewContentModeScaleToFill;
    _imgPrev.userInteractionEnabled = NO;
    _imgPrev.image = [UIImage imageNamed:@"icon_default_ad"];
    
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent.contentMode = UIViewContentModeScaleToFill;
    _imgCurrent.image = [UIImage imageNamed:@"icon_default_ad"];
    
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext.contentMode = UIViewContentModeScaleToFill;
    _imgNext.image = [UIImage imageNamed:@"icon_default_ad"];
    
    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 10 , self.frame.size.width, 0)];
    _pageControl.currentPageIndicatorTintColor = DSColor;
    _pageControl.pageIndicatorTintColor = DSColorFromHex(0xD8D8D8);
    [self addSubview:_pageControl];
}

/**
 *  启动函数
 *
 *  @param imageArray 图片数组
 *  @param block      click回调
 */
- (void)startAdsWithBlock:(NSArray*)imageArray block:(JXBAdPageCallback)block {
    if (imageArray.count == 0) {
        return;
    }
    if(imageArray.count <= 1)
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _pageControl.numberOfPages = imageArray.count;
    _arrImage = imageArray;
    self.myBlock = block;
    [self reloadImages];
}

/**
 *  点击广告
 */
- (void)tapAds
{
    if (self.myBlock != nil) {
        self.myBlock(_indexShow);
    }
}

/**
 *  加载图片顺序
 */
- (void)reloadImages {
    if (self.arrImage.count == 1) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
    
    if (_indexShow >= (int)_arrImage.count)
        _indexShow = 0;
    if (_indexShow < 0)
        _indexShow = (int)_arrImage.count - 1;
    int prev = _indexShow - 1;
    if (prev < 0)
        prev = (int)_arrImage.count - 1;
    int next = _indexShow + 1;
    if (next > _arrImage.count - 1)
        next = 0;
    _pageControl.currentPage = _indexShow;
    if (prev < 0) return;
    NSString* prevImage = [_arrImage objectAtIndex:prev];
    NSString* curImage = [_arrImage objectAtIndex:_indexShow];
    NSString* nextImage = [_arrImage objectAtIndex:next];
    if(_bWebImage)
    {
#warning TODO 这里有问题啊，会挂，找原因 image的页面消失要dealoc
        if(_delegate != nil && [_delegate respondsToSelector:@selector(setWebImage:imgUrl:withIndex:)])
        {
            [_delegate setWebImage:_imgPrev imgUrl:prevImage withIndex:prev];
            [_delegate setWebImage:_imgCurrent imgUrl:curImage withIndex:_indexShow];
            [_delegate setWebImage:_imgNext imgUrl:nextImage withIndex:next];
        }
        else
        {
            _imgPrev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prevImage]]];
            _imgCurrent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curImage]]];
            _imgNext.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextImage]]];
        }
    }
    else
    {
        _imgPrev.image = [UIImage imageNamed:prevImage];
        _imgCurrent.image = [UIImage imageNamed:curImage];
        _imgNext.image = [UIImage imageNamed:nextImage];
    }
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    if (_iDisplayTime > 0)
        [self startTimerPlay];
}

/**
 *  切换图片完毕事件
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.arrImage.count == 1) {
        return;
    }
    
    if (scrollView.contentOffset.x >=self.frame.size.width*2)
        _indexShow++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        _indexShow--;
    [self reloadImages];
}

/**手指操作时计时器停止工作，松开手后计时器重新开始计时*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
    [_myTimer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewWillBeginDragging");
    _myTimer = nil;
    if (_myTimer == nil) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:YES];
    }
}

- (void)startTimerPlay {
    if (_myTimer == nil) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:YES];
    }
}

/**
 *  轮播图片
 */
- (void)doImageGoDisplay {
    if (self.arrImage.count == 1) {
        self.pageControl.hidden = YES;
        return;
    } else {
        self.pageControl.hidden = NO;
    }
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    _indexShow++;
    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
}

@end
