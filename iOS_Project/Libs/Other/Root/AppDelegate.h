//
//  AppDelegate.h
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/3.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarController *baseTabBar;

//进入APP..
-(void)enterApp;


@end

