//
//  SCWarningNotificationViewController.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCWarningNotificationViewController.h"
#import "SCWarningNotificationCell.h"
#import "SCWarningNotificationModel.h"
#import "SCSearchWarningView.h"

#import "UITabBar+Badge.h"

@interface SCWarningNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray      *_recordArray;
    WZNoDataView        *_noDataView;
    NSInteger           _pageIndex;
    BOOL                _noMoreData;
    
    SCSearchWarningView *_searchWarningView;
}
@property (nonatomic, strong)UIButton *rightItemButton;

@end

@implementation SCWarningNotificationViewController

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        _pageIndex = 1;
        _recordArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    self.isNeedBackItem = NO;
    [super viewDidLoad];
    self.title = @"警情推送";
    
    //首页开启追踪后，通知该页面刷新数据，然后确定小红点是否显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationStartTrack) name:@"StartTrackNotification" object:nil];
    
    [self createViews];
    [self createRefresh];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];;
    
//    [self httpGetData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];;
    
//    if (_searchWarningView) {
//        [_searchWarningView removeFromSuperview];
//        _searchWarningView = nil;
//        _rightItemButton.selected = NO;
//    }
}


#pragma mark - createView
- (void)createViews
{
//    _rightItemButton = [WZUIHelper createButtonWithFrame:CGRectMake(0, 2, 40, 40) title:@"" titleColor:[UIColor blackColor] font:14 normalImage:@"warning_nav_search" selectedImage:@"" target:self selector:@selector(didClickRightButton:)];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightItemButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:YES];
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
/*
 关于刷新和加载
 */
-(void)createRefresh{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [weakSelf httpGetData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [weakSelf httpGetData];
    }];
}

#pragma mark - action

- (void)didClickRightButton:(UIButton *)button
{
    if (!button.isSelected) {
        if (!_searchWarningView) {
            _searchWarningView = [[SCSearchWarningView alloc] initWithSuperView:self.view];
        }
        [_searchWarningView show];
        
        __weak typeof(self) wself = self;
        _searchWarningView.HiddenViewBlock = ^(){
            wself.rightItemButton.selected = !button.selected;
        };
        _searchWarningView.SearchWarningBlock = ^(NSString *phone, NSString *mac){
//            [wself httpSearchDataWithPhone:phone mac:mac];
        };
    }else{
        if (_searchWarningView) {
            [_searchWarningView hiddenWithTime:0.3];
        }
    }
    button.selected = !button.selected;
}


#pragma mark - Notification

- (void)notificationStartTrack
{
    [self httpGetData];
}

#pragma mark - Network

- (void)httpGetData
{
    NSDictionary   *params = @{
                               @"pageNumber" :[NSString stringWithFormat:@"%ld",(long)_pageIndex],
                               @"pageSize"   :[NSString stringWithFormat:@"%ld",(long)kPageSize],
                               @"policePhone" :USERACCOUNT
                               };
    
    [[HttpRequest sharedNetworkRequest] requestOrdinaryPostURL:HTTP_Warning_WarningList params:params target:self hud:NO success:^(id responseObject) {
        DLog(@"res = %@",responseObject);
        NSString *result = EncodeFormDic(responseObject, @"code");
        if ([result isEqualToString:@"0"]) {
            NSArray *dataArray = responseObject[@"data"];
            
            NSMutableArray *array = [SCWarningNotificationModel mj_objectArrayWithKeyValuesArray:dataArray];
            
            if (!IsArrEmpty(array)) {
                [self.tabBarController.tabBar showBadgeOnItemIndex:1];
            }else{
                [self.tabBarController.tabBar removeBadgeOnItemIndex:1];
            }
            
            if (_pageIndex == 1) {
                _recordArray = array;
            }else{
                [_recordArray addObjectsFromArray:array];
            }
            
            if (array.count < kPageSize) {
                _noMoreData = YES;
            }else{
                _noMoreData = NO;
            }
        }
        [self checkDataOrNot];
        [self reloadTableView];
        
    } failure:^(NSError *error) {
        [self.view showHUDTextAtCenter:kFailRequestDefaultTip];
    }];
}

- (void)reloadTableView
{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    if (_noMoreData) {
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)checkDataOrNot
{
    if (IsArrEmpty(_recordArray)) {
        if (_noDataView == nil) {
            _noDataView = [[WZNoDataView alloc] initWithFrame:CGRectMake(0, 0, MSW, self.tableView.height)];
        }
        [_noDataView showInSuperView:self.tableView withImageView:@"empty" withTipsString:@"没有相关数据"];
    }else{
        if (_noDataView != nil) {
            [_noDataView hidden];
        }
    }
}

#pragma mark - Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _recordArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cardCell = @"CellIdentifier";
    SCWarningNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCell];
    if (!cell) {
        cell = [[SCWarningNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cardCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    SCWarningNotificationModel *model = _recordArray[indexPath.row];
    cell.warningModel = model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCWarningNotificationModel *model = _recordArray[indexPath.row];
    
    if ([[Config currentConfig].isTracking boolValue]) {
        [self.view showHUDTextAtCenter:@"有正在追踪的电动车"];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidSelectedWarningNotification" object:model];
        self.tabBarController.selectedIndex = 0;
    }
}


@end
