//
//  SCTrackNumberViewController.m
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import "SCTrackNumberViewController.h"

@interface SCTrackNumberViewController ()

@end

@implementation SCTrackNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"追踪统计";
    
    [self createViews];
}

- (void)createViews
{
    for (int i = 0; i < 2; i++) {
        UILabel *titleLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, 30 + 200*i, mywidth, 30) text:@"" textColor:MyColor_DarkBlack font:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titleLabel];
        
        UILabel *contentLabel = [WZUIHelper createLabelWithFrame:CGRectMake((mywidth - 120)/2, titleLabel.bottom + 20, 120, 120) text:@"" textColor:[UIColor blackColor] font:30];
        contentLabel.backgroundColor = RGBCOLOR(189, 189, 189);
        contentLabel.layer.cornerRadius = 60;
        contentLabel.layer.masksToBounds = YES;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:contentLabel];
        
        if (i == 0) {
            titleLabel.text = @"您的累计追踪次数";
            contentLabel.text = @"98次";
            contentLabel.backgroundColor = MyColor_Main;
        }else{
            titleLabel.text = @"您的累计追踪里程";
            contentLabel.text = @"53KM";
            contentLabel.backgroundColor = [UIColor grayColor];
        }
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
