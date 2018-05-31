//
//  Network_HeaderAPI.h
//  Winzlee
//
//  Created by liwenzhi on 17/2/25.
//  Copyright © 2017年 lwz. All rights reserved.
//

#ifndef Network_HeaderAPI_h
#define Network_HeaderAPI_h

//#define KHTTPS      @"https://test.onecitycare.com/onecity-api/v1"
//#define KHTTPSV2    @"https://test.onecitycare.com/onecity-api/v2"
//#define KLOGIN      @"https://test.onecitycare.com/unify-api"
//#define SERVER_API  @"https://test.onecitycare.com/"     //测试

#define KHTTPS      @"https://new.onecitycare.com/onecity-api/v1"
#define KHTTPSV2    @"https://new.onecitycare.com/onecity-api/v2"
#define KLOGIN      @"https://new.onecitycare.com/unify-api"
#define SERVER_API  @"https://new.onecitycare.com/"   //生产

//----------------   start  （Added by Winzlee）   -----------------------//


#pragma mark - v2



#pragma mark - v3

#pragma mark  个人
//检查更新
#define HTTP_Personal_CheckVersion      [SERVER_API stringByAppendingString:@"onecity-api/v1/checkVersion"]
//登录
#define HTTP_Personal_Login             [SERVER_API stringByAppendingString:@"onecity/baseSignal/chackPwd"]

#pragma mark  警情推送
//2.4.	查询待处理追踪记录接口
#define HTTP_Warning_WarningList        [SERVER_API stringByAppendingString:@"onecity/ebike/v1/alarmRecord"]
//2.5.	查询正在追踪和结案记录接口
#define HTTP_Warning_HistoryList        [SERVER_API stringByAppendingString:@"onecity/ebike/v1/trackRecord"]
//2.6.	根据mac或手机号搜索待处理追踪接口
#define HTTP_Warning_SearchList         [SERVER_API stringByAppendingString:@"onecity/ebike/v1/serchAlarmRecord"]



#pragma mark  首页
//2.7.	根据警员手机号查询出当前警员追踪的信息
#define HTTP_Home_SearchRecord          [SERVER_API stringByAppendingString:@"onecity/ebike/v1/getTrackByPolicePhone"]
//设备列表
#define HTTP_Home_DeviceList            [SERVER_API stringByAppendingString:@"onecity/ebike/v1/trackAlarmEBikeAddr"]
//开始追踪
#define HTTP_Home_StartTrack            [SERVER_API stringByAppendingString:@"onecity/ebike/v1/startTrack"]
//结束追踪
#define HTTP_Home_EndTrack              [SERVER_API stringByAppendingString:@"onecity/ebike/v1/finishPoliceTrack"]
//2.2.上传警车经纬度接口
#define HTTP_Home_UploadPoliceLocation  [SERVER_API stringByAppendingString:@"onecity/ebike/v1/uploadPoliceCarLo"]


//------------------------------------   end  （Added by Winzlee）    ---------------------------------//

#endif /* Network_HeaderAPI_h */

