//
//  TabBarController.m
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//
#import "TabBarController.h"

#import "SCMainViewController.h"
#import "SCWarningNotificationViewController.h"
#import "SCMyViewController.h"

#import "SCWarningNotificationModel.h"

#import "UITabBar+Badge.h"

@interface TabBarController() <UIAlertViewDelegate>
{
    
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

static TabBarController *_instance = nil;


@implementation TabBarController

#pragma mark - 创建单例控制器
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init
{
    __block TabBarController *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            
        }
    });
    self = temp;
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    UITabBarItem *item1;
    item1 = [[UITabBarItem alloc] initWithTitle:@"追踪地图" image:[[UIImage imageNamed:@"tabbar_first"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_first_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item1.tag = 1;
    
    UITabBarItem *item2;
    item2 = [[UITabBarItem alloc] initWithTitle:@"警情推送" image:[[UIImage imageNamed:@"tabbar_second"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_second_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item2.tag = 2;
    
    UITabBarItem *item3;
    item3 = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_third"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_third_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item3.tag = 3;
    
    SCMainViewController *vc1 = [[SCMainViewController alloc] init];
    vc1.tabBarItem = item1;
    NavViewController *nav1 = [[NavViewController alloc] initWithRootViewController:vc1];
    
    SCWarningNotificationViewController *vc2 = [[SCWarningNotificationViewController alloc]init];
    vc2.tabBarItem = item2;
    NavViewController  *nav2 = [[NavViewController alloc]initWithRootViewController:vc2];
    
    SCMyViewController *vc3 = [[SCMyViewController alloc]init];
    vc3.tabBarItem = item3;
    NavViewController *nav3 = [[NavViewController alloc]initWithRootViewController:vc3];
    
    self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    
    self.delegate = self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],
                                                        NSForegroundColorAttributeName :
                                                            MyColor_LightGray
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],
                                                        NSForegroundColorAttributeName : MyColor_Main
                                                        } forState:UIControlStateSelected];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLoginSuccess) name:@"LoginSuccessNotification" object:nil];
    
    [self httpGetData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

//登录成功
- (void)notificationLoginSuccess
{
    //如果用户登录了，那么就调接口判断当前用户是否有未处理的报警
    [self httpGetData];
}

- (void)httpGetData
{
    NSDictionary   *params = @{
                               @"pageNumber" :[NSString stringWithFormat:@"%ld",(long)1],
                               @"pageSize"   :[NSString stringWithFormat:@"%ld",(long)kPageSize],
                               @"policePhone":USERACCOUNT
                               };
    
    [[HttpRequest sharedNetworkRequest] requestOrdinaryPostURL:HTTP_Warning_WarningList params:params target:self hud:NO success:^(id responseObject) {
        
        NSString *result = EncodeFormDic(responseObject, @"code");
        if ([result isEqualToString:@"0"]) {
            NSArray *dataArray = responseObject[@"data"];
            
            NSMutableArray *array = [SCWarningNotificationModel mj_objectArrayWithKeyValuesArray:dataArray];
            
            if (!IsArrEmpty(array)) {
                [self.tabBar showBadgeOnItemIndex:1];
            }else{
                [self.tabBar removeBadgeOnItemIndex:1];
            }
        }
        
    } failure:^(NSError *error) {
    }];
}

#pragma mark - public

- (void)showAPNS:(NSDictionary *)userInfo
{
    NSString *policeTrackType = EncodeFormDic(userInfo, @"policeTrackType");
    NSString *content = EncodeFormDic(userInfo, @"content");
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    
    if ([policeTrackType isEqualToString:@"1"]) {
        
        [self.tabBar showBadgeOnItemIndex:1];
        
        //有电动车丢失
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"立即查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NavViewController *nav = self.childViewControllers[self.selectedIndex];
            self.selectedIndex = 1;
            [nav popToRootViewControllerAnimated:YES];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else if ([policeTrackType isEqualToString:@"2"]){
        //有电动车被找到
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"APNSEndTrackNotification" object:nil];
            
            NavViewController *nav = self.childViewControllers[self.selectedIndex];
            self.selectedIndex = 0;
            [nav popToRootViewControllerAnimated:YES];
        }];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else if ([policeTrackType isEqualToString:@"3"]){
        //用户撤销报警
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"APNSEndTrackNotification" object:nil];
            
            NavViewController *nav = self.childViewControllers[self.selectedIndex];
            self.selectedIndex = 0;
            [nav popToRootViewControllerAnimated:YES];
        }];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}



@end
