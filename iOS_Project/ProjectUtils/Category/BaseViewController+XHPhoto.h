//
//  BaseViewController+XHPhoto.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/4/10.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^photoBlock)(UIImage *photo);


@interface BaseViewController (XHPhoto)

/**
 *  使用系统ActionSheet来选择打开相机、相册
 *
 *  @param edit  照片是否需要裁剪,默认NO
 *  @param block 照片回调
 */
-(void)showCanEdit:(BOOL)edit photo:(photoBlock)block;

/**
 直接打开图库
 
 @param edit 照片是否需要裁剪,默认NO
 @param block 照片回调
 */
-(void)showPhotoLibraryCanEdit:(BOOL)edit photo:(photoBlock)block;

/**
 直接打开相机
 
 @param edit 照片是否需要裁剪,默认NO
 @param block 照片回调
 */
-(void)showCameraCanEdit:(BOOL)edit photo:(photoBlock)block;



@end
