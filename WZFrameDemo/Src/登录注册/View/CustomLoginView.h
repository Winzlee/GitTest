//
//  CustomLoginView.h
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/16.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomLoginView : UIView

/** textField */
@property (nonatomic , strong) UITextField *textField;
/** 提示的 textField*/
@property (nonatomic , strong) UITextField *hintTextField;

@property (nonatomic , strong) NSString * imageName;
@property (nonatomic , strong) NSString * placeHolder;

/** 有图片 有占位文字的view */
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title andPlaceHolder:(NSString *)placeHolder;

///** 有图片 有占位文字的view */
//+(instancetype)allocWithImageName:(NSString *)imageName andPlaceHolder:(NSString *)placeHolder;

@end
