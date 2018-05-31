//
//  SCHistoryWarningCell.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCHistoryWarningCell.h"
#import "SCWarningNotificationModel.h"

@interface SCHistoryWarningCell ()
{
    UIView          *_bgView;
    UILabel         *_deviceTypeLabel;
    UILabel         *_warningTimeLabel;
    UILabel         *_phoneLabel;
    UILabel         *_statusLabel;  //状态
}
@end

@implementation SCHistoryWarningCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createViews];
    }
    return self;
}

- (void)createViews
{
    _bgView = [WZUIHelper createViewWithFrame:CGRectMake(0, 0, 0, 0)];
//    _bgView.layer.borderColor = MyColor_Main.CGColor;
//    _bgView.layer.borderWidth = 1;
    _bgView.layer.cornerRadius = 2;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _deviceTypeLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 0, 0, 0) text:nil textColor:MyColor_DarkBlack font:14];
    [_bgView addSubview:_deviceTypeLabel];
    
    _warningTimeLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 0, 0, 0) text:nil textColor:MyColor_DarkBlack font:14];
    [_bgView addSubview:_warningTimeLabel];
    
    _phoneLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 0, 0, 0) text:nil textColor:MyColor_DarkBlack font:14];
    [_bgView addSubview:_phoneLabel];
    
    _statusLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 0, 0, 0) text:nil textColor:[UIColor whiteColor] font:15];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.layer.cornerRadius = 30;
    _statusLabel.layer.masksToBounds = YES;
    _statusLabel.adjustsFontSizeToFitWidth = YES;
    [_bgView addSubview:_statusLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgView.frame = CGRectMake(10, 0, self.width - 20, self.height);
    _deviceTypeLabel.frame = CGRectMake(10, 5, _bgView.width - 90, 25);
    _warningTimeLabel.frame = CGRectMake(10, _deviceTypeLabel.bottom, _bgView.width - 90, 25);
    _phoneLabel.frame = CGRectMake(10, _warningTimeLabel.bottom, _bgView.width - 90, 25);
    _statusLabel.frame = CGRectMake(_bgView.width - 70, (_bgView.height - 60)/2, 60, 60);
}

- (void)setWarningModel:(SCWarningNotificationModel *)warningModel
{
    _deviceTypeLabel.text = @"设备类型：电瓶车";
    _warningTimeLabel.text = [NSString stringWithFormat:@"报警时间：%@",warningModel.alarmTime];
    _phoneLabel.text = [NSString stringWithFormat:@"车主电话：%@",warningModel.ebikePhone];
    if ([warningModel.status isEqualToString:@"2"]) {
        _statusLabel.text = @"追踪中";
        _statusLabel.backgroundColor = MyColor_Main;
    }else if ([warningModel.status isEqualToString:@"3"]){
        _statusLabel.text = @"已结束";
        _statusLabel.backgroundColor = RGBCOLOR(100, 100, 100);
    }
}


@end
