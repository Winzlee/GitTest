//
//  SCMyHeaderButton.m
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import "SCMyHeaderButton.h"

@interface SCMyHeaderButton ()
{
    UIImageView     *_myImageView;
    UILabel         *_myTitleLabel;
}
@end

@implementation SCMyHeaderButton

- (instancetype)initWithimageName:(NSString *)imageName title:(NSString *)title
{
    self = [super init];
    if (self) {
        [self createViewsWithImageName:imageName title:title];
    }
    return self;
}

- (void)createViewsWithImageName:(NSString *)imageName title:(NSString *)title
{
    _myImageView = [WZUIHelper createImageViewWithFrame:CGRectMake((self.width - 50)/2, 15, 50, 50) imageName:imageName];
    [self addSubview:_myImageView];
    
    _myTitleLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, _myImageView.bottom + 5, self.width, 30) text:title textColor:MyColor_DarkBlack font:14];
    _myTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_myTitleLabel];
    
    _redView = [WZUIHelper createImageViewWithFrame:CGRectMake(_myImageView.right - 5, 15, 10, 10) imageName:@""];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.cornerRadius = 5.5;
    _redView.layer.masksToBounds = YES;
    [self addSubview:_redView];
}

- (void)layoutSubviews
{
    _myImageView.frame = CGRectMake((self.width - 50)/2, 10, 50, 50);
    _myTitleLabel.frame = CGRectMake(0, _myImageView.bottom + 5, self.width, 30);
    _redView.frame = CGRectMake(_myImageView.right - 5, 10, 10, 10);
}


@end
