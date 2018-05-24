//
//  UIViewController+Ex.m
//  BaseProject
//
//  Created by wujianming on 16/9/23.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import "UIViewController+Ex.h"

@implementation UIViewController (Ex)

- (void)alertWithSytle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg cancleTitle:(NSString *)cTitle {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    UIAlertAction *action = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleDestructive handler:nil];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)alertWithSytle:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg sureTitle:(NSString *)sTitle cancleTitle:(NSString *)cTitle sure:(void (^)())sure cancle:(void (^)())cancle {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:sTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (sure) {
                sure();
            }
        });
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (cancle) {
                cancle();
            }
        });
    }];
    [alertVc addAction:action1];
    [alertVc addAction:action2];
    [self presentViewController:alertVc animated:YES completion:nil];
}


- (void)alertWithSytless:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)msg sureTitle:(NSString *)sTitle cancleTitle:(NSString *)cTitle sure:(void (^)())sure cancle:(void (^)())cancle {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (cancle) {
                cancle();
            }
        });
    }];
    
    [alertVc addAction:action2];
    [self presentViewController:alertVc animated:YES completion:nil];
}



- (void)alerWithPhone:(NSString *)phoneNumber descrition:(NSString *)descrition completion:(void (^)())completion {
    UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:nil message:descrition preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *phone = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"拨打 %@", phoneNumber]
                                                    style:UIAlertActionStyleDestructive
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      if (completion) {
                                                          completion();
                                                      }
                                                  }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alerVc addAction:phone];
    [alerVc addAction:cancle];
    [self presentViewController:alerVc animated:YES completion:nil];
}

+(UIViewController *) findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+(UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UINavigationController *)currentNavigationController
{
    return [UIViewController currentViewController].navigationController;
}





@end
