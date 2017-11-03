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
#define HostName  @"http://test.xinlebao.com"




//各种接口














//网络请求异常
#define HttpRequst_Error  @"请求异常，请重试!"
#define Requst_Error  [Toast showWithText:@"请求异常，请重试!" duration:2];

#define NetWord_Disconnect_View [Toast showWithText:@"网络不给力!" duration:2];
#define NetWord_Error_View [Toast showWithText:@"网络繁忙，请重试!" duration:2];



#endif /* HttpConfig_h */
