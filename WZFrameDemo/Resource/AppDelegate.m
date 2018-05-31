//
//  AppDelegate.m
//  SameCity
//
//  Created by Johnson on 16/4/18.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"//登录界面
#import "PilotViewController.h"//启动引导页面
#import "TabBarController.h"
#import "SCMainViewController.h"    //防丢界面
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>


@interface AppDelegate ()<UIAlertViewDelegate,JPUSHRegisterDelegate>
{
    TabBarController *_tabbarController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    // 要使用百度地图，请先启动BaiduMapManager
//    BMKMapManager* mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [mapManager start:kBaiduMapAK  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
    //激光推送配置
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeBadge | UIUserNotificationTypeBadge) categories:nil];
    }
    NSString *appkey = JPUSHKEY;
    NSString *channel = @"app store";
    BOOL isProduction = kPushMode;//根据激光推送控制台里设置的开发环境还是生产环境
    //在应用启动的时候调用
    [JPUSHService setupWithOption:launchOptions appKey:appkey channel:channel apsForProduction:isProduction advertisingIdentifier:advertisingId];
    
//    //2.1.9版本新增获取registration id block接口。
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0)
//        {
//            // iOS10获取registrationID放到这里了, 可以存到缓存里, 用来标识用户单独发送推送
//            NSLog(@"registrationID获取成功：%@",registrationID);
//            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"RegistrationID"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        else
//        {
//            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];
    
    
    _tabbarController = [[TabBarController alloc] init];
    self.window.rootViewController = _tabbarController;
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

//程序未启动时 APNS 推送.获取到 launchOptions 然后操作
- (void)sendNotation:(NSDictionary *)launchOptions{
    if (launchOptions) {
        NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remoteNotification) {
            
        }else{
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //清空角标
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

//#pragma mark - 修改通知处理函数--处于前台
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
//    
//    //清空角标
//    [JPUSHService resetBadge];
//    [JPUSHService handleRemoteNotification:userInfo];
//    if (!userInfo) {
//        completionHandler(UIBackgroundFetchResultNoData);
//        return;
//    }
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//    
//}
////注册 deviceToken
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    [JPUSHService registerDeviceToken:deviceToken];
//    
//}
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    NSLog(@"激光注册失败: %@", error.localizedDescription);
//}
//#pragma mark - 接收后台推送的消息
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    //获取自定义字段
//    //    [JPUSHService handleRemoteNotification:userInfo];
//    application.applicationIconBadgeNumber = 0;
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
//    [self gotoMessageToViewControllerWith:userInfo];
//    NSLog(@"拿到后台推送的消息是: %@", userInfo);
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
//}
//
//- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error{
//    //
//    NSLog(@"退搜昂失败");
//}
//
//#pragma mark - JPUSHRegisterDelegate
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler{
//    NSDictionary *userinfo = notification.request.content.userInfo;
//    
//    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userinfo];
//    }else{
//        //判断为本地通知
//    }
//    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
//    [self gotoMessageToViewControllerWith:userinfo];
//}
//
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    
//    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//    NSLog(@"已经接收到激光的推送");
//    NSDictionary *userinfo = notification.request.content.userInfo;
//    [self gotoMessageToViewControllerWith:userinfo];
//}
////点击通知条
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    
//    NSDictionary *userInfo = response.notification.request.content.userInfo;
//    [self gotoMessageToViewControllerWith:userInfo];
//    NSLog(@"点击通知的回调");
//}
//
////应用在前台的时候收到通知走的方法
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    NSLog(@"接收到通知:%@", notification);
//    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
//    NSDictionary *userInfo = notification.request.content.userInfo;
//    [self gotoMessageToViewControllerWith:userInfo];
//}



#pragma mark - 推送
// 注册远程通知与设备令牌码
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //极光推送
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        DLog(@"resCode : %d,registrationID: %@",resCode,registrationID);
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"RegistrationID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 处理收到的APNS消息，向服务器上报收到APNS消息
    DLog(@"iOS7-iOS9收到通知:%@", [self logDic:userInfo]);
    // 极光推送
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateActive) { // 活跃状态
        
        //推送
        if (_tabbarController) {
            [_tabbarController showAPNS:userInfo];
        }
        
    }else if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground){ // 不活跃状态
        
        //推送
        if (_tabbarController) {
            [_tabbarController showAPNS:userInfo];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //    NSLog(@"接收本地通知啦！！！");
    //    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return [str stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}


#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    DLog(@"iOS10收到通知:%@", [self logDic:userInfo]);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    //推送
    if (_tabbarController) {
        [_tabbarController showAPNS:userInfo];
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    DLog(@"iOS10收到通知:%@", [self logDic:userInfo]);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //推送
    if (_tabbarController) {
        [_tabbarController showAPNS:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}



@end
