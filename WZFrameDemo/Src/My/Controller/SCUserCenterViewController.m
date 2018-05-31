//
//  SCUserCenterViewController.m
//  PoliceTrack
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 onecitycare. All rights reserved.
//

#import "SCUserCenterViewController.h"

@interface SCUserCenterViewController ()
{
    WZNoDataView        *_noDataView;
}
@end

@implementation SCUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self checkDataOrNot];
}

- (void)checkDataOrNot
{
    if (_noDataView == nil) {
        _noDataView = [[WZNoDataView alloc] initWithFrame:CGRectMake(0, 0, mywidth, myheight)];
    }
    [_noDataView showInSuperView:self.view withImageView:@"my_setting" withTipsString:@"其他功能正在开发中"];
    
    UIButton *exitButton = [WZUIHelper createButtonWithFrame:CGRectMake(20, myheight - 50, mywidth - 40, 40) title:@"退出登录" titleColor:[UIColor whiteColor] font:15 normalImage:@"" selectedImage:@"" target:self selector:@selector(didClickExitButton)];
    exitButton.backgroundColor = MyColor_Main;
    exitButton.layer.cornerRadius = 3;
    exitButton.layer.masksToBounds = YES;
    [self.view addSubview:exitButton];
}

- (void)didClickExitButton
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutNotification" object:nil];
        
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
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
