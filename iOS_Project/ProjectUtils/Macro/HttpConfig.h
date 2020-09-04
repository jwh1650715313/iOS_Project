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



//Host
#define HOST_MENUS       @[@{@"正式环境" : @"http://oa.prod.tobgo.com"}]


//

//#define HOST_MENUS       @[@{@"正式环境" : @"http://oa.prod.tobgo.com"},\
//@{@"演示环境" : @"http://oa.prep.tobgo.com"},\
//@{@"测试环境" : @"http://oa.test.tobgo.com"}]


#define HandleHosts                         @[@"tobgo.com",@"tobgo.com",@"tobgo.com"]



#define HostName   [[NSUserDefaults standardUserDefaults] objectForKey:HOST_KEY]

#define CACHE_HOST(urlStr) [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:HOST_KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];














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

#define KToken  @"KToken"

#define Kplatform  @"iOS"





#endif /* HttpConfig_h */
