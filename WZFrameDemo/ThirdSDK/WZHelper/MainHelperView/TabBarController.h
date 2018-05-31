//
//  TabBarController.h
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface TabBarController : UITabBarController<UITabBarControllerDelegate, UITabBarDelegate>
{
    
}

- (void)showAPNS:(NSDictionary *)userInfo;  // 消息推送


@end
