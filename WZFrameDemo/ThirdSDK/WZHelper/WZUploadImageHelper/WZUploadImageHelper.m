//
//  WZUploadImageHelper.m
//  tgo2o
//
//  Created by liwenzhi on 16/5/12.
//  Copyright © 2016年 lwz. All rights reserved.
//
//  上传图片

#import "WZUploadImageHelper.h"

static WZUploadImageHelper *sharedInstance;

@implementation WZUploadImageHelper

//static NSString * const FORM_FLE_INPUT = @"img";

#pragma mark - 单例方法
+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
        
    });
    
    return sharedInstance;
}



#pragma mark - public

+ (WZUploadImageHelper *)sharedImgHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WZUploadImageHelper alloc]init];
    });
    
    return sharedInstance;
}

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
                     failure:(void (^)(NSError *error))responseFailure
{
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    float scale = image.size.width / image.size.height;
    
    CGFloat imageW;
    CGFloat imageH;
    if (image.size.width > 800) {   // 如果图片宽大于800，就需要裁剪
        imageW = 800;
        imageH = imageW / scale;
    }else{
        imageW = image.size.width;
        imageH = image.size.height;
    }
    
    CGSize imageSize;
    imageSize.width = imageW;
    imageSize.height = imageH;
    UIImage *imageMin = [self scaleToSizeWithImage:image size:imageSize];
    
    //图片字节压缩0.5倍
    NSData* data = UIImageJPEGRepresentation([self fixOrientation:imageMin], 0.5);
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [paramDic allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[paramDic objectForKey:key]];
    }
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //    NSString *picFileName = [NSString stringWithFormat:@"%f.png",[NSDate timeIntervalSinceReferenceDate]];
    
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",imgParam,picFileName];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //将image的data加入
    [myRequestData appendData:data];
    
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error || !response || !data) {
            responseFailure(error);
        }
        if ( [(NSHTTPURLResponse *) response statusCode] == 200 && data) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (result) {
                responseSuccess(result);
            }else{
                responseFailure(error);
            }
        }
        
    }];
    [dataTask resume];
    
    
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    //
    //        if (error || !response || !data) {
    //            responseFailure(error);
    //        }
    //        if ( [(NSHTTPURLResponse *) response statusCode] == 200 && data) {
    //
    //            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //            if (result) {
    //                responseSuccess(result);
    //            }else{
    //                responseFailure(error);
    //            }
    //        }
    //    }];
}

#pragma mark - private

/**
 *  裁剪图片的尺寸
 *
 *  @param img  被裁剪的图片
 *  @param size 需要被裁剪的尺寸大小
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


/**
 *  调整图片的方向
 *
 *  @param aImage 需要调整的图片
 *
 *  @return 调整后的图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //    NSLog(@"didReceiveChallenge %@", challenge.protectionSpace);
    NSLog(@"调用了最外层");
    // 1.判断服务器返回的证书类型, 是否是服务器信任
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"调用了里面这一层是服务器信任的证书");
        /*
         NSURLSessionAuthChallengeUseCredential = 0,                     使用证书
         NSURLSessionAuthChallengePerformDefaultHandling = 1,            忽略证书(默认的处理方式)
         NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,     忽略证书, 并取消这次请求
         NSURLSessionAuthChallengeRejectProtectionSpace = 3,            拒绝当前这一次, 下一次再询问
         */
        //        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential , card);
    }
}

@end
