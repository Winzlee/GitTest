//
//  SCSearchWarningView.h
//  SameCity
//
//  Created by 庞氏科技 on 2017/6/16.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SCSearchWarningView : UIView

@property (nonatomic, copy)void (^SearchWarningBlock)(NSString *phone, NSString *mac);
@property (nonatomic, copy)void (^HiddenViewBlock)();

- (instancetype)initWithSuperView:(UIView *)superView;
- (void)show;
- (void)hiddenWithTime:(CGFloat)time;

@end
