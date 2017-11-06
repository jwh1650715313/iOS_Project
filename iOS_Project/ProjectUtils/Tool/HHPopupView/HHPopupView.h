//
//  HHPopupView.h
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/28.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDateView.h"

@interface HHPopupView : NSObject

/**
 *  提示框
 *
 *  @param title      标题
 *  @param detail     详情
 *  @param contentArr 按钮标题数组
 *  @param complete   选择完成回调
 */
+ (void)alertWithTitle:(NSString *)title detail:(NSString *)detail contentArr:(NSArray <NSString *>*)contentArr selectComplete:(IndexBlock)complete;
/**
 *  提示框
 *
 *  @param title      标题
 *  @param contentArr 按钮标题数组
 *  @param complete   选择完成回调
 */
+ (void)sheetWithTitle:(NSString *)title  contentArr:(NSArray <NSString *>*)contentArr selectComplete:(IndexBlock)complete;

+ (void)dateViewWithModel:(UIDatePickerMode)model minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate  selectFinish:(void (^)(NSDate *date))selectFinish;


@end
