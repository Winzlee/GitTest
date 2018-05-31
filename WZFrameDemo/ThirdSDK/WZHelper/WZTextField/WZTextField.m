//
//  WZTextField.m
//  Test
//
//  Created by liwenzhi on 15/6/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "WZTextField.h"

@implementation WZTextField

/*
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
} */

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+6, bounds.origin.y, bounds.size.width -15, bounds.size.height);//更好理解些
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+6, bounds.origin.y, bounds.size.width -15, bounds.size.height);//更好理解些
    
    return inset;
    
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +6, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}
//控制左视图位置
/*
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    return inset;
    //return CGRectInset(bounds,50,0);
} */

//控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextSetFillColorWithColor(context, UIColorFromRGB(0xffffff).CGColor);
////    [UIColorFromRGB(0x47819E)  setFill];
//    
//    [UIColorFromRGB(0x599cc6)  setFill];
////
//    [[self placeholder] drawInRect:rect withFont:self.font];
//}

- (void) setPlaceholder: (NSString*)placeholderText {
    [super setPlaceholder:placeholderText];
}

@end
