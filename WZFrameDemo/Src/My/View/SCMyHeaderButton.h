//
//  SCMyHeaderButton.h
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCMyHeaderButton : UIButton

@property (nonatomic, strong)UIImageView *redView;

- (instancetype)initWithimageName:(NSString *)imageName title:(NSString *)title;

@end
