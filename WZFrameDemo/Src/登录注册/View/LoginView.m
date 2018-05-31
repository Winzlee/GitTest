//
//  ControllerView.m
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/16.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

-(void)loadSubViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    bgImageView.image = [UIImage imageNamed:@"login_bg"];
    bgImageView.userInteractionEnabled = YES;
    [self addSubview:bgImageView];
    
    UIImageView *bgWhiteView = [[UIImageView alloc]initWithFrame:CGRectMake((kWIDTH/8), kHEIGHT/2, (kWIDTH/4)*3, 240)];
    bgWhiteView.userInteractionEnabled = YES;
    [self addSubview:bgWhiteView];
    
    _account = [[CustomLoginView alloc]initWithFrame:CGRectMake(20, 10, bgWhiteView.width - 40, 40) imageName:@"手机图标" title:@"账号：" andPlaceHolder:@"请输入账号"];
    _account.textField.keyboardType = UIKeyboardTypeNumberPad;
    [bgWhiteView addSubview:_account];
    
    _passWord = [[CustomLoginView alloc]initWithFrame:CGRectMake(20, _account.bottom + 10, bgWhiteView.width - 40, 40) imageName:@"锁图标" title:@"密码：" andPlaceHolder:@"请输入密码"];
    _passWord.textField.secureTextEntry = YES;
    [bgWhiteView addSubview:_passWord];
    
    _logIn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logIn.frame = CGRectMake(20, _passWord.bottom + 10, bgWhiteView.width - 40, 40);
    [_logIn setTitle:@"登    录" forState:UIControlStateNormal];
    [_logIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _logIn.titleLabel.font = [UIFont systemFontOfSize:16];
    _logIn.backgroundColor = MyColor_Nav;
    _logIn.layer.cornerRadius = 2.5;
    _logIn.clipsToBounds = YES;
    [bgWhiteView addSubview:_logIn];
    
    _registerAccount = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerAccount.frame = CGRectMake(20, _logIn.bottom, 100, 30);
    [_registerAccount setTitle:@"新用户注册" forState:UIControlStateNormal];
    [_registerAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _registerAccount.titleLabel.font = [UIFont mysystemFontOfSize:13];
    _registerAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgWhiteView addSubview:_registerAccount];
    
    _forgetPassWord = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetPassWord.frame = CGRectMake(_logIn.right - 100, _logIn.bottom, 100, 30);
    [_forgetPassWord setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPassWord setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _forgetPassWord.titleLabel.font = [UIFont mysystemFontOfSize:13];
    _forgetPassWord.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [bgWhiteView addSubview:_forgetPassWord];
    
    
}




@end
