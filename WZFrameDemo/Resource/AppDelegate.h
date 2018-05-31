//
//  AppDelegate.h
//  SameCity
//
//  Created by Johnson on 16/4/18.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
#pragma mark - 为了适应表达接口  增加的属性
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * UserID;
@property (nonatomic, strong) NSString * userSessionID;

//- (void)initLoginViewController;

@end

