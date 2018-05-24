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

#define kNotifyRefreshCheckHeight       @"kNotifyRefreshCheckHeight"//刷新审核步骤的cell

#define kNotification_RepaymentVcRefresh       @"kNotification_RepaymentVcRefresh"//刷新审核步骤的cell


//通知宏定义
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"
//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"


#define KNotificationUpdateInfo @"KNotificationUpdateInfo"//刷新用户信息



//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

//获取系统对象
#define kAppWindow          [UIApplication sharedApplication].delegate.window




typedef void(^IndexBlock)(NSInteger index);

//各种ID

#define BUGLY_APP_ID  @"7465ab379c"//腾讯的bugly，AppId

//阿里云推送
#define AliYunAppKey     @"24831088"
#define AppSecret  @"fb345fd095f0adc06023b0fc038a3db4"


//常用cell

#define kBaseTextTableViewCell @"BaseTextTableViewCell"


#endif /* ConfigDefinition_h */
