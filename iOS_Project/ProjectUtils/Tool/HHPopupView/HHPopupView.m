//
//  HHPopupView.m
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/28.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "HHPopupView.h"
#import <MMAlertView.h>
#import <MMSheetView.h>
#import <MMPopupItem.h>
#import "MMDateView.h"

@implementation HHPopupView

/**
 *  提示框
 *
 *  @param title      标题
 *  @param detail     详情
 *  @param contentArr 按钮标题数组
 *  @param complete   选择完成回调
 */
+ (void)alertWithTitle:(NSString *)title detail:(NSString *)detail contentArr:(NSArray <NSString *>*)contentArr selectComplete:(IndexBlock)complete {
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *subStr in contentArr) {
        [items addObject:MMItemMake(subStr, MMItemTypeNormal, complete)];
    }
    [[[MMAlertView alloc] initWithTitle:title
                                 detail:detail
                                  items:items]
     showWithBlock:nil];
}

/**
 *  提示框
 *
 *  @param title      标题
 *  @param contentArr 按钮标题数组
 *  @param complete   选择完成回调
 */
+ (void)sheetWithTitle:(NSString *)title  contentArr:(NSArray <NSString *>*)contentArr selectComplete:(IndexBlock)complete {
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *subStr in contentArr) {
        [items addObject:MMItemMake(subStr, MMItemTypeNormal, complete)];
    }
    [[[MMSheetView alloc]  initWithTitle:title items:items] showWithBlock:nil];
     ;
}

+ (void)dateViewWithModel:(UIDatePickerMode)model minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectFinish:(void (^)(NSDate *date))selectFinish {
    MMDateView *dateView = [[MMDateView alloc] initWithModel:model minDate:minDate maxDate:maxDate selectFinish:selectFinish];
    [dateView showWithBlock:nil];
}


@end
