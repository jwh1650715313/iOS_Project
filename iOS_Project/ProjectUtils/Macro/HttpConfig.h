//
//  HttpConfig.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#ifndef HttpConfig_h
#define HttpConfig_h



/***
 
 各种测试环境
 
 ***/


#define HOST_KEY                    @"DebugHost"



//#define HostName  @"https://zshb.chefeidai.cn/"//正式环境



#define HostName   [[NSUserDefaults standardUserDefaults] objectForKey:HOST_KEY]

#define CACHE_HOST(urlStr) [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:HOST_KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];


#define HOST_MENUS       @[@{@"正式环境" : @"https://zshb.chefeidai.cn/"},\
                            @{@"开发环境1" : @"http://192.168.1.255:8580/"},\
                            @{@"开发环境2" : @"http://192.168.1.98:8580/"},\
                            @{@"测试环境2" : @"http://192.168.1.13:8580/"}]



// 七牛云地址。


//#define QiNiuYunHostName @"https://prospaceoms.chefeidai.cn/"//正式环境

#define QiNiuYunHOST_KEY           @"QiNiuYunDebugHost"

#define QiNiuYunHOST_MENUS       @[@{@"正式环境" : @"https://prospaceoms.chefeidai.cn/"},\
                                    @{@"开发环境" : @"https://oymn9ubab.bkt.clouddn.com/"}]

#define QiNiuYunHostName   [[NSUserDefaults standardUserDefaults] objectForKey:QiNiuYunHOST_KEY]

#define QiNiuYunCACHE_HOST(urlStr) [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:QiNiuYunHOST_KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];


//各种接口


#define login  @"/customer/login/login" //登录

#define logout  @"/customer/login/logout"//退出登录

#define register  @"/customer/login/register"//app用户注册

#define getRegisterCode   @"/customer/verificationCode/getVerificationCode"//获取注册验证码


//个人中心
#define queryAppVersion @"/customer/personal/queryAppVersion"//获取版本信息

#define getCustomerByPhone @"/customer/personal/getCustomerByPhone"//获取App用户信息

#define buildUploadToken @"/customer/qiniuoss/buildUploadToken"//获取七牛云图片上传token


#define queryPublishAppArticle @"/customer/personal/queryPublishAppArticle"//帮助中心



#define resetPassword @"/customer/personal/resetPassword"//重置登录密码










//网络请求异常
#define HttpRequst_Error  @"请求异常，请重试!"
#define Requst_Error  [Toast showWithText:@"请求异常，请重试!" duration:2];

#define NetWord_Disconnect_View [Toast showWithText:@"网络不给力!" duration:2];
#define NetWord_Error_View [Toast showWithText:@"网络繁忙，请重试!" duration:2];


/**
 请求头的参数
 
 @param ... token，platform，appVersion
 
 */
#define kappVersion       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define KToken  [HHLoginModelManager getInfo].token

#define Kplatform  @"iOS"





#endif /* HttpConfig_h */
