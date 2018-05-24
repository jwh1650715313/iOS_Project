//
//  BaseViewController.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,assign) BOOL isRequest;//是否正在请求 默认NO

@property (nonatomic, strong) HttpRequstManager *requestManager;
@property (nonatomic, strong) MBProgressHUD *progressHUD;//菊花loading
@property (nonatomic, strong) HHNoNetWorkView *noNetWorkView;//菊花loading
@property (nonatomic,assign) BOOL bShowTip;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;


#pragma mark 公用方法

- (void)requestData;//网络请求
- (void)backAction:(UIButton *)sender;//返回
- (void)gotoLoginViewController;//去登陆界面
- (void)initUI;//数据初始化
- (void)NoNetWorkViewClick;//无网络点击
#pragma mark 界面切换

//不需要传参数的push 只需告诉类名字符串
- (void)pushViewControllerWithName:(id)classOrName;
//回到当前模块导航下的某一个页面
- (void)returnViewControllerWithName:(id)classOrName;
//切到指定模块下
- (void)popToHomePageWithTabIndex:(NSInteger)index completion:(void (^)(void))completion;


#pragma mark 左边按钮定制

/**
 *  显示默认返回按钮
 *
 *  @param title 需要传入上级界面标题
 */
- (void)showBackWithTitle:(NSString *)title;

/**
 *  自定义左边按钮
 *
 *  @param icon     图标 非必填
 *  @param title    标题 非必填
 *  @param selector 事件
 */
- (void)setLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;
- (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;

#pragma mark 右边按钮定制

/**
 *  通过文字设置右侧导航按钮
 *
 *  @param title    文字
 *  @param selector 事件
 */
- (void)setRightItemWithTitle:(NSString *)title selector:(SEL)selector;
- (UIBarButtonItem *)ittemRightItemWithTitle:(NSString *)title selector:(SEL)selector;

/**
 *  通过ico定制右侧按钮
 *
 *  @param icon     图标
 *  @param selector 事件
 */
- (void)setRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;
- (UIBarButtonItem *)ittemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;

#pragma mark titleView定制

//设置纯文字titleVIew
- (void)setNavigationItemTitleViewWithTitle:(NSString *)title;

#pragma mark - 小红点

/**
 *  小红点View定制
 *
 *  @param redDotValue <#redDotValue description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)ittemRedViewWithRedDotValue:(NSString *)redDotValue;

#pragma mark --网络异常提醒页面相关
/** 显示
 */
-(void)showNoNetWorkView;
/** 隐藏
 */
- (void)hideNoNetWorkView;


#pragma mark-显示loading
/** 显示loading
 */
- (void)showProgress;
- (void)showProgress:(NSString *)text;
- (void)showProgress:(NSString *)text exit:(BOOL)exit;  // 是否自动退出

#pragma mark-影藏loading
/** 影藏loading
 */
- (void)hideProgress;


#pragma mark-显示Toast

/** 中间显示提示
 */
- (void)showCenterTip:(NSString *)tip;

/** 底部显示提示
 */
- (void)showBottomTip:(NSString *)tip;



- (void)releaseRootVC;


@end
