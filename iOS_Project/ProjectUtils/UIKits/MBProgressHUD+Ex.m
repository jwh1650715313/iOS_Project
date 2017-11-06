//
//  MBProgressHUD+Ex.m
//  QianLongZan
//
//  Created by wujianming on 16/9/28.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import "MBProgressHUD+Ex.h"

@implementation MBProgressHUD (Ex)

// 纯菊花模式
+ (void)show {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
}

+ (void)hide {
    [MBProgressHUD hideHUDForView:KEY_WINDOW animated:YES];
}

+ (void)showInView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.offset = CGPointMake(0, -NAVIGATION_HEIGHT * 0.5);
}

+ (void)hideFromView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

// 纯文本模式
+ (void)showMsg:(NSString *)msg {
    [MBProgressHUD hide];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:KEY_WINDOW];
    });
}

+ (void)showMsg:(NSString *)msg inView:(UIView *)view {
    [MBProgressHUD hideFromView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.offset = CGPointMake(0, -NAVIGATION_HEIGHT * 0.5);
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideFromView:view];
    });
}

// 菊花文本模式
+ (void)showLoadingWithMsg:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = msg;
}

+ (void)showLoadingWithMsg:(NSString *)msg inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = msg;
}

@end
