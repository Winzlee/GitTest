//
//  NavViewController.m
//  Winzlee
//
//  Created by liwenzhi on 15/10/12.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "NavViewController.h"
#import "LoginViewController.h"
#import "SCMainViewController.h"

static NSArray *loginAuthClassArray = nil;

@interface NavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavViewController
+ (void)initialize
{
    if (self == [NavViewController class]) {
        
//        loginAuthClassArray = [[NSArray alloc]  initWithObjects:
//                               nil];
    }
}
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [self initWithRootViewController:rootViewController setBarBack:MyColor_Nav];
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController setBarBack:(id)barBack
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if ([barBack isKindOfClass:[UIColor class]]) {
            [self setNavBarBackgoundWithColor:barBack];
        }else if ([barBack isKindOfClass:[UIImage class]]){
            [self setNavBarBackgoundWithImage:barBack];
        }
        self.view.layer.masksToBounds = YES;
        self.delegate = self;
        [self setTitleTextColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //左边缘右划返回上一级功能
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)setTitleTextColor
{
    // 设置导航条字体大小和颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont mysystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)setNavBarBackgoundWithImage:(UIImage *)image
{
    self.navigationBar.barTintColor = [UIColor clearColor];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        self.navigationBar.layer.contents = (id)image.CGImage;
    }
}

- (void)setNavBarBackgoundWithColor:(UIColor *)color
{
    self.navigationBar.alpha = 0.8f;
    self.navigationBar.barTintColor = color;
    self.navigationBar.translucent = NO;
}

#pragma mark logon auth

- (BOOL)needLogonAuth:(UIViewController *)viewController{
	BOOL need = NO;
	for (id class in loginAuthClassArray) {
		if ([[viewController class] isSubclassOfClass:class]) {
			need = YES;
			break;
		}
	}
	
	return need;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
    //如果当前是正在pop的过程，就禁止左边缘右划手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
	[super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //位于当前navgationController的第一个（[0]）viewController时需要设置手势代理，不响应。
    if ([viewController.class isSubclassOfClass:navigationController.childViewControllers[0].class]) {
    }else{
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    // 如果是SCMainViewController, 设置手势代理，不响应。
    if ([viewController.class isSubclassOfClass:[SCMainViewController class]]) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [super presentViewController:viewControllerToPresent animated:flag completion:nil];
}

@end
