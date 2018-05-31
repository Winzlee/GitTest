//
//  UITabBar+Badge.h
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/13.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;
//移除小红点
- (void)removeBadgeOnItemIndex:(int)index;

@end
