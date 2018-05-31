//
//  SCWarningNotificationCell.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCWarningNotificationCell.h"
#import "SCWarningNotificationModel.h"

@interface SCWarningNotificationCell ()
{
    UIView          *_bgView;
    UILabel         *_deviceTypeLabel;
    UILabel         *_warningTimeLabel;
    UILabel         *_phoneLabel;
    UILabel         *_trackTypeLabel;
}
@end

@implementation SCWarningNotificationCell
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
    
    _trackTypeLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 0, 0, 0) text:nil textColor:[UIColor whiteColor] font:14];
    _trackTypeLabel.textAlignment = NSTextAlignmentCenter;
    _trackTypeLabel.backgroundColor = MyColor_Main;
    _trackTypeLabel.layer.cornerRadius = 35;
    _trackTypeLabel.layer.masksToBounds = YES;
    [_bgView addSubview:_trackTypeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgView.frame = CGRectMake(10, 0, self.width - 20, self.height);
    _deviceTypeLabel.frame = CGRectMake(10, 5, _bgView.width - 100, 30);
    _warningTimeLabel.frame = CGRectMake(10, _deviceTypeLabel.bottom, _bgView.width - 100, 30);
    _phoneLabel.frame = CGRectMake(10, _warningTimeLabel.bottom, _bgView.width - 100, 30);
    _trackTypeLabel.frame = CGRectMake(_bgView.width - 80, (_bgView.height-70)/2, 70, 70);
}

- (void)setWarningModel:(SCWarningNotificationModel *)warningModel
{
    _deviceTypeLabel.text = @"设备类型：电瓶车";
    _warningTimeLabel.text = [NSString stringWithFormat:@"报警时间：%@",warningModel.alarmTime];
    _phoneLabel.text = [NSString stringWithFormat:@"车主电话：%@",warningModel.ebikePhone];
    
    if ([warningModel.policeTrackNumber intValue] > 1) {
        _trackTypeLabel.text = @"多人追踪";
    }else if([warningModel.policeTrackNumber intValue] == 1){
        _trackTypeLabel.text = @"单人追踪";
    }
}


@end
