//
//  WZUIHelper.m
//  Winzlee
//
//  Created by liwenzhi on 16/5/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WZUIHelper.h"

@implementation WZUIHelper


+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont mysystemFontOfSize:font];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(NSInteger)font normalImage:(NSString *)noremalName selectedImage:(NSString *)selectedImage target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont mysystemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:noremalName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:imageName];
    
    return imageView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame font:(NSInteger)font text:(NSString *)text andPlaceholder:(NSString *)placeHolder
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.text = text;
    textField.textColor = [UIColor blackColor];
    textField.placeholder = placeHolder;
    textField.font = [UIFont mysystemFontOfSize:font];
    
    return textField;
}

+ (UIView *)createViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc]init];
    view.frame = frame;
    
    return view;
}


@end
