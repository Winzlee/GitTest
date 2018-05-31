
//
//  CommonViewController.m
//  Winzlee
//
//  Created by liwenzhi on 15/10/14.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
//#import "NavViewController.h"
#import "LoginViewController.h"

#define HTTP_TIMEOUT            3
#define kServerBusyErrorMsg     @"请求失败"


@interface CommonViewController(){
    
}
@property (strong, nonatomic) NSMutableArray *snChildControllers;
@property (unsafe_unretained, nonatomic) CommonViewController *snParentController;
@property (strong, nonatomic) UIView *leftViewNoIcon;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIImageView *leftIcon;
@property (strong, nonatomic) UILabel *leftTitleLbl;
@property (strong, nonatomic) UITapGestureRecognizer *leftTap;

@end

@implementation CommonViewController

@synthesize  tableView = _tableView;

@synthesize  groupTableView = _groupTableView;

@synthesize tpTableView = _tpTableView;

@synthesize isNeedBackItem = _isNeedBackItem;

@synthesize rightBtnItem = _rightBtnItem;


+ (id)controller
{
    return [[self alloc] init];
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"";
        self.isSearchLeftItem = YES;
        self.isNeedBackItem = YES;
        self.hasNav = YES;
        self.iOS7FullScreenLayout = NO;
        self.isSearchLeftItem = NO;
        
        CGRect rect = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
        
        mywidth = rect.size.width;
        myheight = rect.size.height;
        
    }
    return self;
}

- (void)setIOS7FullScreenLayout:(BOOL)iOS7FullScreenLayout
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)HttpRelease
{
    
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_rightBtnItem);
    
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    TT_RELEASE_SAFELY(_tableView);
    
    _groupTableView.dataSource = nil;
    _groupTableView.delegate = nil;
    TT_RELEASE_SAFELY(_groupTableView);
    
    _tpTableView.dataSource = nil;
    _tpTableView.delegate = nil;
    TT_RELEASE_SAFELY(_tpTableView);
    
    TT_RELEASE_SAFELY(_pageInTime);
    
    TT_RELEASE_SAFELY(_specialViewTitle);
    
    [self HttpRelease];
}

- (void)showRightSideView
{
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)addLeftTitle:(BOOL)isHasLeftBtn WithTitle:(NSString*)string WithController:(id)controller
{
    if(isHasLeftBtn == YES)
    {
        if(!IsStrEmpty(self.title))
        {
            
            UILabel *lbl = [[UILabel alloc] init];
            if(string.length > 7)
            {
                lbl.frame = CGRectMake(0, 0, 110, 20);
                
            }
            else
            {
                lbl.frame = CGRectMake(0, 0, 50, 20);
                
            }
            lbl.text = string;
            lbl.textColor = [UIColor whiteColor];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.userInteractionEnabled = YES;
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = [UIFont systemFontOfSize:15];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [lbl addGestureRecognizer:tap];
            
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
            
            
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left_white"]];
            imageV.frame = CGRectMake(0, 0, 10, 15);
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [imageV addGestureRecognizer:tap2];
            
            UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:imageV];
            
            
            self.navigationItem.leftBarButtonItems = @[left1,left];
            
        }
        else
        {
            UILabel *lbl = [[UILabel alloc] init];
            lbl.frame = CGRectMake(0, 0, 200, 20);
            lbl.text = string;
            lbl.textColor = [UIColor whiteColor];
            lbl.font = [UIFont systemFontOfSize:15];
            lbl.textAlignment = NSTextAlignmentLeft;
            lbl.userInteractionEnabled = YES;
            lbl.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [lbl sizeToFit];
            [lbl addGestureRecognizer:tap];
            
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
            
            
            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left_white"]];
            imageV.frame = CGRectMake(0, 0, 10, 15);
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backForePage)];
            [imageV addGestureRecognizer:tap2];
            
            UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:imageV];
            
            
            self.navigationItem.leftBarButtonItems = @[left1,left];
            
        }
    }
    else
    {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = CGRectMake(0, 0, 200, 20);
        lbl.text = string;
        lbl.textColor = [UIColor whiteColor];
        lbl.userInteractionEnabled = YES;
        
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lbl];
        self.navigationItem.leftBarButtonItem = left;
    }
}

- (void)addLeftItem
{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 44, 44);
    left.backgroundColor = [UIColor clearColor];
    [left addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left_white"]];
    arrow.frame = CGRectMake(0, (44 - 20) / 2.0, 20, 20);
    arrow.backgroundColor = [UIColor clearColor];
    
    [left addSubview:arrow];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    if (self.isNeedBackItem) {
        left.hidden = NO;
    }else{
        left.hidden = YES;
    }
}

- (void)backForePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadView
{
    [super loadView];
    [self.view setExclusiveTouch:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = MyColor_Background;
    
    [self addLeftItem];
}

- (void)goToLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 因present 跳转时不在主线程 所以跳转有延迟
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        NavViewController *nav = [[NavViewController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    });
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.sectionHeaderHeight = 0.f;
        _tableView.sectionFooterHeight = 0.f;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = true;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = view;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
        _tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tpTableView.delegate =self;
        [_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tpTableView.scrollEnabled = YES;
        _tpTableView.userInteractionEnabled = YES;
        _tpTableView.backgroundColor = [UIColor clearColor];
        _tpTableView.backgroundView = nil;
        _tpTableView.sectionHeaderHeight = 0.f;
        _tpTableView.sectionFooterHeight = 0.f;
        _tpTableView.dataSource =self;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        _tpTableView.tableFooterView = view;
        
        [self.view addSubview:_tpTableView];
    }
    return _tpTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    DLog(@"Commmon didReceiveMemoryWarning \n");
    
    // Release any cached data, images, etc. that aren't in use.
}


#pragma mark -
#pragma mark utils

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.height -= 20;
    if (hasNav) {
        frame.size.height -= 44;
    }
    if (hasTabBar) {
        frame.size.height -= 48;
    }
    return frame;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}




@end
