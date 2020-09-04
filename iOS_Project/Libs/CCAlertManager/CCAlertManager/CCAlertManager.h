//
//  CCAlertManager.h
//  CCAlertManager
//
//  Created by 蔡成汉 on 2019/11/28.
//  Copyright © 2019 蔡成汉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCAlertManager : NSObject

+ (instancetype)sharedManager;
- (void)addAlert:(UIViewController *)alert controllers:(NSArray<Class> *)controllers;
- (void)addAlert:(UIViewController *)alert controllers:(NSArray<Class> *)controllers animated:(BOOL)animated;

@end


@interface UIViewController (CCAlert)

@property (nonatomic, copy) void(^cc_deallocCallBack)(void);

- (void)cc_didAlert;

@end



NS_ASSUME_NONNULL_END
