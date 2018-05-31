//
//  SCWarningNotificationModel.h
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCWarningNotificationModel : NSObject

/** 报警时间 */
@property (nonatomic, copy)NSString *alarmTime;
/** 车主电话 */
@property (nonatomic, copy)NSString *ebikePhone;
/** 电动车mac */
@property (nonatomic, copy)NSString *ebikeMac;
/** 接受时间 */
@property (nonatomic, copy)NSString *jpushTime;
/** 有,拼接就是多人追踪 没有,就是单人追踪 */
@property (nonatomic, copy)NSString *policeMac;
/** 【1.未处理 2.追踪中 3.已结案】 */
@property (nonatomic, copy)NSString *status;
/** 追踪人数 */
@property (nonatomic, copy)NSString *policeTrackNumber;


@end
