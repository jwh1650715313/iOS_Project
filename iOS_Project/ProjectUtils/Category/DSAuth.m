//
//  DSAuth.m
//  DSports
//
//  Created by apple_administrator on 2016/12/14.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import "DSAuth.h"
#import "BlocksKit.h"


@import Contacts;
@import ContactsUI;
@import AddressBook;
@import AVFoundation;
@import AssetsLibrary;

@implementation DSAuth


+ (BOOL)checkPhotoLibraryAuthorizationStatus
{
    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        
        if (ALAuthorizationStatusDenied == authStatus ||
            ALAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:@"该设备不支持拍照"];
        [alertView show];
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)checkUserNotificationSettingAuthorizationStatus
{
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
        [UIAlertView bk_showAlertViewWithTitle:@"您尚未开启新消息通知" message:@"请到系统\"设置\"-\"通知\"-\"特奢汇\"中打开" cancelButtonTitle:nil otherButtonTitles:@[@"取消", @"去设置"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }];
        return NO;
    }
    return YES;
}

//+ (BOOL)checkLocationManagerAuthorizationStatus
//{
//    if (!([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)) {
//        [UIAlertView bk_showAlertViewWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" cancelButtonTitle:nil otherButtonTitles:@[@"暂不", @"去设置"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            if (buttonIndex == 1) {
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                    [[UIApplication sharedApplication] openURL:url];
//                }
//            }
//        }];
//        return NO;
//    }
//    return YES;
//}

+ (BOOL)checkAddressBookAuthorizationStatus
{
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0f) {
        ABAuthorizationStatus authStatus =
        ABAddressBookGetAuthorizationStatus();
        
        if (kABAuthorizationStatusRestricted == authStatus || kABAuthorizationStatusDenied == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->通讯录”中打开本应用的访问权限"];
            return NO;
        }
    }
    else {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError *_Nullable error) {
                if (granted) {
                    // 授权成功
                    [DSAuth checkAddressBookAuthorizationStatus];
                }
                else {
                    // 授权失败
                }
            }];
            return NO;
        }
        
        if (status == CNAuthorizationStatusRestricted || status == CNAuthorizationStatusDenied) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->通讯录”中打开本应用的访问权限"];
            return NO;
        }
    }
    
    return YES;
}

+ (void)showSettingAlertStr:(NSString *)tipStr
{
    //iOS8+系统下可跳转到‘设置’页面，否则只弹出提示窗即可
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:tipStr];
        [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
        [alertView bk_addButtonWithTitle:@"设置" handler:nil];
        [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
            if (index == 1) {
                UIApplication *app = [UIApplication sharedApplication];
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if ([app canOpenURL:settingsURL]) {
                    [app openURL:settingsURL];
                }
            }
        }];
        [alertView show];
    }
    else {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:tipStr];
        [alertView show];
    }
}
@end
