//
//  WZNoDataView.m
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "WZNoDataView.h"

@interface WZNoDataView()
{
    
}

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *tipsLabel;

@end


@implementation WZNoDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom, self.width, 40)];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = RGBCOLOR(180, 173, 173);
        _tipsLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _tipsLabel;
}

- (void)showInSuperView:(UIView *)superView withImageView:(NSString *)imageName withTipsString:(NSString *)tipsString
{
    if (!IsStrEmpty(imageName)) {
        UIImage *image = [UIImage imageNamed:imageName];
        self.imageView.image = image;
        self.imageView.frame = CGRectMake((MSW - image.size.width) / 2, (self.height - image.size.height)/2 - (image.size.height/2), image.size.width, image.size.height);
        if (self.imageView.superview == nil) {
            [self addSubview:self.imageView];
        }
    }
    if (!IsStrEmpty(tipsString)) {
        self.tipsLabel.text = tipsString;
        if (self.tipsLabel.superview == nil) {
            [self addSubview:self.tipsLabel];
        }
    }
    [self showInSuperView:superView];
}

- (void)showInSuperView:(UIView *)superView withTipsString:(NSString *)tipsString
{
    if (!IsStrEmpty(tipsString)) {
        self.tipsLabel.text = tipsString;
        
        if (self.tipsLabel.superview == nil) {
            [self addSubview:self.tipsLabel];
        }
    }
    [self showInSuperView:superView];
}

- (void)showInSuperView:(UIView *)superView withImageView:(NSString *)imageName
{
    if (!IsStrEmpty(imageName)) {
        UIImage *image = [UIImage imageNamed:imageName];
        self.imageView.image = image;
        self.imageView.frame = CGRectMake((MSW - image.size.width) / 2, (200 - image.size.height), image.size.width, image.size.height);
        
        if (self.imageView.superview == nil) {
            [self addSubview:self.imageView];
        }
    }
    [self showInSuperView:superView];
}

- (void)showInSuperView:(UIView *)superView
{
    [superView addSubview:self];
}


- (void)hidden
{
    [self removeFromSuperview];
}

@end
