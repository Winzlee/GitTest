//
//  SCSearchWarningView.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/6/16.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCSearchWarningView.h"
#import "CustomLoginView.h"


@interface SCSearchWarningView ()<UITextFieldDelegate>
{
    UIView      *_blackView;    //蒙版
    UIView      *_whiteView;
    CustomLoginView *_phoneView;
    CustomLoginView *_macView;
}
@end

@implementation SCSearchWarningView

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        [self createUIWithSuperView:superView];
    }
    return self;
}

#pragma mark - 创建视图

#pragma mark 弹出选择框
-(void)createUIWithSuperView:(UIView *)superView
{
    self.frame = CGRectMake(0, 0, superView.width, MSH - 64);
    self.backgroundColor = [UIColor clearColor];
    
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.0;
    [_blackView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackViewTouched:)]];
    [self addSubview:_blackView];
    
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, MSW, 150)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];
    
    
    
    _phoneView = [[CustomLoginView alloc]initWithFrame:CGRectMake(20, 10, _whiteView.width - 40, 40) imageName:@"" title:@"车主电话：" andPlaceHolder:@"请输入电话"];
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_whiteView addSubview:_phoneView];
    
    _macView = [[CustomLoginView alloc]initWithFrame:CGRectMake(20, _phoneView.bottom + 5, _whiteView.width - 40, 40) imageName:@"" title:@"MAC地址：" andPlaceHolder:@"请输入MAC地址"];
    [_whiteView addSubview:_macView];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(20, _macView.bottom + 10, _whiteView.width - 40, 35)];
    [sureButton setBackgroundColor:MyColor_Nav];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    [sureButton setTitle:@"搜索" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sureButton addTarget:self action:@selector(didClickSureButton) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:sureButton];
    
    
    [superView addSubview:self];
}


#pragma mark - 按钮响应事件

/**
 *  搜索
 */
- (void)didClickSureButton
{
    if (IsStrEmpty(_phoneView.textField.text) && IsStrEmpty(_macView.textField.text)) {
        [self showHUDTextAtCenter:@"请输入搜索内容"];
    }else{
        [self hiddenWithTime:0.1];
        self.SearchWarningBlock(_phoneView.textField.text,_macView.textField.text);
        self.HiddenViewBlock();
    }
}
/**
 *  关闭视图
 */
- (void)blackViewTouched:(UITapGestureRecognizer *)gesture
{
    [self hiddenWithTime:0.3];
    self.HiddenViewBlock();
}
/**
 *  关闭视图
 */
- (void)didClickCloseButton
{
    [self hiddenWithTime:0.3];
}

#pragma mark - public
/**
 *  展示该视图
 */
- (void)show
{
    self.hidden = NO;
    _blackView.hidden = NO;
    _blackView.alpha = 0.0;
    // _whiteView出现的时候添加动画效果
    _whiteView.frame = CGRectMake(0, -150, MSW, 150);
    [UIView animateWithDuration:0.3 animations:^{
        _blackView.alpha = 0.4;
        _whiteView.frame = CGRectMake(0, 0, MSW, 150);
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  隐藏该视图
 *
 *  @param time 动画持续时间
 */
- (void)hiddenWithTime:(CGFloat)time
{
    _blackView.hidden = YES;
    _blackView.alpha = 0.0;
    
    _phoneView.textField.text = @"";
    _macView.textField.text = @"";
    [_phoneView.textField resignFirstResponder];
    [_macView.textField resignFirstResponder];
    
    // _whiteView消失的时候添加动画效果
    [UIView animateWithDuration:time animations:^{
        _whiteView.frame = CGRectMake(0, -150, MSW, 150);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}



@end
