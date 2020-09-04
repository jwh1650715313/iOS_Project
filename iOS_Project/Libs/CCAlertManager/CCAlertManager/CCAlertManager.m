//
//  CCAlertManager.m
//  CCAlertManager
//
//  Created by 蔡成汉 on 2019/11/28.
//  Copyright © 2019 蔡成汉. All rights reserved.
//

#import "CCAlertManager.h"
#import <objc/message.h>

@interface CCAlertModel : NSObject

@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, copy) NSArray<Class> *controllers;
@property (nonatomic, assign) BOOL animated;

@end

@implementation CCAlertModel

@end


@interface CCAlertManager ()

@property (nonatomic, strong) NSMutableArray<CCAlertModel *> *alertArray;
@property (nonatomic, assign) BOOL isAlerting;

@end

@implementation CCAlertManager

+ (instancetype)sharedManager {
    static CCAlertManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CCAlertManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.alertArray = [NSMutableArray array];
        self.isAlerting = NO;
    }
    return self;
}

- (void)addAlert:(UIViewController *)alert controllers:(NSArray<Class> *)controllers {
    [self addAlert:alert controllers:controllers animated:YES];
}

- (void)addAlert:(UIViewController *)alert controllers:(NSArray<Class> *)controllers animated:(BOOL)animated {
    if ([self canAdd:alert]) {
        CCAlertModel *model = [[CCAlertModel alloc]init];
        model.controller = alert;
        model.controllers = controllers;
        model.animated = animated;
        [self.alertArray addObject:model];
        [self tryAlert:0];
    } else {
        alert = nil;
    }
}

- (BOOL)canAdd:(UIViewController *)controller {
    BOOL canAdd = YES;
    for (CCAlertModel *model in self.alertArray) {
        if ([controller isKindOfClass:model.controller.class]) {
            canAdd = NO;
            break;
        }
    }
    return canAdd;
}

- (void)tryAlert:(NSTimeInterval)delay {
    if (!self.isAlerting && self.alertArray.count > 0) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf getAlert:^(CCAlertModel *model) {
                if (model) {
                    weakSelf.isAlerting = YES;
                    model.controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    model.controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    UIViewController *rootViewController = nil;
                    for (UIWindow *window in UIApplication.sharedApplication.windows) {
                        if (window.isKeyWindow) {
                            rootViewController = window.rootViewController;
                            break;
                        }
                    }
                    if (rootViewController) {
                        [rootViewController presentViewController:model.controller animated:model.animated completion:^{
                            [model.controller cc_didAlert];
                        }];
                        __weak typeof(model) weakModel = model;
                        model.controller.cc_deallocCallBack = ^{
                            [weakSelf.alertArray removeObject:weakModel];
                            weakSelf.isAlerting = NO;
                            [weakSelf tryAlert:0];
                        };
                    } else {
                        [weakSelf tryAlert:1];
                    }
                } else {
                    [weakSelf tryAlert:1];
                }
            }];
        });
    }
}

- (void)getAlert:(void(^)(CCAlertModel *model))complete {
    CCAlertModel *alertModel = nil;
    for (NSInteger i = 0; i < self.alertArray.count; i++) {
        CCAlertModel *model = self.alertArray[i];
        UIViewController *topController = [self getTopController];
        if (topController.view.superview && topController.view.window) {
            if ([model.controllers containsObject:topController.class]) {
                alertModel = model;
                break;
            }
        }
    }
    if (complete) {
        complete(alertModel);
    }
}


- (UIViewController *)getRootController {
    UIViewController *controller = nil;
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (window.isKeyWindow) {
            controller = window.rootViewController;
            break;
        }
    }
    return controller;
}


- (UIViewController *)getTopController {
    return [self _getTopController:[self getRootController]];
}

- (UIViewController *)_getTopController:(UIViewController *)rootController {
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        return [self _getTopController:((UITabBarController *)rootController).selectedViewController];
    } else if ([rootController isKindOfClass:[UINavigationController class]]) {
        return [self _getTopController:((UINavigationController *)rootController).visibleViewController];
    } else if (rootController.presentedViewController) {
        return [self _getTopController:rootController.presentedViewController];
    } else {
        return rootController;
    }
}

@end


@interface UIViewController ()

@end

static char CCAlertDeallocCallBackKEY;

@implementation UIViewController (CCAlert)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzledViewDidAppear];
        [self swizzledDismissViewControllerAnimated];
    });
}

+ (void)swizzledViewDidAppear {
    SEL originSelector = @selector(viewDidAppear:);
    SEL swizzledSelector = @selector(cc_viewDidAppear:);
    Method originMethod = class_getInstanceMethod([self class], originSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    BOOL success = class_addMethod([self class], originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

+ (void)swizzledDismissViewControllerAnimated {
    SEL originSelector = @selector(dismissViewControllerAnimated:completion:);
    SEL swizzledSelector = @selector(cc_dismissViewControllerAnimated:completion:);
    Method originMethod = class_getInstanceMethod([self class], originSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    BOOL success = class_addMethod([self class], originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

- (void)cc_viewDidAppear:(BOOL)animated {
    [self cc_viewDidAppear:animated];
    SEL selector = NSSelectorFromString(@"tryAlert:");
    if ([[CCAlertManager sharedManager] respondsToSelector:selector]) {
           ((void (*)(id, SEL, NSTimeInterval))objc_msgSend)([CCAlertManager sharedManager], selector, 1);
    }
}

- (void)cc_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self cc_dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.cc_deallocCallBack) {
                self.cc_deallocCallBack();
            }
        });
    }];
}

- (void)setCc_deallocCallBack:(void (^)(void))cc_deallocCallBack {
    objc_setAssociatedObject(self, &CCAlertDeallocCallBackKEY, cc_deallocCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))cc_deallocCallBack {
    return objc_getAssociatedObject(self, &CCAlertDeallocCallBackKEY);
}

- (void)cc_didAlert {
    
}

@end
