//
//  SCMyHeaderCell.m
//  SameCity
//
//  Created by 庞氏科技 on 2017/7/6.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "SCMyHeaderCell.h"
#import "SCMyHeaderButton.h"

@interface SCMyHeaderCell ()
{
    UIView          *_topView;
    UIImageView     *_portraitPic;     //用户头像
    
    UIView              *_bottomView;
    SCMyHeaderButton    *_firstButton;
    SCMyHeaderButton    *_secondButton;
}
@end

@implementation SCMyHeaderCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView
{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = MyColor_Nav;
    [self addSubview:_topView];
    
    _portraitPic = [[UIImageView alloc] init];
    _portraitPic.image = [UIImage imageNamed:@"my_head"];
    _portraitPic.layer.masksToBounds = YES;
    _portraitPic.layer.cornerRadius = 40;
    _portraitPic.contentMode = UIViewContentModeScaleAspectFill;
    [_topView addSubview:_portraitPic];
    
    _loginNameLabel = [[UILabel alloc] init];
    _loginNameLabel.textColor = [UIColor whiteColor];
    _loginNameLabel.font = [UIFont mysystemFontOfSize:15];
//    _loginNameLabel.text = USERACCOUNT;
    _loginNameLabel.textAlignment = NSTextAlignmentCenter;
    _firstButton.tag = 103;
    [_topView addSubview:_loginNameLabel];
    
    _bottomView = [[UIView alloc]init];
    [self addSubview:_bottomView];
    
    _firstButton = [[SCMyHeaderButton alloc]initWithimageName:@"my_icon_warning" title:@"历史报警"];
    _firstButton.tag = 101;
    _firstButton.redView.hidden = YES;
    [_firstButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_firstButton];
    
    _secondButton = [[SCMyHeaderButton alloc]initWithimageName:@"my_icon_statistics" title:@"统计"];
    _secondButton.tag = 102;
    _secondButton.redView.hidden = YES;
    [_secondButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_secondButton];
}

- (void)layoutSubviews
{
    _topView.frame = CGRectMake(0, 0, self.width, self.height - 100);
    _portraitPic.frame = CGRectMake((self.width - 80)/2, (_topView.height - 80)/2, 80, 80);
    _loginNameLabel.frame = CGRectMake((self.width - 200)/2, _portraitPic.bottom, 200, 40);
    
    _bottomView.frame = CGRectMake(0, _topView.bottom, self.width, 100);
    _firstButton.frame = CGRectMake(0, 0, kWIDTH/2, 100);
    _secondButton.frame = CGRectMake(_firstButton.right, 0, kWIDTH/2, 100);
}

- (void)didClickButton:(UIButton *)button
{
    self.MyHeaderBlock(button.tag);
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
