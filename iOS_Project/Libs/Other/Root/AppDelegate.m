//
//  AppDelegate.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/3.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "AppDelegate.h"

#import "JinnLockViewController.h"
#import "HHLoginViewController.h"
#import "HHUpdateVersion.h"
#import "WIFISetupHelper.h"


#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [WIFISetupHelper checkHostCache];//检查网络
    
    
    
    [self initCloudPush];
    
    
    
    [self registerAPNS:application];
    
    [self registerMessageReceive];
    
    [CloudPushSDK sendNotificationAck:launchOptions];
    
    [self initUMShare];

    [self initView];
    
    [self UpdateVersion];
    
    [self initNotification];

    [self initBugly];
   
    
    [self adaptiveIos11];
    
    
  
    
    

    return YES;
}


-(void)initNotification
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil]; 
}
    
    
#pragma mark-初始化友盟分享
- (void)initUMShare {
    static NSString * const umengAppKey = @"58802bc7b27b0a304f00117a";
    /*
     
     wxd8148ba3d00492fb
     d52c1e04bb9f772eab2a3f496b58af58
     */
    static NSString * const appWXApiKey = @"wxd8148ba3d00492fb";
    static NSString * const appWXSecret = @"d52c1e04bb9f772eab2a3f496b58af58";
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:umengAppKey];
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appWXApiKey appSecret:appWXSecret redirectURL:nil];
}

    
    


#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
        //为避免自动登录成功刷新tabbar
        if (!self.baseTabBar || ![self.window.rootViewController isKindOfClass:[BaseTabBarController class]]) {
            self.baseTabBar = [BaseTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.baseTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
            
        }
        
    }else {//登陆失败加载登陆页面控制器
        
        self.baseTabBar = nil;
      
        HHLoginViewController  *loginVc=[HHLoginViewController new];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"fade";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = loginVc;
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        
    }
    
}


//适配iOS11
-(void)adaptiveIos11
{
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}


#pragma mark-进入APP
-(void)enterApp
{
    BaseTabBarController *tabBarView= [[BaseTabBarController alloc]init];
    self.window.rootViewController = tabBarView;

}



#pragma mark-初始化视图

-(void)initView
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BaseTabBarController *tabBarView= [[BaseTabBarController alloc]init];
    
//    HHLoginViewController *LoginVc= [HHLoginViewController new];
 
  
    self.window.rootViewController = tabBarView;
    
    [self.window makeKeyAndVisible];
    
    
    
   
    
}


-(void)UpdateVersion
{
    
    [[UIButton appearance] setExclusiveTouch:YES];
    
    HHUpdateVersion *UpdateVersion=[[HHUpdateVersion alloc]init];
    [UpdateVersion updateVersion];
    
}




#pragma mark-初始化Bugly
static NSString * extracted() {
    return BUGLY_APP_ID;
}

#pragma mark-Bugly
-(void)initBugly
{
    [Bugly startWithAppId:extracted()];
}

#pragma mark-需要手势解锁
- (void)verify
{
    if ([JinnLockTool isGestureUnlockEnabled])
    {
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:nil
                                                                                                 type:JinnLockTypeVerify
                                                                                           appearMode:JinnLockAppearModePresent];
        
        [self.window setRootViewController:lockViewController];
        
    }
    
}


#pragma mark-阿里云推送


- (void)initCloudPush {
    // SDK初始化

    [CloudPushSDK asyncInit:AliYunAppKey appSecret:AppSecret callback:^(CloudPushCallbackResult *res) {


        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}


/**
 *    注册苹果推送，获取deviceToken用于推送
 *
 *    @param     application
 */
- (void)registerAPNS:(UIApplication *)application {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
    }
    else {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}
/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success.");
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}


/**
 *    注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 *
 *    @param     notification
 */
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
}



/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得Extras字段内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


@end
