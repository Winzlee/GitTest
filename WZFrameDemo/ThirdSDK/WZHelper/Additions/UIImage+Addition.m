//
//  UIImage+Addition.m
//  AntGroupBuy
//
//  Created by 健 张 on 14-7-14.
//  Copyright (c) 2014年 AntGroupBuy. All rights reserved.
//

#import "UIImage+Addition.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

static char titleKey;

@implementation UIImage (Addition)

- (NSString *)title
{
    return objc_getAssociatedObject(self, &titleKey);
}

- (void)setTitle:(NSString *)title
{
    objc_setAssociatedObject(self, &titleKey, title, OBJC_ASSOCIATION_COPY);
}

+ (UIImage *)imageWithColor: (UIColor *) color imageSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

- (UIImage *)resizedImage:(CGSize)size imageOrientation:(UIImageOrientation)imageOrientation
{
    CGSize imageSize = self.size;
    CGFloat horizontalRatio = size.width / imageSize.width;
    CGFloat verticalRatio = size.height / imageSize.height;
    CGFloat ratio = MIN(horizontalRatio, verticalRatio);
    CGSize targetSize = CGSizeMake(imageSize.width * ratio, imageSize.height * ratio);
    
	UIGraphicsBeginImageContextWithOptions(size, YES, 1.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -size.height);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (imageOrientation == UIImageOrientationRight || imageOrientation == UIImageOrientationRightMirrored) {
        transform = CGAffineTransformTranslate(transform, 0.0f, size.height);
        transform = CGAffineTransformRotate(transform, -M_PI_2);
    } else if (imageOrientation == UIImageOrientationLeft || imageOrientation == UIImageOrientationLeftMirrored) {
        transform = CGAffineTransformTranslate(transform, size.width, 0.0f);
        transform = CGAffineTransformRotate(transform, M_PI_2);
    } else if (imageOrientation == UIImageOrientationDown || imageOrientation == UIImageOrientationDownMirrored) {
        transform = CGAffineTransformTranslate(transform, size.width, size.height);
        transform = CGAffineTransformRotate(transform, M_PI);
    }
    CGContextConcatCTM(context, transform);
    
	CGContextDrawImage(context, CGRectMake((size.width - targetSize.width) / 2, (size.height - targetSize.height) / 2, targetSize.width, targetSize.height), self.CGImage);
    
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return resizedImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)imageFromView:(UIView *)orgView
{
    //支持retina高分的关键
    if(&UIGraphicsBeginImageContextWithOptions != NULL){
        UIGraphicsBeginImageContextWithOptions(orgView.frame.size, NO, 0.0);
    }
    else {
        UIGraphicsBeginImageContext(orgView.frame.size);
    }
    
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)cutImageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    //注意，retina屏图片大小为屏幕的两倍
    CGRect retinaRect = CGRectMake(rect.origin.x*2, rect.origin.y*2, rect.size.width*2, rect.size.height*2);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, retinaRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

//切图拉伸
+ (UIImage *)imageResizableWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return image;
}

//模糊效果
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur {
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = destImage.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
