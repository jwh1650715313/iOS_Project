//
//  MBProgressHUD+Ex.h
//  QianLongZan
//
//  Created by wujianming on 16/9/28.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Ex)

// 菊花模式
+ (void)show;
+ (void)hide;
+ (void)showInView:(UIView *)view;
+ (void)hideFromView:(UIView *)view;

// 纯文本模式
+ (void)showMsg:(NSString *)msg;
+ (void)showMsg:(NSString *)msg inView:(UIView *)view;

// 菊花文本模式
+ (void)showLoadingWithMsg:(NSString *)msg;
+ (void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view;

@end
