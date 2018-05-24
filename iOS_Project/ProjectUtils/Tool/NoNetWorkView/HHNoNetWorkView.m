//
//  HHNoNetWorkView.m
//  iOS_Project
//
//  Created by 金永学 on 2018/4/25.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHNoNetWorkView.h"

@implementation HHNoNetWorkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=WhiteColor;
        
        [self addSubview:self.logo];
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(SCALE_HEIGHT(100.0));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(@120);
            make.width.mas_equalTo(@120);
        }];
        
        [self addSubview:self.msg];
        [self.msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.top.mas_equalTo(self.logo.mas_bottom).offset(SCALE_HEIGHT(20.0));
            make.height.mas_equalTo(@18);
        }];
       
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msg.mas_bottom).offset(70);
            make.height.mas_equalTo(@45);
            make.width.mas_equalTo(@160);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    
     return self;
}

-(UIImageView *)logo
{
    if (!_logo) {
        _logo=[[UIImageView alloc]init];
        _logo.backgroundColor=[UIColor clearColor];
    }
    return _logo;
}

-(UILabel *)msg
{
    if (!_msg) {
        
        _msg = [[UILabel alloc] init];
        _msg.font = Font(17);
        _msg.textColor = kMinorColor;
        _msg.textAlignment = NSTextAlignmentCenter;
        _msg.numberOfLines = 0;
        
    }
    return _msg;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = Font(17);
        _button.layer.borderWidth = 1.0f;
        _button.layer.borderColor = [UIColor colorWithHexString:@"3a3d5c"].CGColor;
        _button.layer.cornerRadius = 2.0f;
        _button.clipsToBounds = YES;
        [_button setTitle:@"重新加载" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithHexString:@"3d405f"] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:WhiteColor] forState:UIControlStateHighlighted];
        _button.hidden = YES; // 默认隐藏
    }
    return _button;
}


@end
