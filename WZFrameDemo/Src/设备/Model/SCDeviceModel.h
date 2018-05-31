//
//  SCDeviceModel.h
//  SameCity
//
//  Created by 庞氏科技 on 2017/4/24.
//  Copyright © 2017年 Johnson. All rights reserved.
//  设备model

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCDeviceModel : NSObject


/** 报警时间 */
@property (nonatomic, copy)NSString *alarmTime;
/** 车主电话 */
@property (nonatomic, copy)NSString *ebikePhone;
/** 车架号 */
@property (nonatomic, copy)NSString *carNumber;
/** 终端经度 */
@property (nonatomic, copy)NSString *longitude;
/** 终端纬度 */
@property (nonatomic, copy)NSString *latitude;
/** mac 地址 */
@property (nonatomic, copy)NSString *mac;
/** 当前时间 */
@property (nonatomic, copy)NSString *curTime;



/** 【1.未处理 2.追踪中 3.已结案】 */
@property (nonatomic, copy)NSString *status;


/** 【1:警察 2:电动车】 */
@property (nonatomic, copy)NSString *type;


@end
