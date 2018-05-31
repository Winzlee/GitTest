//
//  WZPickView.m
//  WZPickView
//
//  Created by liwenzhi on 14-11-18.
//  Copyright (c) 2014年 lwz. All rights reserved.
//
//  选择器

#define WZToobarHeight 40
#import "WZPickView.h"

@interface WZPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView                      *_bgView;
}

@property (nonatomic,copy  ) NSString       *plistName;
@property (nonatomic,strong) NSArray        *plistArray;
@property (nonatomic,assign) BOOL           isLevelArray;
@property (nonatomic,assign) BOOL           isLevelString;
@property (nonatomic,assign) BOOL           isLevelDic;
@property (nonatomic,strong) NSDictionary   *levelTwoDic;
@property (nonatomic,strong) UIToolbar      *toolbar;
@property (nonatomic,strong) UIPickerView   *pickerView;
@property (nonatomic,strong) UIDatePicker   *datePicker;
@property (nonatomic,assign) NSDate         *defaulDate;
@property (nonatomic,assign) BOOL           isHaveNavControler;
@property (nonatomic,assign) NSInteger      pickeviewHeight;
@property (nonatomic,copy  ) NSString       *resultString;
@property (nonatomic,strong) NSMutableArray *componentArray;
@property (nonatomic,strong) NSMutableArray *dicKeyArray;
@property (nonatomic,copy  ) NSMutableArray *state;
@property (nonatomic,copy  ) NSMutableArray *city;
@property (nonatomic,assign) NSInteger      tag2;
@property (nonatomic,copy  ) NSString       *title;


@property (nonatomic,copy  ) NSString       *day;
@property (nonatomic,copy  ) NSString       *hour;
@property (nonatomic,copy  ) NSString       *minute;

@property (nonatomic,assign) int            menuId;

@end

@implementation WZPickView

-(NSArray *)plistArray{
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

-(NSArray *)componentArray{

    if (_componentArray==nil) {
        _componentArray=[[NSMutableArray alloc] init];
    }
    return _componentArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpToolBar];
        
    }
    return self;
}


-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler
{
    self=[super init];
    if (self) {
        _plistName=plistName;
        self.plistArray=[self getPlistArrayByplistName:plistName];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        
    }
    return self;
}
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler tag:(NSInteger)tag title:(NSString *)title
{
    self.title = title;
    self=[super init];
    if (self) {
        self.plistArray=array;
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        self.tag2 = tag;
    }
    return self;
}

-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler tag:(NSInteger)tag{
    
    self=[super init];
    if (self) {
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        [self setFrameWith:isHaveNavControler];
        self.tag2 = tag;
    }
    return self;
}


-(NSArray *)getPlistArrayByplistName:(NSString *)plistName{
    
    NSString *path= [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray * array=[[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}

-(void)setArrayClass:(NSArray *)array{
    _dicKeyArray=[[NSMutableArray alloc] init];
    for (id levelTwo in array) {
        
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            _isLevelArray=YES;
            _isLevelString=NO;
            _isLevelDic=NO;
        }else if ([levelTwo isKindOfClass:[NSString class]]){
            _isLevelString=YES;
            _isLevelArray=NO;
            _isLevelDic=NO;
            
        }else if ([levelTwo isKindOfClass:[NSDictionary class]])
        {
            _isLevelDic=YES;
            _isLevelString=NO;
            _isLevelArray=NO;
            _levelTwoDic=levelTwo;
            [_dicKeyArray addObject:[_levelTwoDic allKeys]];
        }
    }
}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = _pickeviewHeight+WZToobarHeight;
    CGFloat toolViewY ;
    if (isHaveNavControler) {
        toolViewY= MSH-toolViewH-50;
    }else {
        toolViewY= MSH-toolViewH;
    }
    CGFloat toolStartY = MSH;
    CGFloat toolViewW = MSW;
    // pickerView出现的时候添加动画效果
    self.frame = CGRectMake(toolViewX, toolStartY, toolViewW, toolViewH);
    [UIPickerView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)setUpPickView{
    
    UIPickerView *pickView=[[UIPickerView alloc] init];
    pickView.backgroundColor=RGBCOLOR(234, 234, 234);
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.frame=CGRectMake(0, WZToobarHeight, MSW, 150);
    _pickerView=pickView;
    _pickeviewHeight=pickView.frame.size.height;
    [self addSubview:pickView];
}

-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor whiteColor];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker=datePicker;
    datePicker.frame=CGRectMake(0, WZToobarHeight, MSW, datePicker.frame.size.height);
    _pickeviewHeight=datePicker.frame.size.height;
    [self addSubview:datePicker];
}

