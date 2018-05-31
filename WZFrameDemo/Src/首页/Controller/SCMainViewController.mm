//
//  SCMainViewController.m
//  SameCity
//
//  Created by Johnson on 16/4/18.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#import "SCMainViewController.h"
#import "LoginViewController.h"

//#import "BeforeScanSingleton.h"
//#import "SubLBXScanViewController.h"

#import <objc/runtime.h>
#import <WebKit/WebKit.h>

#import "AFURLRequestSerialization.h"

#import "SCDeviceModel.h"


@interface SCMainViewController ()<NSURLSessionDataDelegate,NSCopying,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
{
    CAShapeLayer    *_circleLayer;
    UIImageView     *_imageView;
    int             _currentIndex;
    int             _imageCount;
    
    
    WKWebView * webView;
    WKUserContentController* userContentController;
}
@property(nonatomic, copy)NSString *string;
@property(nonatomic, copy)NSArray *array;
@property(nonatomic, copy)NSArray *array1;




@end

@implementation SCMainViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
    
    NSLog(@"winzlee1");
    
    NSLog(@"winzlee1.1 第一次");
    NSLog(@"winzlee1.1 第二次");
    
    NSLog(@"winzlee2");
    
//    _imageCount = 5;
//
//    //定义图片控件
//    _imageView = [[UIImageView alloc]init];
//    _imageView.frame = [UIScreen mainScreen].applicationFrame;
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _imageView.image = [UIImage imageNamed:@"0"];   //默认图片
//    [self.view addSubview:_imageView];
//    //添加手势
//    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
//    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:leftSwipeGesture];
//
//    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
//    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:rightSwipeGesture];
}

