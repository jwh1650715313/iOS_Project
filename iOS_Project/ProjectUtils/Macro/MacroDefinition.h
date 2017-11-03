//
//  MacroDefinition.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/25.
//  Copyright © 2017年 JIng. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h




// iPhone4,4s：320*480，iPhone5,5s：320*568，iPhone6：375*667，iPhone6plus：414*736
// 获取设备的物理高度
#define KScreenHeight       [[UIScreen mainScreen] bounds].size.height
// 获取设备的物理宽度
#define KScreenWidth        ([UIScreen mainScreen].bounds.size.width)

#define kScreen_Frame       (CGRectMake(0, 0 ,ScreenWidth,ScreenHeight))

//获取View的Height
#define KViewHeight       self.view.height



// 主页面 Tab 高度
#define kTabBarHeight 49

#pragma mark - Color
// 从16进制得到颜色值 0x222222
#define kCyColorFromHexA(hex, a) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(a)]
#define kCyColorFromHex(hex) [UIColor colorWithRed:(((hex & 0xff0000) >> 16) / 255.0f) green:(((hex & 0x00ff00) >> 8) / 255.0f) blue:((hex & 0x0000ff) / 255.0f) alpha:(1.0f)]


//UI颜色控制
#define kUIToneBackgroundColor kCyColorFromHex(0x00bd8c) //UI整体背景色调 与文字颜色一一对应
#define kUIToneTextColor kCyColorFromHex(0xffffff) //UI整体文字色调 与背景颜色对应
#define kStatusBarStyle UIStatusBarStyleLightContent //状态栏样式
#define kViewBackgroundColor kCyColorFromHex(0xf5f5f5) //界面View背景颜色

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









//当前版本
#define CURRENT_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//开发的时候打印，但是发布的时候不打印的NSLog

#ifdef DEBUG
#define LRLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LRLog(...)

#endif

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//强引用
#define StrongSelf(type)  __strong typeof(type) type = weak##type;






#endif /* MacroDefinition_h */
