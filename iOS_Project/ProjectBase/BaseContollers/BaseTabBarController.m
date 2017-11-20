//
//  BaseTabBarController.m
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self removeTabarTopLine];
    [self setViewControllers];
    
    self.view.backgroundColor=WhiteColor;
    
    
}


- (void)viewWillLayoutSubviews{
    float height = self.tabBar.frame.size.height;
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = height;
    tabFrame.origin.y = self.view.frame.size.height - height;
    self.tabBar.frame = tabFrame;
    self.tabBar.backgroundColor=WhiteColor;

}


- (void)setViewControllers {
    //UITabBarController 数据源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarConfigure" ofType:@"plist"];
    NSArray *dataAry = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary *dataDic in dataAry) {
        //每个tabar的数据
        Class classs = NSClassFromString(dataDic[@"class"]);
        NSString *title =dataDic[@"title"];
        NSString *imageName = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        NSString *badgeValue = dataDic[@"badgeValue"];
        
        [self addChildViewController:[self ittemChildViewController:classs title:title imageName:imageName selectedImage:selectedImage badgeValue:badgeValue]];
    }
   
}

- (BaseNavigationController *)ittemChildViewController:(Class)classs title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage badgeValue:(NSString *)badgeValue {
    
    UIViewController *vc = [classs new];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[[UIImage imageNamed:selectedImage] imageToColor:kUIToneBackgroundColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //起点-8图标才会到顶，然后加上计算出来的y坐标
//    float origin = -9 + 6;
//    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
//    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(-2 + 8, 2-8);
    //title设置
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kUIToneBackgroundColor,NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    vc.tabBarItem.title = title;
    
    //小红点
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
    //导航
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.topItem.title = title;
    [nav.rootVcAry addObject:classs];
    return nav;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
   
    
}

#pragma 设置小红点数值
//设置指定tabar 小红点的值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index {
    if (index + 1 > self.viewControllers.count || index < 0) {
        //越界或者数据异常直接返回
        return;
    }
    BaseNavigationController *base = self.viewControllers[index];
    if (base.viewControllers.count == 0) {
        return;
    }
    UIViewController *vc = base.viewControllers[0];
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
}

#pragma 设置小红点显示或者隐藏

//显示小红点 没有数值
- (void)showBadgeWithIndex:(int)index {
    [self.tabBar showBadgeOnItemIndex:index];
}

//隐藏小红点 没有数值
- (void)hideBadgeWithIndex:(int)index {
    [self.tabBar hideBadgeOnItemIndex:index];
}

#pragma mark - 去掉tabBar顶部线条

//去掉tabBar顶部线条
- (void)removeTabarTopLine {
    CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