//向左滑动浏览下一张图片
- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:YES];
}
//向右滑动浏览上一张图片
- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    [self transitionAnimation:NO];
}
//转场动画
- (void)transitionAnimation:(BOOL)isNext
{
    //1. 创建转场动画对象
    CATransition *transition = [CATransition animation];
    //2. 设置动画类型，对于苹果官方没有公开的动画类型只能使用字符串；有关键字的比如moveIn，可以直接写成kCATransitionMoveIn。
    transition.type = @"cube";
    // 设置子类型，确定动画的方向
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    // 设置动画时长
    transition.duration = 1.0;
    //3. 设置转场后的新视图添加到转场动画
    _imageView.image = [self getImage:isNext];
    //4. 将动画添加到视图的图层
    [_imageView.layer addAnimation:transition forKey:@"transition"];
}
//取得当前图片
- (UIImage *)getImage:(BOOL)isNext
{
    if (isNext) {
        _currentIndex = (_currentIndex + 1) % _imageCount;
    }else{
        _currentIndex = (_currentIndex - 1 + _imageCount) % _imageCount;
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d",_currentIndex]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



#pragma mark - CreateViews

- (void)createButton
{
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];
    [addButton setTitle:@"按钮" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)circleAnimation {
    _circleLayer.strokeStart = 0;
    _circleLayer.strokeEnd = 0.75;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.duration = 6.f;   // 持续时间
    animation.fromValue = @(0); // 从 0 开始
    animation.toValue = @(1);   // 到 1 结束
    // 保持动画结束时的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_circleLayer addAnimation:animation forKey:@""];
    
    
}
#pragma mark - Action

- (void)didClickButton
{
    [self circleAnimation];
}

#pragma mark - Network


#pragma mark - private


#pragma mark - Notification


#pragma mark - Delegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.view showHUDTextAtCenter:@"内容快满了,建议您清理下内存哦"];
    // Dispose of any resources that can be recreated.
}

- (void)test{
    
    //配置环境
//    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
//    userContentController = [[WKUserContentController alloc] init];
//    configuration.userContentController = userContentController;
//    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) configuration:configuration];
//    //注册方法
////    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
////    delegateController.delegate = self;
//
//    [userContentController addScriptMessageHandler:self  name:@"sayhello"];
//
//    [self.view addSubview:webView];
//    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//    }];
//    webView.UIDelegate = self;
//    webView.navigationDelegate = self;
//    [webView loadRequest:[NSURLRequest requestWithURL:[NS
    
    
    
//    SCDeviceModel *stu = [[SCDeviceModel alloc] init];
//
//    [stu setMac:@"1"];
//
//    [stu release];
//
//    stu = nil;
//
//    [stu setMac:@"2"];
//
    
    
//    NSString *str = @"abc";
//    NSLog(@"str = %p",str);
//
//    self.string = str;
//    NSString *s = [str copy];
//
//    str = @"haha";
//
//
//    NSLog(@"string = %p, str = %p, s = %p",self.string, str, s);
//    NSLog(@"string = %@, str = %@, s = %@",self.string, str, s);
//
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    NSArray *array1 = [NSArray arrayWithObjects:@"111", @"222", nil];
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:button1, button2, nil];
  
//    self.array1 = array1;
//    self.array = array;
    
//    NSLog(@"self.array--class = %@",[self.array class]);
//    //不可变
//    NSLog(@"string = %p, str = %p",self.array1, array1);
//    // 可变
//    NSLog(@"string = %p, str = %p",self.array, array);
//
//    NSLog(@"self.array 1= %p, 2 = %p",self.array[0], self.array[1]);
//    NSLog(@"array 1= %p, 2 = %p",array[0], array[1]);
    

//    // 产生新对象
//    NSArray *copyArray1 = [array mutableCopy];
//    // 产生新对象
//    NSMutableArray *copyArray2 = [array mutableCopy];
//    // 产生新对象
//    NSArray *mutableCopyArray1 = [array mutableCopy];
//    // 产生新对象
//    NSMutableArray *mutableCopyArray = [array mutableCopy];

    
//    NSLog(@"array = %@ class = %@, address = %p",array,[array class],array);
//    NSLog(@"copyArray1 = %@ class = %@, address = %p",copyArray1,[copyArray1 class],copyArray1);
//    NSLog(@"copyArray2 = %@ class = %@, address = %p",copyArray2,[copyArray2 class],copyArray2);
//
//    NSLog(@"copyArray1 1= %p, 2 = %p",copyArray1[0], copyArray1[1]);
//    NSLog(@"array 1= %p, 2 = %p",array[0], array[1]);
//    NSLog(@"copyArray2 1= %p, 2 = %p",copyArray2[0], copyArray2[1]);

//    // 产生新对象
//    NSArray *mutableCopyArray2 = [array1 mutableCopy];
//    NSArray *copyArray3 = [array1 copy];
////
//    NSLog(@"地址: 源 = %p，现 = %p",array1, copyArray3);
//    NSLog(@"地址: 源 = %p，现 = %p",array1, mutableCopyArray2);
//
//
//    NSLog(@"class - array = %@",[array class]);
//    NSLog(@"class - copyArray1 = %@",[copyArray1 class]);
//    NSLog(@"class - copyArray2 = %@",[copyArray2 class]);
//    NSLog(@"class - mutableCopyArray1 = %@",[mutableCopyArray1 class]);
//    NSLog(@"class - mutableCopyArray = %@",[mutableCopyArray class]);
//    NSLog(@"class - mutableCopyArray2 = %@",[mutableCopyArray2 class]);
//
//    [array addObject:@"啊"];
//
//
//
//    NSLog(@"mutableCopyArray1 = %@",mutableCopyArray1);
//    NSLog(@"mutableCopyArray = %@",mutableCopyArray);
//
//    [mutableCopyArray addObject:@"222"];
//    NSLog(@"mutableCopyArray = %@",mutableCopyArray);
//
//    [copyArray2 addObject:@"111"];
//    NSLog(@"copyArray2 = %@",copyArray2);
}





@end




































