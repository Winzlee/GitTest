//
//  SCSettingViewController.m
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import "SCSettingViewController.h"

@interface SCSettingViewController ()
{
    WZNoDataView        *_noDataView;
}
@end

@implementation SCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self createViews];
    [self checkDataOrNot];
}

- (void)createViews
{
    UILabel *titleLabel = [WZUIHelper createLabelWithFrame:CGRectMake(0, (myheight - 30)/2, mywidth, 30) text:@"功能正在开发中" textColor:MyColor_DarkBlack font:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
}


- (void)checkDataOrNot
{
    if (_noDataView == nil) {
        _noDataView = [[WZNoDataView alloc] initWithFrame:CGRectMake(0, 0, mywidth, myheight)];
    }
    [_noDataView showInSuperView:self.view withImageView:@"my_setting" withTipsString:@"功能正在开发中"];
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
