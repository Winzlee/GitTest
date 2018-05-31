//
//  CommonViewController.h
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPKeyboardAvoidingTableView.h"


@interface CommonViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource>  {
    
@protected
    UITableView                             *_tableView;
    
    UITableView                             *_groupTableView;
    
    TPKeyboardAvoidingTableView             *_tpTableView;
    
    NSString                                *_pageInTime;
    
    CGFloat                                 mywidth;
    CGFloat                                 myheight;
}

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UITableView       *groupTableView;

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tpTableView;

@property (nonatomic, strong) NSString          *specialViewTitle;

@property (nonatomic, assign) BOOL              isNeedBackItem;//需不需要展示左侧ui,默认为yes展示
@property (nonatomic, assign) BOOL              isSearchLeftItem;//返回按钮宽度比较小
@property (nonatomic, assign) BOOL              isHasLeftBtn;//有无返回图标，有文字，默认为yes展示返回图标
@property (nonatomic, strong) NSString          *leftTItle;//左侧文字

@property (nonatomic, strong) UIBarButtonItem   *rightBtnItem;

@property (nonatomic, assign) BOOL              hasNav; //default is YES;

/**  添加返回按钮*/
- (void)addLeftTitle:(BOOL)isHasLeftBtn WithTitle:(NSString*)string WithController:(id)controller;
- (void)addLeftItem;

/**
 *  登录
 */
- (void)goToLogin;

+ (id)controller;


- (void)backForePage;//左边item


//工具方法计算visibileRect
- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;


@end
