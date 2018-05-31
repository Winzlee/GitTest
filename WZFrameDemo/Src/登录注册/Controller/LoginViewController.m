//
//  LoginViewController.m
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/16.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomLoginView.h"
#import "LoginView.h"
#import "JPUSHService.h"

#import "SCMainViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

{
    LoginView *view;
    UIAlertView *alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,10,17)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    view = [[LoginView alloc]init];
    
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    UILabel *label = [[UILabel alloc ]init];
    label.text = appName;
    label.bounds = CGRectMake(0, 0, 44, 20);
    label.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = label;
    [view.registerAccount addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [view.forgetPassWord addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [view.logIn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    
    view.account.textField.delegate = self;
    view.passWord.textField.delegate = self;
    
    self.view  = view;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    view.account.textField.text = @"";
    view.passWord.textField.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



-(void)logIn{
    
    [self logSuccess];
}

- (void)logSuccess
{
//    [MBProgressHUD showHUDAddedTo:view animated:NO];
//    NSString *patten = @"^1+[3578]+\\d{9}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",patten];
//    BOOL isOK = [pred evaluateWithObject:view.account.textField.text];
//    if (isOK) {
//        NSLog(@" log in ");
//        //    获取时间
//        NSString *timeSap = [SecurityUtil timeLocal];
//        NSString *parm = [NSString stringWithFormat:@"account=%@&timeStamp=%@&loginpwd=%@",view.account.textField.text,timeSap,[SecurityUtil md5PWD:view.passWord.textField.text]];
//        NSString *aes = [SecurityUtil encryptAESData:parm app_key:kAES_Key_Old iv:kAES_Iv_Old];
//        NSString *sigStr = [NSString stringWithFormat:@"%@%@",[SecurityUtil md5PWD:view.passWord.textField.text],timeSap];
//        NSString *sig = [SecurityUtil md5:sigStr];
//        
//        NSString *string = [NSString stringWithFormat:@"https://api.onecitycard.cn/unify-api/checkUserLogin?us:%@,parm:%@,sig:%@", USID, aes, sig];
//        NSLog(@"-----LoginString:%@", string);
//        
//        [HGPostRequest httpsPostWithBaseURL:[NSString stringWithFormat:@"%@/checkUserLogin",KLOGIN] params:@{
//                                                                                                             @"us":USID,
//                                                                                                             @"parm":aes,
//                                                                                                             @"sig":sig
//                                                                                                             }success:^(id JSON) {
//                                                                                                                 NSLog(@"------JSON:%@", JSON);
//                                                                                                                 if ([[JSON objectForKey:@"result"] integerValue] == 0) {
//                                                                                                                     [self getuserInfo:[[JSON objectForKey:@"data"] objectForKey:@"headimg"] nickName:[[JSON objectForKey:@"data"] objectForKey:@"nickName"]];
//                                                                                                                 }else if([[JSON objectForKey:@"result"] integerValue] == -3){
//                                                                                                                     [MBProgressHUD hideHUDForView:view animated:YES];
//                                                                                                                     UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:@"账号不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                                                                                                     [alerts show];
//                                                                                                                 }else{
//                                                                                                                     UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"" message:@"密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                                                                                                     [alerts show];
//                                                                                                                     [MBProgressHUD hideHUDForView:view animated:YES];
//                                                                                                                 }
//                                                                                                             } failure:^(NSError *error) {
//                                                                                                                 [MBProgressHUD hideHUDForView:view animated:YES];
//                                                                                                                 DLog(@"error = %@",error);
//                                                                                                                 [self.view showHUDTextAtCenter:kFailRequestDefaultTip];
//                                                                                                             }];
//        
//    }else{
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"手机号不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertview show];
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }
}

//获取用户信息
- (void)getuserInfo:(NSString *)headimag nickName:(NSString *)nickName
{
    
    if (nickName.length < 1) {
        nickName = view.account.textField.text;
    }
    
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    [Config currentConfig].isLogin = @YES;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nickName forKey:@"nickName"];
    [user setObject:view.account.textField.text forKey:@"userAccount"];
    [user setObject:view.passWord.textField.text forKey:@"passWord"];
    [user synchronize];
    
    [JPUSHService setAlias:view.account.textField.text callbackSelector:nil object:nil];
    
    //清除原来的图片缓存
    [[SDImageCache sharedImageCache] removeImageForKey:[Config currentConfig].logo withCompletion:^{
        [Config currentConfig].logo = [NSString stringWithFormat:@"%@/headImgs/%@.jpg",KLOGIN,USERACCOUNT];
        //修改用户头像
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEUSERICON" object:nil];
        //修改用户昵称
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATEUSERNICKNAME" object:nil];
        //重新获取设备
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccessNotification" object:nil];
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)forgetPassWord{
    [self resighResponse];
//    ForgetPassWordViewController * vc = [[ForgetPassWordViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    [view.account.textField resignFirstResponder];
    [view.passWord.textField resignFirstResponder];
}


-(void)registerAccount{
    [self resighResponse];
//    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
//    [self.navigationController pushViewController:registerVc animated:YES];
    
    [view.account.textField resignFirstResponder];
    [view.passWord.textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:view.account.textField]) {
        [view.passWord.textField resignFirstResponder];
    }else if ([textField isEqual:view.passWord.textField]){
        [view.account resignFirstResponder];
    }
}

- (void)resighResponse
{
    
    if ([view.account isFirstResponder]) {
        [view.account resignFirstResponder];
    }
    
    if ([view.passWord isFirstResponder]) {
        [view.passWord resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [view.account.textField resignFirstResponder];
    [view.passWord.textField resignFirstResponder];
}


@end
