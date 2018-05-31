//
//  SDWebImageDownloader+AFNhttps.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/5/19.
//  Copyright © 2017年 Johnson. All rights reserved.
//
#import "AFNetworking.h"

#import "SDWebImageDownloader.h"
#import "SDWebImageDownloader+AFNhttps.h"

//定义https证书的模式
#define kHttpsCer  [SERVER_API containsString:@"new.onecitycare.com"] ? @"onecity_https_dis" : @"onecity_https_dev"

@implementation SDWebImageDownloader (AFNhttps)

+(AFSecurityPolicy *)customSecurityPolicy {
    
    ;
    
    
    //先导入证书到项目
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kHttpsCer ofType:@"cer"];//证书的路径
    
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate使用证书验证模式
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //如果是需要验证自建证书，需要设置为YES
    
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    
    securityPolicy.validatesDomainName = NO;
    
    NSSet *cerDataSet = [NSSet setWithArray:@[cerData]];
    
    securityPolicy.pinnedCertificates = cerDataSet;
    
    return securityPolicy;
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge

 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    NSLog(@"证书认证");
    
    SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    
    [[SDWebImageDownloader customSecurityPolicy] evaluateServerTrust:serverTrust forDomain:nil];
    
    
    
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,credential);
    
    return [[challenge sender] useCredential: credential
            
                  forAuthenticationChallenge: challenge];
    
}


@end
