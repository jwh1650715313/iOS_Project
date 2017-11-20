//
//  Date.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/26.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject


+ (NSString*)getCurrentTime_HMS;//获得系统时间 HH:mm:ss
+ (NSString *)getCurrentData_YMD;//获得系统时间 YYYY年MM月dd日
+ (NSString *)getCurrentData_YMD1;//获得系统时间 YYYY-MM-dd
+ (NSMutableArray *)getMonthDataArray:(int)day;
+ (NSMutableArray *)getWeekhDataArray;
+ (NSArray *)getWeekDayArray;//获取周一到周末每天的时间
+ (NSMutableArray *)getWeekhDataArray_yy;
+ (NSMutableArray *)getWeekhDataArray_mm;
+ (NSString*)getChangeTime:(long)time ;
+ (NSString*)getChangeTime1:(int)time ;

+ (NSString *)getDataMonth;
+ (NSString *)getDataToday;
+ (NSString *)getData7;
+ (NSString *)getData30;
+ (NSString *)getData90;

+ (BOOL)isStr:(NSString*)str;

//四舍5入
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;


@end
