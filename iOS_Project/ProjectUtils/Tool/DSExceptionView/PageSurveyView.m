//
//  PageSurveyView.m
//  QianLongZan
//
//  Created by wujianming on 16/10/9.
//  Copyright © 2016年 szteyou. All rights reserved.
//  页面信息反馈

#import "PageSurveyView.h"

@interface PageSurveyView ()

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *msg;
@property (strong, nonatomic) UIButton *button;
@property (copy, nonatomic) PageSurveyViewBlock block;

@end

@implementation PageSurveyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logo = [[UIImageView alloc] init];
        [self.logo setContentMode:UIViewContentModeBottom];
        self.logo.backgroundColor=[UIColor clearColor];
        [self addSubview:self.logo];
        
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15.0);
            make.right.mas_equalTo(self.mas_right).offset(-15.0);
//          make.bottom.mas_equalTo(self.mas_centerY);
            make.top.mas_equalTo(self.mas_top).offset(100);
        }];
        
        self.msg = [[UILabel alloc] init];
        self.msg.font = Font(SCALE_HEIGHT(17));
        self.msg.textColor = [UIColor colorWithHexString:@"8d8d96"];
        self.msg.textAlignment = NSTextAlignmentCenter;
        self.msg.numberOfLines = 0;
        [self addSubview:self.msg];
        
        [self.msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15.0);
            make.right.mas_equalTo(self.mas_right).offset(-15.0);
            make.top.mas_equalTo(self.logo.mas_bottom).offset(20.0);
        }];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.titleLabel.font = [UIFont systemFontOfSize:17];
        self.button.layer.borderWidth = 1.0f;
        self.button.layer.borderColor = [UIColor colorWithHexString:@"3a3d5c"].CGColor;
        self.button.layer.cornerRadius = 3.0f;
        self.button.clipsToBounds = YES;
        [self.button setTitle:@"重新加载" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor colorWithHexString:@"3d405f"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageWithColor:kViewBackgroundColor] forState:UIControlStateHighlighted];
        
        [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        self.button.hidden = YES; // 默认隐藏
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msg.mas_bottom).offset(70);
            make.height.mas_equalTo(@45);
            make.width.mas_equalTo(@160);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = kViewBackgroundColor;
    }
    
    return self;
}

+ (void)showViewWithType:(ExceptionViewType)type toView:(UIView *)view
{
    NSString *msg = @"";
    NSString *ImgName = @"zanwushuju";
    switch (type) {
        case ExceptionViewType_NetWorkError:
        {
            msg = @"网络异常";
        }
            break;
        case ExceptionViewType_ServerError:
        {
            msg = @"服务异常";
        }
            break;
        case ExceptionViewType_NoData:
        {
            msg = @"暂无数据";
        }
            break;
        case ExceptionViewType_Error:
        {
            msg = @"此二维码无效,请联系场馆工作人员";
        }
            break;
        default:
            break;
    }
    
    [self showMsg:msg withIconName:ImgName toView:view];
}

+ (void)showViewWithType:(ExceptionViewType)type toView:(UIView *)view yOffset:(CGFloat)y
{
    NSString *msg = @"";
    NSString *ImgName = @"zanwushuju";
    switch (type) {
        case ExceptionViewType_NetWorkError:
        {
            msg = @"网络异常";
        }
            break;
        case ExceptionViewType_ServerError:
        {
            msg = @"服务异常";
        }
            break;
        case ExceptionViewType_NoData:
        {
            msg = @"暂无数据";
        }
            break;
            
        default:
            break;
    }
    
    [self showMsg:msg withIconName:ImgName toView:view yOffset:y];
}

+ (void) showViewWithText:(NSString *)text toView:(UIView *)view{
    NSString *msg = text?:@"服务异常";
    NSString *ImgName = @"zanwushuju";
    [self showMsg:msg withIconName:ImgName toView:view];
}

+ (void)showViewWithText:(NSString *)text toView:(UIView *)view yOffset:(CGFloat)y{
    NSString *msg = text?:@"服务异常";
    NSString *ImgName = @"zanwushuju";
    [self showMsg:msg withIconName:ImgName toView:view yOffset:y];
}

