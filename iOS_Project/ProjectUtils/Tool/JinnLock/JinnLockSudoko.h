/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockSudoko.h
 **  Description: 解锁九宫格
 **
 **  Author:  jinnchang
 **  Date:    2016/9/22
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import <UIKit/UIKit.h>

@class JinnLockSudoko;

@protocol JinnLockSudokoDelegate <NSObject>

- (void)sudoko:(JinnLockSudoko *)sudoko passcodeDidCreate:(NSString *)passcode;

@end

@interface JinnLockSudoko : UIView

@property (nonatomic, weak) id<JinnLockSudokoDelegate> delegate;

- (instancetype)init;
- (void)showErrorPasscode:(NSString *)errorPasscode;
- (void)reset;

@end
