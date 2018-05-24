
//
//  JinnLockConfig.h
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/13.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#ifndef JinnLockConfig_h
#define JinnLockConfig_h


// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL kCyColorFromHex(0x3d405f)



// 选中的颜色
#define JINN_LOCK_COLOR_SELECT kCyColorFromHex(0x6a9eff)


// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR  kCyColorFromHex(0xdd5949)

// 重设按钮颜色
#define JINN_LOCK_COLOR_BUTTON [[UIColor lightGrayColor] colorWithAlphaComponent:0.5]

/**
 *  指示器大小
 */
static const CGFloat kIndicatorSideLength = 50.f;

/**
 *  九宫格大小
 */
static const CGFloat kSudokoSideLength = 320;

/**
 *  圆圈边框粗细(指示器和九宫格的一样粗细)
 */
static const CGFloat kCircleWidth = 0.5f;

/**
 *  指示器轨迹粗细
 */
static const CGFloat kIndicatorTrackWidth = 0.5f;

/**
 *  九宫格轨迹粗细
 */
static const CGFloat kSudokoTrackWidth = 2.f;

/**
 *  圆圈选中效果中心点和圆圈比例
 */
static const CGFloat kCircleCenterRatio = 0.4f;

/**
 *  最少连接个数
 */
static const NSInteger kConnectionMinNum = 4;

/**
 *  指示器标签基数(不建议更改)
 */
static const NSInteger kIndicatorLevelBase = 1000;

/**
 *  九宫格标签基数(不建议更改)
 */
static const NSInteger kSudokoLevelBase = 2000;

/**
 *  手势解锁开关键(不建议更改)
 */
static NSString * const kJinnLockGestureUnlockEnabled = @"JinnLockGestureUnlockEnabled";

/**
 *  指纹解锁开关键(不建议更改)
 */
static NSString * const kJinnLockTouchIdUnlockEnabled = @"JinnLockTouchIdUnlockEnabled";

/**
 *  手势密码键(不建议更改)
 */
static NSString * const kJinnLockPasscode = @"JinnLockPasscode";

/**
 *  提示文本
 */
static NSString * const kJinnLockTouchIdText  = @"指纹验证";
static NSString * const kJinnLockResetText    = @"重新手势设置";
static NSString * const kJinnLockNewText      = @"请设置新手势密码";
static NSString * const kJinnLockVerifyText   = @"请输入手势密码";
static NSString * const kJinnLockAgainText    = @"请再次确认新手势密码";
static NSString * const kJinnLockNotMatchText = @"两次密码不匹配";
static NSString * const kJinnLockReNewText    = @"请重新设置新手势密码";
static NSString * const kJinnLockReVerifyText = @"请重新输入手势密码";
static NSString * const kJinnLockOldText      = @"请输入旧手势密码";
static NSString * const kJinnLockOldErrorText = @"手势密码不正确";
static NSString * const kJinnLockReOldText    = @"请重新输入旧手势密码";

#define JINN_LOCK_NOT_ENOUGH [NSString stringWithFormat:@"最少连接%ld个点，请重新输入", (long)kConnectionMinNum]



#endif /* JinnLockConfig_h */
