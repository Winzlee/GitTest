//
//  SCHistoryWarningViewController.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCHistoryWarningViewController.h"
#import "SCHistoryWarningCell.h"
#import "SCWarningNotificationModel.h"

@interface SCHistoryWarningViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray      *_recordArray;
    WZNoDataView        *_noDataView;
    NSInteger           _pageIndex;
    BOOL                _noMoreData;
    
    NSTimer             *_uploadPoliceTimer;
}

@end

@implementation SCHistoryWarningViewController

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
    [super viewDidLoad];
    self.title = @"历史警情";
    
    [self createViews];
    [self createRefresh];
    [self httpGetData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark - createView
- (void)createViews
{
    CGRect frame = [self visibleBoundsShowNav:YES showTabBar:NO];
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



#pragma mark - Network

- (void)httpGetData
{
    NSDictionary   *params = @{
                               @"pageNumber"  :[NSString stringWithFormat:@"%ld",(long)_pageIndex],
                               @"pageSize"    :[NSString stringWithFormat:@"%ld",(long)kPageSize],
                               @"policePhone" :USERACCOUNT};
    DLog(@"params = %@",params);
    
    [[HttpRequest sharedNetworkRequest] requestOrdinaryPostURL:HTTP_Warning_HistoryList params:params target:self hud:YES success:^(id responseObject) {
        DLog(@"res = %@",responseObject);
        NSString *code = EncodeFormDic(responseObject, @"code");
        if ([code isEqualToString:@"0"]) {
            NSArray *dataArray = responseObject[@"data"];
            
            NSMutableArray *array = [SCWarningNotificationModel mj_objectArrayWithKeyValuesArray:dataArray];
            
            
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
    return 85;
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
    SCHistoryWarningCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCell];
    if (!cell) {
        cell = [[SCHistoryWarningCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cardCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SCWarningNotificationModel *model = _recordArray[indexPath.section];
    cell.warningModel = model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCWarningNotificationModel *model = _recordArray[indexPath.section];
    
    //追踪中的数据才可以点击
    if ([model.status isEqualToString:@"2"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidSelectedWarningNotification" object:model];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