+ (void)showMsg:(NSString *)msg withIconName:(NSString *)iconN toView:(UIView *)view {
    for (UIView *sView in view.subviews) {
        if ([sView isKindOfClass:[PageSurveyView class]]) {
            return;
        }
    }
    
    PageSurveyView *sView = [[PageSurveyView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    sView.logo.image = [UIImage imageNamed:iconN];
    sView.msg.text = msg;
    [view addSubview:sView];
}

+ (void)showMsg:(NSString *)msg withIconName:(NSString *)iconN toView:(UIView *)view yOffset:(CGFloat)y {
    for (UIView *sView in view.subviews) {
        if ([sView isKindOfClass:[PageSurveyView class]]) {
            return;
        }
    }
    
    PageSurveyView *sView = [[PageSurveyView alloc] initWithFrame:CGRectMake(0, y, view.bounds.size.width, view.bounds.size.height - y)];
    sView.logo.image = [UIImage imageNamed:iconN];
    sView.msg.text = msg;
    [view addSubview:sView];
}

+ (void)hideFromView:(UIView *)view {
    for (UIView *sView in view.subviews) {
        if ([sView isKindOfClass:[PageSurveyView class]]) {
            [sView removeFromSuperview];
        }
    }
}

// 有按钮的
+ (void)showButtonViewWithType:(ExceptionViewType)type
                        toView:(UIView *)view
                       yOffset:(CGFloat)y
                   ButtonBlock:(PageSurveyViewBlock)block
{
    NSString *msg = @"";
    NSString *ImgName = @"zanwushuju";
    switch (type) {
        case ExceptionViewType_NetWorkError:
        {
            msg = @"网络异常";
        }
            break;
        case ExceptionViewType_ServerError:
        {
            msg = @"服务异常";
        }
            break;
        case ExceptionViewType_NoData:
        {
            msg = @"暂无数据";
        }
            break;
            
        default:
            break;
    }
    [self showButtonViewWithMsg:msg
                   withIconName:ImgName
                         toView:view
                        yOffset:y
                    ButtonBlock:block];
}

//定义的
+ (void)showButtonWithText:(NSString *)text
                   BtnText:(NSString *)BtnText
              withIconName:(NSString *)iconN
                    toView:(UIView *)view
                   yOffset:(CGFloat)y
               ButtonBlock:(PageSurveyViewBlock)block
{
    NSString *ImgName =iconN.length>0?iconN:@"no-message";
    
    
    for (UIView *sView in view.subviews) {
        if ([sView isKindOfClass:[PageSurveyView class]]) {
            return;
        }
    }
    
    PageSurveyView *sView = [[PageSurveyView alloc] initWithFrame:CGRectMake(0, y, view.bounds.size.width, view.bounds.size.height - y)];
    sView.logo.image = [UIImage imageNamed:ImgName];
    sView.msg.text = text;
    sView.button.hidden = NO;
    sView.block = block;
    [sView.button setTitle:BtnText forState:UIControlStateNormal];
    sView.backgroundColor = view.backgroundColor;
    [view addSubview:sView];
    
    
    
}



+ (void)showButtonViewWithMsg:(NSString *)msg
                 withIconName:(NSString *)iconN
                       toView:(UIView *)view
                      yOffset:(CGFloat)y
                  ButtonBlock:(PageSurveyViewBlock)block
{
    for (UIView *sView in view.subviews) {
        if ([sView isKindOfClass:[PageSurveyView class]]) {
            return;
        }
    }
    
    PageSurveyView *sView = [[PageSurveyView alloc] initWithFrame:CGRectMake(0, y, view.bounds.size.width, view.bounds.size.height - y)];
    sView.logo.image = [UIImage imageNamed:iconN];
    sView.msg.text = msg;
    sView.button.hidden = NO;
    sView.block = block;
    sView.backgroundColor = view.backgroundColor;
    [view addSubview:sView];
}

// 按钮
- (void)buttonClick
{
    if (self.block) {
        self.block();
    }
}

@end
