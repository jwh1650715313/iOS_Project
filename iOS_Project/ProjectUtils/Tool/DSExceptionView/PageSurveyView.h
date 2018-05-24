//
//  PageSurveyView.h
//
//
//  Created by wujianming on 16/10/9.
//  Copyright © 2016年 szteyou. All rights reserved.
//  页面信息反馈

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ExceptionViewType) {
    
    ExceptionViewType_NetWorkError  = 0, // 网络错误
    ExceptionViewType_ServerError   = 1, // 服务异常
    ExceptionViewType_NoData        = 2, // 没数据
    ExceptionViewType_Error         = 3//
    
};

typedef void(^PageSurveyViewBlock)(void);

@interface PageSurveyView : UIView


+ (void)showViewWithType:(ExceptionViewType)type toView:(UIView *)view;
+ (void)showViewWithType:(ExceptionViewType)type toView:(UIView *)view yOffset:(CGFloat)y;

+ (void)showViewWithText:(NSString *)text toView:(UIView *)view;
+ (void)showViewWithText:(NSString *)text toView:(UIView *)view yOffset:(CGFloat)y;
/** 有按钮的*/
+ (void)showButtonViewWithType:(ExceptionViewType)type
                        toView:(UIView *)view
                       yOffset:(CGFloat)y
                   ButtonBlock:(PageSurveyViewBlock)block;

//定义的
+ (void)showButtonWithText:(NSString *)text
                 BtnText:(NSString *)BtnText
            withIconName:(NSString *)iconN
                  toView:(UIView *)view
                 yOffset:(CGFloat)y
             ButtonBlock:(PageSurveyViewBlock)block;


+ (void)showMsg:(NSString *)msg withIconName:(NSString *)iconN toView:(UIView *)view;
+ (void)showMsg:(NSString *)msg withIconName:(NSString *)iconN toView:(UIView *)view yOffset:(CGFloat)y;
+ (void)hideFromView:(UIView *)view;

@end
