//
//  SCMyHeaderCell.h
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCMyHeaderCell : UITableViewCell

@property (nonatomic, copy) void (^MyHeaderBlock)(NSInteger index);

@property (nonatomic, strong) UILabel *loginNameLabel;

@end
