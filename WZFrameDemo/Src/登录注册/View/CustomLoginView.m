//
//  CustomLoginView.m
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/16.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import "CustomLoginView.h"

@implementation CustomLoginView

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title andPlaceHolder:(NSString *)placeHolder{
    
    self = [super initWithFrame:frame];
    if (self) {
        _imageName = imageName;
        _placeHolder = placeHolder;
        
//        self.layer.borderColor = MyColor_Line.CGColor;
//        self.layer.borderWidth = 1;
        
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageName]];
//        imageView.frame = CGRectMake(2.5, 12.5, 15, 15);
//        [self addSubview:imageView];
        
        
        CGSize size = MD_MULTILINE_TEXTSIZE(title, [UIFont mysystemFontOfSize:14], CGSizeMake(100, 30));
        
        UILabel *titleLabel = [WZUIHelper createLabelWithFrame:CGRectMake(5, 5, size.width, 30) text:title textColor:MyColor_DarkBlack font:14];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:titleLabel];
        
        _textField = [[UITextField alloc]init];
        _textField.frame = CGRectMake(titleLabel.right, 5, self.width - titleLabel.width - 10, 30);
        [_textField setPlaceholder:_placeHolder];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont mysystemFontOfSize:14];
        [self addSubview:_textField];
        
        UIImageView *lineView = [[UIImageView alloc]init];
        lineView.frame = CGRectMake(0, _textField.bottom, self.width, 1);
        lineView.backgroundColor = MyColor_Line;
        [self addSubview:lineView];
        
    }
    return self;
}

//+(instancetype)allocWithImageName:(NSString *)imageName andPlaceHolder:(NSString *)placeHolder{
//
//    return [[self alloc]initWithImageName:imageName andPlaceHolder:placeHolder];
//
//}








@end
