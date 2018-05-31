//
//  WZNoDataView.h
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZNoDataView : UIView


- (void)showInSuperView:(UIView *)superView withImageView:(NSString *)imageName withTipsString:(NSString *)tipsString;

- (void)showInSuperView:(UIView *)superView withTipsString:(NSString *)tipsString;

- (void)showInSuperView:(UIView *)superView withImageView:(NSString *)imageName;

- (void)showInSuperView:(UIView *)superView;

- (void)hidden;

@end
