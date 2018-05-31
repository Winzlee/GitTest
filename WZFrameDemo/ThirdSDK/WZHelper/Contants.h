//
//  Contants.h
//  Winzlee
//
//  Created by liwenzhi on 14-9-10.
//  Copyright (c) 2014年 lwz. All rights reserved.
//

#ifndef OverSeaOnline_Contants_h
#define OverSeaOnline_Contants_h


#define IOS10_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER	([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define isIPhone5       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone6p      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/*本地化转换*/
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//颜色创建
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))



//安全释放
#define TT_RELEASE_SAFELY(__REF) { (__REF) = nil;}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) { [__REF removeFromSuperview]; __REF = nil; }

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}

#define DEBUGLOG 1

#ifdef DEBUGLOG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

#define EncodeFormDic(dic,key) [dic[key] isKindOfClass:[NSString class]] ? dic[key] :([dic[key] isKindOfClass:[NSNumber class]] ? [dic[key] stringValue]:@"")


#define MSW ([UIScreen mainScreen].bounds.size.width)
#define MSH ([UIScreen mainScreen].bounds.size.height)

#define kWindow  [UIApplication sharedApplication].keyWindow


// JsonData
#define JsonSuccess     [[responseObject objectForKey:@"code"] intValue] ==0
#define JsonFailure       [[responseObject objectForKey:@"code"] intValue] !=0
#define JsonData          [responseObject objectForKey:@"data"]
#define JsonMessage    [responseObject objectForKey:@"msg"]

// 提示语
#define NO_Network          @"网络不可用,请检查网络"
#define NO_RequestFailure   @"连接服务器超时"
#define Network_Error       @"网络异常"

// 状态码
#define Success             [EncodeFormDic(responseObject, @"result") isEqualToString:@"0"]
#define Code201              [responseObject[@"code"] isEqualToString:@"201"]



//------------------------------------Added by Winzlee(liwenzhi)--------------------------------------//

//三个数中最大的
#define MAXThree(a,b,c) (a>b?(a>c?a:c):(b>c?b:c))

//常用颜色
#define MyColor_Nav                   [UIColor colorWithHex:@"#00A0E8"]   //导航颜色
#define MyColor_Main                  [UIColor colorWithHex:@"#00A0E8"]   //主色
#define MyColor_LightGray             [UIColor colorWithHex:@"#999999"]   //浅灰
#define MyColor_DarkGray              [UIColor colorWithHex:@"#666666"]   //深灰
#define MyColor_DarkBlack             [UIColor colorWithHex:@"#333333"]   //深黑
#define MyColor_Background            [UIColor colorWithHex:@"#ebebf1"]   //背景色
#define MyColor_Line                  [UIColor colorWithHex:@"#e5e5e5"]   //分割线

//定义推送的模式
#ifdef DEBUG
#       define kPushMode NO
#else
#       define kPushMode YES
#endif


//高度自适应
#define MD_MULTILINE_TEXTSIZE(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

//自定义某位置的字体大小&颜色&段落样式
#define SetUpTextColorFontParagraph(label,textStr,font,fontRange,color,colorRange,paragraphStyle,paragraphStyleRange,attributedString) \
attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];\
[attributedString addAttribute:NSFontAttributeName value:font range:fontRange];\
[attributedString addAttribute:NSForegroundColorAttributeName value:color range:colorRange];\
[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:paragraphStyleRange];\
label.attributedText = attributedString;

//加载失败，请稍后再试
#define kFailRequestDefaultTip @"服务器繁忙"

#define kPageSize 20

#endif
