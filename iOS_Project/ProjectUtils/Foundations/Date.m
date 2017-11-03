//
//  Date.m
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/26.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "Date.h"

@implementation Date


+ (NSString*)getCurrentTime_HMS {
    //获得系统时间
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return  locationString;
}

+ (NSString *)getCurrentData_YMD {
    //获得系统时间
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return  locationString;
}

+ (NSString *)getCurrentData_YMD1 {
    //获得系统时间
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return  locationString;
}



+ (NSMutableArray *)getMonthDataArray:(int)day {
    int dis = day *2; //一个多少的天数
    
    NSMutableArray * monthDataArray = [NSMutableArray array];
    
    for (int i = dis ; i >= 0 ; i --) {
        NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:- i * (24*60*60)];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString * locationString=[dateformatter stringFromDate:senddate];
        [monthDataArray addObject:locationString];
    }
    
    //NSLog(@"monthDataArray = %@",monthDataArray);
    return monthDataArray;
}

+ (NSMutableArray *)getWeekhDataArray {
    int dis = 49; //一个多少的天数
    
    NSMutableArray * monthDataArray = [NSMutableArray array];
    
    for (int i = dis -1 ; i >= 0 ; i --) {
        NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:- (i+1) * (24*60*60)];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"MM/dd"];
        NSString * locationString=[dateformatter stringFromDate:senddate];
        [monthDataArray addObject:locationString];
    }
    
    NSMutableArray * weekDataArray = [NSMutableArray array];
    for (int i = 0; i < 7 ; i ++) {
        NSString * data;
        for (int j = 0; j < 7; j ++) {
            if (j == 0) {
                data = monthDataArray[i * 7 + j];
            }
            if (j == 6) {
                data = [data stringByAppendingString:[NSString stringWithFormat:@"-%@",monthDataArray[i * 7 + j]]];
            }
            if (j == 6) {
                [weekDataArray addObject:data];
            }
        }
    }
    return weekDataArray;
}



+ (NSArray *)getWeekDayArray
{
    
    NSMutableArray * DataArray = [NSMutableArray array];
    
    
    int currentWeek = 0;
    NSDate * newDate = [NSDate date];
    NSTimeInterval secondsPerDay1 = 24 * 60 * 60 * (abs(currentWeek)*7);
    if (currentWeek > 0)
    {
        newDate = [newDate dateByAddingTimeInterval:+secondsPerDay1];//目标时间
    }else{
        newDate = [newDate dateByAddingTimeInterval:-secondsPerDay1];//目标时间
    }
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 1];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    //    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    for (int i = 0; i < 7; i ++) {
        NSString *dateString = [myDateFormatter stringFromDate:[beginDate dateByAddingTimeInterval:i * secondsPerDay]];
        
        [DataArray addObject:dateString];
    }
    
    NSArray  *reversedArray = [[DataArray reverseObjectEnumerator] allObjects];
    
    return reversedArray;
}

+ (NSMutableArray *)getWeekhDataArray_yy {
    return [self array:2];
}

+ (NSString *)getDataToday {
    // NSDate * senddate=[NSDate date];
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return  locationString;
}


+ (NSString *)getDataMonth {
    // NSDate * senddate=[NSDate date];
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return  locationString;
}


+ (NSString *)getData7 {
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-7 * (24*60*60)];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSString *)getData30 {
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-30 * (24*60*60)];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
+ (NSString *)getData90 {
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:-90 * (24*60*60)];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSMutableArray *)getWeekhDataArray_mm {
    return [self array:1];
}


+ (NSMutableArray *)array:(int)tag {
    int dis = 49; //一个多少的天数
    
    NSMutableArray * monthDataArray = [NSMutableArray array];
    
    for (int i = 0 ; i < dis  ; i ++) {
        NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow:- (i+1) * (24*60*60)];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        if (tag == 1) {
            [dateformatter setDateFormat:@"MM-dd"];
        }else {
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
        }
        NSString * locationString=[dateformatter stringFromDate:senddate];
        [monthDataArray addObject:locationString];
    }
    
    NSMutableArray * weekDataArray = [NSMutableArray array];
    for (int i = 0; i < 7 ; i ++) {
        NSMutableArray * dateDataArray = [NSMutableArray array];
        for (int j = 0; j < 7; j ++) {
            [dateDataArray addObject:monthDataArray[i * 7 + j]];
            if (dateDataArray.count == 7) {
                [weekDataArray addObject:dateDataArray];
            }
        }
    }
    return weekDataArray;
}


+ (NSString*)getChangeTime:(long)time {
    NSDate *senddate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

+ (NSString*)getChangeTime1:(int)time {
    NSString* time1;
    int HH=(time/(60*60));
    int mm=(time%(60*60))/60;
    int ss=time%60;
    
    if(HH > 0){
        if (HH < 10) {
            time1 = [NSString stringWithFormat:@"0%d:",HH];
        }else {
            time1 = [NSString stringWithFormat:@"%d:",HH];
        }
    }else {
        time1 = @"00:";
    }
    if(mm > 0){
        if (mm < 10) {
            time1 = [time1 stringByAppendingString:[NSString stringWithFormat:@"0%d:",mm]];
        }else {
            time1 = [time1 stringByAppendingString:[NSString stringWithFormat:@"%d:",mm]];
        }
    }else {
        time1 = [time1 stringByAppendingString:@"00:"];
    }
    if(ss > 0){
        if (ss < 10) {
            time1 = [time1 stringByAppendingString:[NSString stringWithFormat:@"0%d",ss]];
        }else {
            time1 = [time1 stringByAppendingString:[NSString stringWithFormat:@"%d",ss]];
        }
    }else {
        time1 = [time1 stringByAppendingString:@"00"];
    }
    return time1;
}

+ (BOOL)isStr:(NSString*)str; {
    if ([str isEqualToString:@"null"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"nil"] || str.length < 1) {
        return NO;
    }else {
        return YES;
    }
}

+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}





@end
