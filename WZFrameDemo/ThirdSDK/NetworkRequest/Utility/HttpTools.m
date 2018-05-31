//
//  HttpTools.m
//  Connect
//
//  Created by JinJin on 2016/10/31.
//  Copyright © 2016年 GJQ. All rights reserved.
//

#import "HttpTools.h"

@implementation HttpTools


#pragma mark - 共享请求
+(instancetype)sharedNetwork
{
    static HttpTools * httpTools;
    static dispatch_once_t onceToekn;
    //单例
    dispatch_once(&onceToekn, ^{
        
        httpTools =[self manager];
        //设置请求参数的类型:HTTP (AFJSONRequestSerializer,AFHTTPRequestSerializer)
        httpTools.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置请求的超时时间
        httpTools.requestSerializer.timeoutInterval = 30.f;
        //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
        httpTools.responseSerializer = [AFJSONResponseSerializer serializer];
        
        httpTools.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",
                                                                                                                                                                                                     @"text/json",
                                                                                                                                                                                                     @"text/json",
                                                                                                                                                                                                     @"text/html",
                                                                                                                                                                                                     @"text/plain",
                                                                                                                                                                                                     @"application/atom+xml",
                                                                                                                                                                                                     @"application/xml",
                                                                                                                                                                                                     @"text/xml",nil];
        
    });
    
    return httpTools;
}


@end
