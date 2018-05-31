//
//  WZCAHelper.h
//  Winzlee
//
//  Created by liwenzhi on 14-11-28.
//  Copyright (c) 2014年 lwz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define kCAHelperAlphaAnimation @"opacity"                 // 淡入淡出动画
#define kCAHelperScaleAnimation @"transform.scale"         // 比例缩放动画
#define kCAHelperRotationAnimation @"transform.rotation"   // 旋转动画
#define kCAHelperPositionAnimation @"position"             // 平移位置动画

@interface WZCAHelper : CAAnimation

// 核心动画的基本动画
+ (CABasicAnimation *)myBasicAnimationWithType:(NSString *)animationType
                        Duration:(CFTimeInterval)duration
                            from:(NSValue *)from
                              to:(NSValue *)to
                    autoReverses:(BOOL)autoReverses;


// 核心动画的关键帧动画
+ (CAKeyframeAnimation *)myKeyFrameAnimationWithType:(NSString *)animationType
                                            Duration:(CFTimeInterval)duration
                                              values:(NSArray *)values
                                        autoReverses:(BOOL)autoReverses;

@end
