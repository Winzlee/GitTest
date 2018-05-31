//
//  Config.h
//  Winzlee
//
//  Created by liwenzhi on 15/10/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//


#define dIsLogin                NSStringFromSelector(@selector(isLogin))
#define dIsTracking             NSStringFromSelector(@selector(isTracking))
#define dLogo                   NSStringFromSelector(@selector(logo))
#define dMacAddress             NSStringFromSelector(@selector(macAddress))
#define dLatitude               NSStringFromSelector(@selector(latitude))
#define dLongitude              NSStringFromSelector(@selector(longitude))


//inviteCode
@interface Config : NSObject
{
	NSUserDefaults *defaults;
}

+ (Config *)currentConfig;

@property (readwrite, retain) NSUserDefaults *defaults;

/** 是否登录 */
@property (nonatomic, copy) NSNumber   *isLogin;
/** 是否正在追踪 */
@property (nonatomic, copy) NSNumber   *isTracking;
/** 用户头像 */
@property (nonatomic, copy) NSString   *logo;
/** 选中的设备的 mac 地址 */
@property (nonatomic, copy) NSString    *macAddress;
/** 纬度 */
@property (nonatomic, copy) NSString    *latitude;
/** 经度 */
@property (nonatomic, copy) NSString    *longitude;

@end