-(void)setUpToolBar{
    _toolbar=[self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self setToolbarTintColor:[UIColor grayColor]];
    [self addSubview:_toolbar];
}
-(UIToolbar *)setToolbarStyle{
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW - 120, 40)];
    lbl.center = toolbar.center;
    lbl.text = self.title;
    lbl.textAlignment = NSTextAlignmentCenter;
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, 0, 50, 40)];
    [leftBtn setTitle:@"  取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, 0, 50, 40)];
    [rightBtn setTitle:@"确定  " forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"   取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
//    // 中间什么都不显示
//    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定   " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithCustomView:lbl];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    toolbar.items=@[lefttem,centerSpace,right];
    
    return toolbar;
}
-(void)setToolbarWithPickViewFrame{
    _toolbar.frame=CGRectMake(0, 0, MSW, WZToobarHeight);
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger component = 0;
    if (_isLevelArray) {
        component=_plistArray.count;
    } else if (_isLevelString){
        component=1;
    }else if(_isLevelDic){
        component=[_levelTwoDic allKeys].count*2;
    }
    return component;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rowArray=[[NSArray alloc] init];
    if (_isLevelArray) {
        rowArray=_plistArray[component];
    }else if (_isLevelString){
        rowArray=_plistArray;
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        for (id dicValue in [dic allValues]) {
                if ([dicValue isKindOfClass:[NSArray class]]) {
                    if (component%2==1) {
                        rowArray=dicValue;
                    }else{
                        rowArray=_plistArray;
                    }
            }
        }
    }
    return rowArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowTitle=nil;
    if (_isLevelArray) {
        rowTitle=_plistArray[component][row];
    }else if (_isLevelString){
        rowTitle=_plistArray[row];
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        if(component%2==0)
        {
            rowTitle=_dicKeyArray[row][component];
        }
        for (id aa in [dic allValues]) {
           if ([aa isKindOfClass:[NSArray class]]&&component%2==1){
                NSArray *bb=aa;
                if (bb.count>row) {
                    rowTitle=aa[row];
                }
                
            }
        }
    }
    return rowTitle;
}

// 自定义显示的字体大小及样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 8.0f;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_isLevelDic&&component%2==0) {
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (_isLevelString) {
        _resultString = _plistArray[row];
        _menuId = (int)row;
    }else if (_isLevelArray){
        _resultString=@"";
        if (![self.componentArray containsObject:@(component)]) {
            [self.componentArray addObject:@(component)];
        }
        for (int i=0; i<_plistArray.count;i++) {
            if ([self.componentArray containsObject:@(i)]) {
                NSInteger cIndex = [pickerView selectedRowInComponent:i];
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][cIndex]];
                if (i == 0) {
                    _day = [NSString stringWithFormat:@"%@",_plistArray[i][cIndex]];
                }
                if (i == 1) {
                    _hour = [NSString stringWithFormat:@"%@",_plistArray[i][cIndex]];
                }
                if (i == 2) {
                    _minute = [NSString stringWithFormat:@"%@",_plistArray[i][cIndex]];
                }
            }else{
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                if (i == 0) {
                    _day = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                }
                if (i == 1) {
                    _hour = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                }
                if (i == 2) {
                    _minute = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                }
            }
        }
    }else if (_isLevelDic){
        if (component==0) {
          _state =_dicKeyArray[row][0];
        }else{
            NSInteger cIndex = [pickerView selectedRowInComponent:0];
            NSDictionary *dicValueDic=_plistArray[cIndex];
            NSArray *dicValueArray=[dicValueDic allValues][0];
            if (dicValueArray.count>row) {
                _city =dicValueArray[row];
            }
        }
    }
}

-(void)remove{
    [self removeFromSuperview];
    [_bgView removeFromSuperview];
}
-(void)show{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.2;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)doneClick
{
    if (_pickerView) {
        
        if (_resultString) {
           
        }else{
            if (_isLevelString) {
                _resultString=[NSString stringWithFormat:@"%@",_plistArray[0]];
                _menuId = 0;
            }else if (_isLevelArray){
                _resultString=@"";
                for (int i=0; i<_plistArray.count;i++) {
                    _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                    if (i == 0) {
                        _day = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                    }
                    if (i == 1) {
                        _hour = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                    }
                    if (i == 2) {
                        _minute = [NSString stringWithFormat:@"%@",_plistArray[i][0]];
                    }
                }
            }else if (_isLevelDic){
                
                if (_state==nil) {
                     _state =_dicKeyArray[0][0];
                    NSDictionary *dicValueDic=_plistArray[0];
                    if (_city == nil) {
                        
                        _city=[dicValueDic allValues][0][0];
                    }
                    
                }
                if (_city==nil){
                    NSInteger cIndex = [_pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic=_plistArray[cIndex];
                    _city=[dicValueDic allValues][0][0];
                    
                }
              _resultString=[NSString stringWithFormat:@"%@ %@",_state,_city];
           }
        }
    }else if (_datePicker) {
      
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //HH表示24小时制
//        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = _datePicker.date;
        NSString *dateStr = [formatter stringFromDate:date];
        
        _resultString=[NSString stringWithFormat:@"%@",dateStr];
    }
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:tag:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:(NSString *)_resultString tag:self.tag2];
    }
    [self removeFromSuperview];
    [_bgView removeFromSuperview];
}
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColor:(UIColor *)color{
    _pickerView.backgroundColor=color;
}
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color{
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color{
    
    _toolbar.barTintColor=color;
}
-(void)dealloc{
    
    //NSLog(@"销毁了");
}
@end

