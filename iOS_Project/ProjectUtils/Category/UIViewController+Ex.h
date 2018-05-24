//
//  UIViewController+Ex.h
//  BaseProject
//
//  Created by wujianming on 16/9/23.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Ex)

- (void)alertWithSytle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg cancleTitle:(NSString *)cTitle;
- (void)alertWithSytle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg sureTitle:(NSString *)sTitle cancleTitle:(NSString *)cTitle sure:(void (^)())sure cancle:(void (^)())cancle;

- (void)alertWithSytless:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg sureTitle:(NSString *)sTitle cancleTitle:(NSString *)cTitle sure:(void (^)())sure cancle:(void (^)())cancle ;

/** 拨打电话样式 */
- (void)alerWithPhone:(NSString *)phoneNumber descrition:(NSString *)descrition completion:(void (^)())completion;

+(UIViewController*) currentViewController;

+ (UINavigationController *)currentNavigationController;


@end
