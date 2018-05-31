//
//  WZUploadImageHelper.h
//  tgo2o
//
//  Created by liwenzhi on 16/5/12.
//  Copyright © 2016年 lwz. All rights reserved.
//
//  上传图片

#import <Foundation/Foundation.h>

@interface WZUploadImageHelper : NSObject

+ (WZUploadImageHelper *)sharedImgHelper;


/**
 *  上传图片
 *
 *  @param image            被上传的图片对象
 *  @param urlStr           接口地址
 *  @param imgParam         图片对应的字段
 *  @param picFileName      图片文件名
 *  @param paramDic         参数
 *  @param responseSuccess  上传成功后的block
 *  @param responseFailure  上传失败后的block
 */
- (void)uploadImageWithImage:(UIImage *)image
                      urlStr:(NSString *)urlStr
                    imgParam:(NSString *)imgParam
                 picFileName:(NSString *)picFileName
                    paramDic:(NSDictionary *)paramDic
                     success:(void (^)(id responseObject))responseSuccess
                     failure:(void (^)(NSError *error))responseFailure;

@end
