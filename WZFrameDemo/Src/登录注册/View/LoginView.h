//
//  ControllerView.h
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/16.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLoginView.h"
@interface LoginView : UIView

/** 账号 */
@property (nonatomic , strong) CustomLoginView *account;
/** 密码 */
@property (nonatomic , strong) CustomLoginView *passWord;


@property (nonatomic , strong) UIButton *logIn;
@property (nonatomic , strong) UIButton *registerAccount;
@property (nonatomic , strong) UIButton *forgetPassWord;

-(void)loadSubViews;

@end
