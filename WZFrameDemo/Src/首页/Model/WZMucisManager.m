//
//  WZMucisManager.m
//  Winzlee
//
//  Created by liwenzhi on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WZMucisManager.h"

@interface WZMucisManager ()

@property (nonatomic, strong) NSMutableDictionary *musicPlayerDic;

@end
static WZMucisManager *_instance = nil;

@implementation WZMucisManager

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init
{
    __block WZMucisManager *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            _musicPlayerDic = [NSMutableDictionary dictionary];
        }
    });
    self = temp;
    return self;
}
+ (WZMucisManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    objc_sync_exit
    return _instance;
}



@end
