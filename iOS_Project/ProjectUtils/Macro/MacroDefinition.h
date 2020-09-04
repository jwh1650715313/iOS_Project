//
//  MacroDefinition.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/25.
//  Copyright © 2017年 JIng. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)


// iPhone4,4s：320*480，iPhone5,5s：320*568，iPhone6：375*667，iPhone6plus：414*736
// 获取设备的物理高度
#define KScreenHeight       [[UIScreen mainScreen] bounds].size.height
// 获取设备的物理宽度
#define KScreenWidth        ([UIScreen mainScreen].bounds.size.width)

#define kScreen_Frame       (CGRectMake(0, 0 ,ScreenWidth,ScreenHeight))

#define kScreen_Bounds  [[UIScreen mainScreen] bounds]

//比例
#define SCALE_HEIGHT(height)     (height * (KScreenHeight / 667.0))
#define SCALE_WIDTH(width)       (width * (KScreenWidth / 375.0))


//手机版本

#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH       (MAX(KScreenWidth, KScreenHeight))
#define SCREEN_MIN_LENGTH       (MIN(KScreenWidth, KScreenHeight))

#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X             (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0 || [UIScreen mainScreen].bounds.size.height == 896.f)
#define TABBAR_OFFSET           (IS_IPHONE_X ? -34.0 : 0.0)



// 快捷创建
#define KEY_WINDOW       [[UIApplication sharedApplication] keyWindow]
// 常用高度
#define NAVIGATION_HEIGHT   64



#pragma mark - Color
// 从16进制得到颜色值 0x222222
#define kCyColorFromHexA(hex, a) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(a)]
#define kCyColorFromHex(hex) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(1.0f)]


//UI颜色控制
#define kUITabarSelectColor  COLOR_RGB(38, 44, 81) //Tabbar选中的颜色
#define KNavigationBarColor [UIColor whiteColor]   //导航栏背景颜色
#define kStatusBarStyle UIStatusBarStyleLightContent //导航栏状态栏样式
#define kViewBackgroundColor kCyColorFromHex(0xf3f3f3) //界面View背景颜色
#define kSplitLlineColor kCyColorFromHex(0xe5e5e5) //分割线的颜色
//按钮状态颜色
#define kNormalColor kCyColorFromHex(0x6a9eff) //正常状态颜色
#define kDisabledColor kCyColorFromHex(0xdcdcdc) //不可选中状态颜色

#define kSelectColor kCyColorFromHex(0x8fb6ff) //选中状态颜色



//文字颜色
#define kUIToneTextColor kCyColorFromHex(0x3d405f) //UI整体文字色调 与背景颜色对应
#define kMinorColor kCyColorFromHex(0x8d8d96) //次要文本,辅助状态的文本颜色
#define kHyperlinkColor kCyColorFromHex(0x6a9eff) //用于跳转链接文案



//颜色
#define COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define COLOR_RGB(R, G, B) [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:1]
#define COLOR_N(INT) [UIColor colorWithRed:(INT/255.0f) green:(INT/255.0f) blue:(INT/255.0f) alpha:1]
#define COLOR_F(Float) [UIColor colorWithRed:(Float) green:(Float) blue:(Float) alpha:1]


#define ClearColor [UIColor clearColor]              //透明色
#define WhiteColor [UIColor whiteColor]              //白色
#define BlackColor [UIColor blackColor]              //黑色
#define GrayColor [UIColor grayColor]                //灰色
#define LightGrayColor [UIColor lightGrayColor]      //浅灰色
#define DarkGrayColor [UIColor darkGrayColor]        //深灰色
#define RedColor [UIColor redColor]
#define GreenColor [UIColor greenColor]              //绿色
#define TextColor [UIColor colorWithRed:(32/255.0f) green:(32/255.0f) blue:(32/255.0f) alpha:1]   //字体颜色



//缺省头像图
#define kPlaceHoldHeadImage [UIImage imageNamed:@"iconAbout"]



// 常用字体
#define NavFont Font(18)
#define Font(size) [UIFont systemFontOfSize:size]
#define Font_Bold(size) [UIFont boldSystemFontOfSize:size]














//开发的时候打印，但是发布的时候不打印的NSLog

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)

#endif

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//强引用
#define StrongSelf(type)  __strong typeof(type) type = weak##type;


#define WEAKSELF typeof(self) __weak weakSelf = self;



//iOS系统版本
#define iOS(versionAbove)    [[[UIDevice currentDevice] systemVersion] floatValue] >= versionAbove
#define iOSBefore(version)   [[[UIDevice currentDevice] systemVersion] floatValue] < version




// 非空判断
#define kEnsureNotNil(str) [HHTool ensureNotNiL:str]


#define KstringByReplace(Str) [Str stringByReplacingOccurrencesOfString:@" " withString:@""]

#endif /* MacroDefinition_h */
