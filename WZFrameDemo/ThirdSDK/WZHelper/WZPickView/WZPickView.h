//
//  WZPickView.h
//  WZPickView
//
//  Created by liwenzhi on 14-11-18.
//  Copyright (c) 2014年 lwz. All rights reserved.
//
//  选择器

#import <UIKit/UIKit.h>
@class WZPickView;
/**
 *  WZPickView选择器代理方法
 */
@protocol WZPickViewDelegate <NSObject>

@optional
-(void)toobarDonBtnHaveClick:(WZPickView *)pickView resultString:(NSString *)resultString tag:(NSInteger)tag;

@end

@interface WZPickView : UIView

@property(nonatomic,weak) id<WZPickViewDelegate> delegate;

/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName          plist文件的名字

 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过数组array添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *  @param tag                被点击按钮的tag
 *  @param title              toolBar中间显示的文字
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler tag:(NSInteger)tag title:(NSString *)title;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *  @param tag                区分被点击对象的tag
 *
 *  @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler tag:(NSInteger)tag;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColor:(UIColor *)color;
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color;
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color;
@end


