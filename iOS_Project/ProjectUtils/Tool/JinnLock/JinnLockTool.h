//
//  AppDelegate.m
//  houhe_ios
//
//  Created by hulianxinMac on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LAContext.h>

@interface JinnLockTool : NSObject

#pragma mark - 手势密码管理

/**
 是否允许手势解锁(应用级别的)

 @return BOOL
 */
+ (BOOL)isGestureUnlockEnabled;

/**
 设置是否允许手势解锁功能

 @param enabled enabled
 */
+ (void)setGestureUnlockEnabled:(BOOL)enabled;

/**
 当前已经设置的手势密码

 @return NSString
 */
+ (NSString *)currentGesturePasscode;

/**
 设置新的手势密码

 @param passcode passcode
 */
+ (void)setGesturePasscode:(NSString *)passcode;

#pragma mark - 指纹解锁管理

/**
 是否支持指纹识别(系统级别的)

 @return BOOL
 */
+ (BOOL)isTouchIdSupported;

/**
 是否允许指纹解锁(应用级别的)

 @return BOOL
 */
+ (BOOL)isTouchIdUnlockEnabled;

/**
 设置是否允许指纹解锁功能

 @param enabled enabled
 */
+ (void)setTouchIdUnlockEnabled:(BOOL)enabled;

@end
