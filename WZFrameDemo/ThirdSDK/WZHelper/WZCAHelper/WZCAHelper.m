//
//  WZCAHelper.m
//  Winzlee
//
//  Created by liwenzhi on 14-11-28.
//  Copyright (c) 2014年 lwz. All rights reserved.
//

#import "WZCAHelper.h"

@implementation WZCAHelper

// 核心动画的基本动画
+ (CABasicAnimation *)myBasicAnimationWithType:(NSString *)animationType
                        Duration:(CFTimeInterval)duration
                            from:(NSValue *)from
                              to:(NSValue *)to
                     autoReverses:(BOOL)autoReverses
{
    // 先实例化一个动画对象
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:animationType];
    // 设置属性
    [anim setDuration:duration];
    [anim setFromValue:from];
    [anim setToValue:to];
    [anim setAutoreverses:autoReverses];
    
    return anim;
}



// 核心动画的关键帧动画
+ (CAKeyframeAnimation *)myKeyFrameAnimationWithType:(NSString *)animationType
                                            Duration:(CFTimeInterval)duration
                                              values:(NSArray *)values
                                        autoReverses:(BOOL)autoReverses
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = animationType;
    [anim setDuration:duration];
//    anim.values = @[@0, @1.3, @1];
    anim.values = values;
//    [anim setAutoreverses:autoReverses];
    
    return anim;
}



@end
