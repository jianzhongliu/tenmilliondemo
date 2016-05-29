//
//  ThrowLineTool.m
//  CoreAnimationTest
//
//  Created by yh on 15/11/13.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "ThrowLineTool.h"

static ThrowLineTool *s_sharedInstance = nil;
@implementation ThrowLineTool

+ (ThrowLineTool *)sharedTool
{
    if (!s_sharedInstance) {
        s_sharedInstance = [[[self class] alloc] init];
    }
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
{
    self.showingView = obj;
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start.x+10, start.y+10)];
    //三点曲线
    [path addCurveToPoint:CGPointMake(end.x+25, end.y+25)
             controlPoint1:CGPointMake(start.x, start.y)
             controlPoint2:CGPointMake(start.x , start.y )];
    [self groupAnimation:path];
}


#pragma mark - 组合动画
-(void)groupAnimation:(UIBezierPath *)path
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.8f;
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.8f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 设定为缩放
    CABasicAnimation *animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animationScale.duration = 0.8; // 动画持续时间
    animationScale.repeatCount = 1; // 重复次数
    animationScale.autoreverses = YES; // 动画结束时执行逆动画
    // 缩放倍数
    animationScale.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animationScale.toValue = [NSNumber numberWithFloat:0.f]; // 结束时的倍率

    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation,animationScale];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.showingView.layer addAnimation:groups forKey:@"position scale"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.showingView.layer removeFromSuperlayer];
    self.showingView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish)]) {
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
}


@end

