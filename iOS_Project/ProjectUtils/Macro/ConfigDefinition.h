//
//  ConfigDefinition.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/25.
//  Copyright © 2017年 JIng. All rights reserved.
//

#ifndef ConfigDefinition_h
#define ConfigDefinition_h


//定义各种key

#define kNotifyHUDProgressHide       @"kNotifyHUDProgressHide"//隐藏loading的通知


//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

//获取系统对象
#define kAppWindow          [UIApplication sharedApplication].delegate.window




typedef void(^IndexBlock)(NSInteger index);


//各种ID

#define BUGLY_APP_ID  @"b6ba27111c"//腾讯的bugly，AppId





#endif /* ConfigDefinition_h */
