//
//  WZUIHelper.h
//  Winzlee
//
//  Created by liwenzhi on 16/5/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WZUIHelper : NSObject

/**
 创建UILabel
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font;

/**
 创建UIButton
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(NSInteger)font normalImage:(NSString *)noremalName selectedImage:(NSString *)selectedImage target:(id)target selector:(SEL)selector;

/**
 创建UIImageView
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

/**
 创建UItextField
 */
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame font:(NSInteger)font text:(NSString *)text andPlaceholder:(NSString *)placeHolder;

/**
创建UIView
*/
+ (UIView *)createViewWithFrame:(CGRect)frame;

@end
