//
//  Dadihe.h
//  云图互联
//
//  Created by JIng on 2016/11/4.
//  Copyright © 2016年 com.yuntumind. All rights reserved.
//

#ifndef Dadihe_h
#define Dadihe_h


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NSObject+Json.h"
#import "NSString+Json.h"
#import "UIView+Additions.h"
#import "UIView+LayoutHelper.h"
#import "NSUserDefaultTools.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "YYModel.h"
#import "MD5.h"
#import "CommonUtils.h"
#import "NSMutableDictionary+JSON.h"
#import "LoginViewController.h"
#import "MJExtension.h"
#import "UIHelper.h"


//接口地址

#import "CLRequest.h"
#import "CLInterfaceConfig.h"


//各种数据模型
#import "LoginInfo.h"




/**
 *  开发模式/生产模式打日志控制
 *
 *  @param fmt
 *  @param ...
 *
 *  @return
 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif






#pragma mark - Device
// iPhone4,4s：320*480，iPhone5,5s：320*568，iPhone6：375*667，iPhone6plus：414*736
// 获取设备的物理高度
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 获取设备的物理宽度
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)

#define kScreen_Frame       (CGRectMake(0, 0 ,ScreenWidth,ScreenHeight))

// 主页面 Tab 高度
#define kTabBarHeight 49

#pragma mark - Color
// 从16进制得到颜色值 0x222222
#define kCyColorFromHexA(hex, a) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(a)]
#define kCyColorFromHex(hex) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(1.0f)]


#define kColorStyle kCyColorFromHex(0x3290e8)       // 主题颜色
#define kColorHintBackground kCyColorFromHex(0xff7c7c)       // 提示颜色
#define kColorBackground kCyColorFromHex(0xf7f7f7)       // 默认背景颜色

//颜色
#define COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:1]
#define COLOR_N(INT) [UIColor colorWithRed:(INT/255.0f) green:(INT/255.0f) blue:(INT/255.0f) alpha:1]
#define COLOR_F(Float) [UIColor colorWithRed:(Float) green:(Float) blue:(Float) alpha:1]

#define ClearColor [UIColor clearColor]              //透明色
#define WhiteColor [UIColor whiteColor]              //白色
#define BlackColor [UIColor blackColor]              //黑色
#define GrayColor [UIColor grayColor]                //灰色
#define LightGrayColor [UIColor lightGrayColor]      //浅灰色
#define DarkGrayColor [UIColor darkGrayColor]        //深灰色
#define RedColor [UIColor redColor]
#define GreenColor [UIColor greenColor]              //绿色
#define TextColor [UIColor colorWithRed:(32/255.0f) green:(32/255.0f) blue:(32/255.0f) alpha:1]   //字体颜色


//当前版本
#define CURRENT_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//正式1.1.3
#define REGISTERTYPE          @"3"
#define SPACE (WIDTH * 0.02)

/***
 
 各种测试环境
 
 ***/

//#define HostName  @"http://192.168.1.36:8080" //wangxiang
//#define HostName  @"http://app.yuntumind.com" //正式
//#define HostName  @"http://wys951.6655.la:8090" //大地和测试test
#define HostName  @"http://zhuchuanghui.wicp.net" //云图施恩测试
//#define HostName  @"http://wys951.6655.la:8090" //云图test

//#define HostName    [CommonUtils getLoginInfo].accTypeId==2?@"http://app1.yuntumind.com":[CommonUtils getLoginInfo].accTypeId==1?@"http://app.yuntumind.com":@"http://app.yuntumind.com"
//正式环境


//登录的Url
//#define loginHostName  @"http://app.yuntumind.com"//正式环境
#define loginHostName  @"http://zhuchuanghui.wicp.net" //云图施恩测试

#define WEAKSELF typeof(self) __weak weakSelf = self;


//极光推送
#define JPUSHAPPKEY    @"6e894ae87ba802b60bb3ff1f"
#define  Channel       @"7a106f3f43f77f4a5d21e6f8"

//百度地图Key
#define BAIDUAPPKEY    @"xmFvm7WceYH7ezG1deP1uPixXleflNYS"

#define RSAKEY         @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCS9uGRLZfMrCgU3x+ezQwMUYuZFMPShDkpc03Jv807fmqxzjAMUy3qm/X7qbBMBXZF22wRNiXECe1Q5+iq6tXjr7xdNgjHww9htusUSdhHISvIKHdGMZoMZghq0nTYCo+ZWjsnPz2tVNEC9LbIjiV5SCv5bhehH+cm9Kt4s2F+SwIDAQAB"
#define KEY_RSAKEY              @"rsaKey"//请求公钥





//各种缓存的key
#define KEY_RegistrationID     @"RegistrationID"

#define KEY_saveLoginInfo     @"KEY_saveLoginInfo"
#define KEY_saveSearchLog     @"KEY_saveSearchLog"

#define KEY_PASSWORD            @"passWord"//密码
#define KEY_USERNAME            @"username"//账号




//各种通知
#define kNotifyHUDProgressHide @"kNotifyHUDProgressHide"
#define kNotifyRefreshMotorPage @"kNotifyRefreshMotorPage"
#define kNotifyRefreshserialCodeInfo @"kNotifyRefreshserialCodeInfo"//更新电机详情
#define kNotifyRefreshserialCodeInfoTwo @"kNotifyRefreshserialCodeInfoTwo"//更新电机详情


#define kNotifyShowSerialCodeList @"kNotifyShowSerialCodeList"//获取电机列表
#define kNotifyRefreshEquipmentDataView @"kNotifyRefreshEquipmentDataView"//刷新电机详情-故障表等等
#define kNotifySearchResult @"kNotifySearchResult"//点击搜索的结果
#define kNotifyDeleteLog @"kNotifyDeleteLog"//清除搜索记录
#define kNotifyJumpMotorPage @"kNotifyJumpMotorPage"//跳转电机页面

#define kNotifyJumpMotorPageGetSerialCodeList @"kNotifyJumpMotorPageGetSerialCodeList"//跳转电机页面并获取电机列表





//存储消息
#define KEY_NEWS                       [NSString stringWithFormat:@"NEWS_%@",[CommonUtils getLoginInfo].uid]

#define KEY_STATE                      [NSString stringWithFormat:@"STATE_%@",[CommonUtils getLoginInfo].uid]

#define key_token                      [NSString stringWithFormat:@"%@",[CommonUtils getLoginInfo].token]


#endif /* Dadihe_h */
