//
//  AppDelegate.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/3.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "AppDelegate.h"


#import "YCLoginViewController.h"
#import "YCUpdateVersion.h"
#import "WIFISetupHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [WIFISetupHelper checkHostCache];//检查网络
    
    
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
      
        YCLoginViewController  *loginVc=[YCLoginViewController new];
        
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
    
    YCUpdateVersion *UpdateVersion=[[YCUpdateVersion alloc]init];
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
