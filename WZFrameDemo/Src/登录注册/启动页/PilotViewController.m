//
//  PilotViewController.m
//  BiBei
//
//  Created by TOMOON_PRO_1 on 16/4/19.
//  Copyright © 2016年 TOMOON_PRO_1. All rights reserved.
//

#import "PilotViewController.h"
#import "LoginViewController.h"


@interface PilotViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIImageView *bgImageView;

@end

@implementation PilotViewController

{
    UIScrollView *myScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *imageArray = [[NSArray alloc]initWithObjects:@"introduction_page_01",@"introduction_page_02",@"introduction_page_03",@"introduction_page_04", nil];
    
    myScroll = [[UIScrollView alloc]init];
    [self.view addSubview:myScroll];
//    myScroll.hidden = YES;
    
    myScroll.contentSize = CGSizeMake(kWIDTH * imageArray.count, 0);
    myScroll.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    myScroll.pagingEnabled = YES;
    myScroll.showsVerticalScrollIndicator = NO;
    myScroll.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *view = [UIImageView new];
        view.image = [UIImage imageNamed:imageArray[i]];
        view.backgroundColor = [UIColor whiteColor];
        [myScroll addSubview:view];
        view.frame = CGRectMake(kWIDTH * i, 0, kWIDTH, kHEIGHT);
                
        if (i == imageArray.count - 1) {
            view.userInteractionEnabled = YES;
            UIButton *btn = [[UIButton alloc]init];
            [view addSubview:btn];
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitle:@"立即使用" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:@"#03c49e"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            btn.layer.borderColor = [UIColor colorWithHex:@"#03c49e"].CGColor;
            btn.layer.borderWidth = 2;
            if (kHEIGHT == 480) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((kWIDTH - 120)/2));
                    make.width.equalTo(@120);
                    make.bottom.equalTo(@-150);
                    make.height.equalTo(@38);
                }];
            }else if (kHEIGHT == 568){
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((kWIDTH - 120)/2));
                    make.width.equalTo(@120);
                    make.bottom.equalTo(@-175);
                    make.height.equalTo(@38);
                }];
            }
            else if(kHEIGHT == 667){
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((kWIDTH - 120)/2));
                    make.width.equalTo(@120);
                    make.bottom.equalTo(@-200);
                    make.height.equalTo(@38);
                }];
            }else{
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@((kWIDTH - 120)/2));
                    make.width.equalTo(@120);
                    make.bottom.equalTo(@-230);
                    make.height.equalTo(@38);
                }];
            }
            
        }
    }
    
//    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//    [self.view addSubview:_bgImageView];
//    [_bgImageView setBackgroundColor:[UIColor colorWithHexString:@"03c49e" alpha:1]];
    
//    [self connect];
}

- (void)connect
{
//    [HGPostRequest httpsPostWithBaseURL:[NSString stringWithFormat:@"%@/loaddingBanner",KHTTPS] params:nil success:^(id JSON) {
//        
//        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[JSON objectForKey:@"data"]]];
//        
////        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeView) userInfo:nil repeats:YES];
//        //此方法是单线程.只有当调用此方法的函数体执行完毕后再执行 @selector()里面的方法
//        [self performSelector:@selector(removeView) withObject:nil afterDelay:1];
//        
//    } failure:^(NSError *error) {
////        [self connect];
//        [myScroll setHidden:NO];
//    }];
}

- (void)removeView
{
    [self.bgImageView removeFromSuperview];
    myScroll.hidden = NO;
}

-(void)btnClick{
    
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
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
