//
//  WHSchemeHandler.m
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/4.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import "WHSchemeHandler.h"
#import <objc/runtime.h>
#import "WHBUrl.h"
#import "WHWebController.h"


#define App                             ((AppDelegate*)[[UIApplication sharedApplication] delegate])



@implementation WHSchemeHandler



+ (WHSchemeHandler *)currentHandler {
    static WHSchemeHandler *schemeHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        schemeHandler = [[self alloc] init];
    });
    return schemeHandler;
}


- (void)handleUrl:(NSString *)url animated:(BOOL)animated {
        WHBUrl *_url = [WHBUrl urlWithString:url];
       
        // open web
        [self handleOpenWeb:_url animated:animated];
       
}



#pragma mark - handle open web

- (void)handleOpenWeb:(WHBUrl *)url animated:(BOOL)animated {
    UIViewController *controller = [self generateWebController:url];
    if (controller) {
        UIViewController *currentController = [self getTopController];
        [currentController.navigationController pushViewController:controller animated:animated];
    }
}

#pragma mark - generate controller

- (UIViewController *)generateWebController:(WHBUrl *)url {
    WHWebController *controller = nil;
    NSString *_url = url.originUrl;
    controller = [[WHWebController alloc]init];
    controller.url = _url;
   
    
    return controller;
}






- (UIViewController *)getTopController {
    return [self _getTopController:[self getRootController]];
}

- (UIViewController *)getRootController {
    return App.window.rootViewController;
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
