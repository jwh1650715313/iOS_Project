//
//  CommonUtils.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface CommonUtils : NSObject

// 检查网络状态
+ (BOOL)checkNet;

/**
 * 获取设备MAC地址
 */

+ (NSString *)getMacAddress;
/**
 * 获取Http的请求地址
 */
+ (NSString *)getUrl:(NSDictionary *)dic key:(NSString *)key;

/**
 * 获取NSDictionary的的Value
 */
+ (NSString *)getDicStr:(NSDictionary *)dic key:(NSString *)key;

/**
 * Nsstring转NSDictionary
 */
+ (NSDictionary *)getDicFromString:(NSString *)str;

/**
 * 获取版本号
 */
+ (float)getSystemOSVersion;

/**
 * 获取一段字段的高
 */
+ (float)getTextHeight:(NSString *)text width:(float)width font:(UIFont *)font;
/**
 * 获取一段字段的宽
 */
+ (float)getTextWidth:(NSString *)text width:(float)width font:(UIFont *)font;


/**
 * 毫秒 格式化为 string
 */
+ (NSString *)stringFromMillSec:(NSString *)timeStr;

+ (NSString *)stringYYYYMMddHHmmFromMillSec:(NSString *)timeStr;

+ (NSString *)stringYYYYMMddFromMillSec:(NSString *)timeStr;

+ (NSString *)stringFromMillSec1:(NSString *)timeStr;

+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;

+ (NSString *) dateMMddFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *) dateYYMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate;


+ (NSString *)networkingStatesFromStatebar;

// 判断是否是手机号码
+ (BOOL)checkPhone:(NSString *)phone;

// 判断是否是中文
+ (BOOL)checkChineseName:(NSString *)nameStr;


// 获取中文长度
+ (NSInteger)getStringLengthWithChinese:(NSString *)str;

+ (NSString*)getPhoneDeviceId;//手机的唯一标示

//判断字符串是否正常
+(BOOL)IsOkString:(NSString *)str;


//判断字典是否正常
+(BOOL)IsOkNSDictionary:(NSDictionary *)dic;

//判断数组是否正常
+(BOOL)IsOkNSArray:(NSArray *)array;


//判断用户是否开启推送
+ (BOOL)isAllowedNotification;

//验证手机号码
+(NSString *)numberSuitScanf:(NSString*)number;


//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;


//获取时间戳
+(NSString*)getCurrentTimestamp;

//判断车牌号是否正常
+(BOOL)isValidCarNo:(NSString *)carNo;


// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard;

//千位符
+ (NSString *)positiveFormat:(NSString *)text;


@end
