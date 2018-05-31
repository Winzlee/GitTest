//
//  SCMyViewController.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCMyViewController.h"
#import "SCUserCenterViewController.h"
#import "SCTrackNumberViewController.h"
#import "SCHistoryWarningViewController.h"
#import "SCSettingViewController.h"

#import "SCMyHeaderCell.h"

@interface SCMyViewController (){
    
    
}
@property (nonatomic,strong)NSArray      *dataArray;
@end

@implementation SCMyViewController


-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"我的";
        self.isNeedBackItem = NO;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLoginSuccess) name:@"LoginSuccessNotification" object:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Mine" ofType:@"plist"];
    _dataArray = [NSArray arrayWithContentsOfFile:path];
    
    CGRect frame = CGRectMake(0, 0, mywidth, MSH - 49);
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.showsVerticalScrollIndicator = false;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}


//登录成功
- (void)notificationLoginSuccess
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    SCMyHeaderCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.loginNameLabel.text = USERACCOUNT;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return mywidth/1.6 + 100;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *cellID = @"CellID0";
        SCMyHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[SCMyHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.loginNameLabel.text = USERACCOUNT;
        
        cell.MyHeaderBlock = ^(NSInteger index){
            if (index == 101) {
                SCHistoryWarningViewController *vc = [[SCHistoryWarningViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                SCTrackNumberViewController *vc = [[SCTrackNumberViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        
        return cell;
    }else{
        
        static NSString *myViewCellIdentifier = @"CellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myViewCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:myViewCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont mysystemFontOfSize:14];
        }
        
        NSDictionary *dict = _dataArray[indexPath.section - 1];
        
        cell.textLabel.text = dict[@"title"];
        
        CGSize size = CGSizeMake(25, 25);
        UIImage *image = [UIImage imageNamed:dict[@"image"]];
        cell.imageView.image = image;
        cell.imageView.size = size;
        //调整image的大小
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SCUserCenterViewController *vc = [[SCUserCenterViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSDictionary *dict = _dataArray[indexPath.section - 1];
        
        SCSettingViewController *vc = [[SCSettingViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = dict[@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
