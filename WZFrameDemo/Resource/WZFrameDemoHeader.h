//
//  SameCityHeader.h
//  SameCity
//
//  Created by Johnson on 16/4/12.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#ifndef SameCityHeader_h
#define SameCityHeader_h

//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
//
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
//
//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
//本地推送
#import <UserNotifications/UserNotifications.h>

#import "Contants.h"
#import "HttpRequest.h"
#import "Network_HeaderAPI.h"
#import "WZHelper.h"
#import "MJRefresh.h"


#define kAES_Key_Old    @"tomoon!@20160504" //key可修改
#define kAES_Iv_Old     @"20160504!@tomoon" //可以自行修改

#define kBaiduMapAK @"7bhFaiuRBgwGP6wrBsEGYFOKracf7ZVE"
#define JPUSHKEY    @"43e53f1a4f7307cdb4c01ff6"

#define USID @100001
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kWIDTH [UIScreen mainScreen].bounds.size.width
//用户信息
#define USERACCOUNT [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userAccount"]]
#define USERPWD [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"]]
#define USERNICKNAME [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"]]
#define REGISTRATIONID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"RegistrationID"]]


#endif /* SameCityHeader_h */
