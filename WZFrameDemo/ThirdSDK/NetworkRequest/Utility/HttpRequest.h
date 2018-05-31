//
//  HttpRequest.h
//  Connect
//
//  Created by JinJin on 2016/10/31.
//  Copyright © 2016年 GJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpTools.h"
#import "Reachability.h"

@interface HttpRequest : NSObject

/* 普通请求成功 */
typedef void(^HttpRequestSuccessBlock)(id responseObject);

/* 请求失败 */
typedef void(^HttpRequestFailureBlock)(NSError * error);

/* 重试加载 */
typedef void(^HttpRequestRetryBlock)();


/**
 *  共享请求
 */
+ (instancetype)sharedNetworkRequest;

/**
 *  网络等待框
 *  waitingDialog 的frame覆盖到发送请求的targetSuper,如果只一次使用，设置完成后置为nil
 */
@property (nonatomic, strong)  UIView       *waitingDialog;

/**
 *  普通的请求
 *
 *  @param url              请求地址
 *  @param params           请求参数
 *  @param target           请求当前控制器
 *  @param hud              是否显示加载动画
 *  @param successBlock     成功回调
 *  @param failureBlock     失败回调
 */
- (void)requestOrdinaryPostURL:(NSString*)url
                        params:(id)params
                        target:(id)target
                           hud:(BOOL)hud
                       success:(HttpRequestSuccessBlock)successBlock
                       failure:(HttpRequestFailureBlock)failureBlock;


@end
