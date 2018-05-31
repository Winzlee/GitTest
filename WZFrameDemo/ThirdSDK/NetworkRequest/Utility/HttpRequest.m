//
//  HttpRequest.m
//  Connect
//
//  Created by JinJin on 2016/10/31.
//  Copyright © 2016年 GJQ. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

#pragma mark - 共享请求
+ (instancetype)sharedNetworkRequest
{
    static HttpRequest * httpRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequest = [[HttpRequest alloc] init];
    });
    return httpRequest;
}

//普通的请求
- (void)requestOrdinaryPostURL:(NSString*)url
                        params:(id)params
                        target:(id)target
                           hud:(BOOL)hud
                       success:(HttpRequestSuccessBlock)successBlock
                       failure:(HttpRequestFailureBlock)failureBlock
{
    // 显示 网络活动指标
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (hud ==YES && target!=nil)
    {
        [self showWaitingDialogHide:hud aTarget:target];
//        [MBProgressHUD showHUDAddedTo:target.view animated:YES];
    }
    
    
    [[HttpTools sharedNetwork]  POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏 网络活动指标
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (hud ==YES && target!=nil)
        {
            [self hideWaitingDialogHide:hud aTarget:target];
//            [MBProgressHUD hideHUDForView:target.view animated:YES];
        }
    
        if (successBlock)
        {
            
            if (JsonFailure)
            {
//                [XHToast showCenterWithText:JsonMessage duration:1.5];
            }
            
            successBlock(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 隐藏 网络活动指标
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (hud ==YES && target!=nil)
        {
            [self hideWaitingDialogHide:hud aTarget:target];
//            [MBProgressHUD hideHUDForView:target.view animated:YES];
        }
        
        // 提示
        if ([self connectionInternet] == NO)
        {
//            [XHToast showCenterWithText:NO_Network duration:1.5f];
        }
        else
        {
//            [XHToast showCenterWithText:NO_RequestFailure duration:1.5f];
        }

        failureBlock(error);
        
    }];

}


- (void)showWaitingDialogHide:(BOOL)hide aTarget:(UIViewController *)target
{
    // 没有设置显示showDailog和targetSuper时
    if (!hide || target == nil) {
        return;
    }
    
    // 需要显示的targetSuper不为ViewController时
    if (![target isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    //要显示waitingDialog 的 View
    UIView *view = nil;
    if ([target isKindOfClass:[UIViewController class]]) {
        view = (UIView *)(((UIViewController *)target).view);
    }
    
    // 创建waitingDialog 显示 MBProgressHUD
    if (self.waitingDialog == nil) {
        self.waitingDialog = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:self.waitingDialog];
        [(MBProgressHUD *)self.waitingDialog show:YES];
    }else {
        [view addSubview:self.waitingDialog];
        [(MBProgressHUD *)self.waitingDialog show:YES];
    }
}

- (void)hideWaitingDialogHide:(BOOL)hide aTarget:(UIViewController *)target
{
    
    // 没有设置显示showDailog和targetSuper时
    if (!hide || target == nil) {
        return;
    }
    
    // 需要显示的targetSuper不为View或者不为ViewController时
    if (![target isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    if (self.waitingDialog == nil) {
        return;
    }
    
    if ([self.waitingDialog isKindOfClass:[MBProgressHUD class]]) {
        [(MBProgressHUD *)self.waitingDialog hide:YES];
    }
    
    if (self.waitingDialog.superview) {
        [self.waitingDialog removeFromSuperview];
    }
}


#pragma mark - 判断有没有网络
-(BOOL)connectionInternet
{
    //1.发送网络请求
    Reachability *reach=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status=[reach currentReachabilityStatus];
    if(status==NotReachable){
        return NO; //没有网络
    }
    return YES;
}

@end
