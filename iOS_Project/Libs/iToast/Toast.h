//
//  Toast.h
//  YourLife
//
//  Created by ARIST on 14/11/25.
//  Copyright (c) 2014年 Arist.Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_DISPLAY_DURATION 1.5f

@interface Toast : NSObject{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}

+ (void)showWithText:(NSString *)text_;
+ (void)showWithText:(NSString *)text_ duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *)text_ topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *)text_ topOffset:(CGFloat) topOffset duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *)text_ bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *)text_ bottomOffset:(CGFloat) bottomOffset_ duration:(CGFloat) duration_;

@end
