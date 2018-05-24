//
//  DSAuth.h
//  DSports
//
//  Created by apple_administrator on 2016/12/14.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAuth : NSObject
/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

/**
 *  检查系统"通知"授权状态,如果权限被关闭，提示用户去隐私设置中打开.
 */
+ (BOOL)checkUserNotificationSettingAuthorizationStatus;

/*
 *  检查系统"定位"授权状态,如果权限被关闭,提示用户取隐私设置中打开
 */
+ (BOOL)checkLocationManagerAuthorizationStatus;

/*
 *  检查系统"通讯录"授权状态,如果权限被关闭,提示用户取隐私设置中打开
 */
+ (BOOL)c;
@end
