//
//  CommonUtils.m
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "CommonUtils.h"

// getMacAddress start
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
// getMacAddress end

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AdSupport/ASIdentifierManager.h>


#import <CommonCrypto/CommonCryptor.h>
#import "Reachability.h"
@implementation CommonUtils


// 检查网络状态
+ (BOOL)checkNet{
    
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:HostName];
    switch([reachability currentReachabilityStatus]){
        case NotReachable: isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN: isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi: isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
    
  
}


/**
 * 获取设备MAC地址
 */
+ (NSString *)getMacAddress{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        //        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        //        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        //        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        //        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"x:x:x:x:x:x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%x:%x:%x:%x:%x:%x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}


+ (NSString *)getUrl:(NSDictionary *)dic key:(NSString *)key{
    NSString *value = @"";
    if (dic != nil && [dic isKindOfClass:[NSDictionary class]] && [[dic allKeys] containsObject:key]) {
        value = [NSString stringWithFormat:@"%@", [dic objectForKey:key]];
        if (![value hasPrefix:@"http"]) {
            //            value = [NSString stringWithFormat:@"%@%@", kUrlBaseForPic, value];
        }
    }
    return value;
}

+ (NSString *)getDicStr:(NSDictionary *)dic key:(NSString *)key{
    NSString *result = @"";
    if (dic != nil && [dic isKindOfClass:[NSDictionary class]] && [[dic allKeys] containsObject:key]) {
        result = [NSString stringWithFormat:@"%@", [dic objectForKey:key]];
        if ([result isEqualToString:@"<null>"]) {
            result = @"";
        }
    }
    return result;
}

+ (NSDictionary *)getDicFromString:(NSString *)str{
    // NSString to NSData
    NSData *testData = [str dataUsingEncoding: NSUTF8StringEncoding];
    
    //NSData-->NSDictionary
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}


+ (float)getSystemOSVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (float)getTextHeight:(NSString *)text width:(float)width font:(UIFont *)font{
    //    NSString *str = [text copy];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    float height = [text sizeWithFont:font constrainedToSize:size].height;
    return height;
}

+ (float)getTextWidth:(NSString *)text width:(float)width font:(UIFont *)font{
    //    NSString *str = [text copy];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    float w = [text sizeWithFont:font constrainedToSize:size].width;
    return w;
}

// 毫秒 格式化为 string
+ (NSString *)stringFromMillSec:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"MM-dd  HH:mm"];
}

+ (NSString *)stringYYYYMMddHHmmFromMillSec:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"YYYY-MM-dd HH:mm"];
}


+ (NSString *)stringYYYYMMddFromMillSec:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"YYYY-MM-dd"];
}


+ (NSString *)stringFromMillSec1:(NSString *)timeStr{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStr doubleValue]/1000)];
    return [self stringFromFomate:date formate:@"HH:mm"];
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *) dateMMddFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *) dateYYMMddHHmmFromFomate:(NSString *)datestring formate:(NSString*)formate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}


+ (BOOL)checkPhone:(NSString *)phoneStr{
    if (phoneStr == nil || ![phoneStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    NSString *phone = [phoneStr copy];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([phone hasPrefix:@"1"] && phone.length == 11) {
        return YES;
    }
    return NO;
}


+ (BOOL)checkChineseName:(NSString *)nameStr{
    if (nameStr == nil || ![nameStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    NSString *name = [nameStr copy];
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (name.length < 2) {
        return NO;
    }
    for(int i=0; i< [name length];i++){
        int a = [name characterAtIndex:i];
        if( a < 0x4e00 || a > 0x9fff) {
            return NO;
        }
    }
    return YES;
}

+ (NSInteger)getStringLengthWithChinese:(NSString *)str{
    NSInteger count = 0;
    for(int i = 0; i < [str length]; i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            count += 2;
        } else {
            count++;
        }
    }
    return count;
}

+ (NSString*)getPhoneDeviceId {
    /*
     NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
     NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
     identifierForVendor对供应商来说是唯一的一个值，也就是说，由同一个公司发行的的app在相同的设备上运行的时候都会有这个相同的标识符。然而，如果用户删除了这个供应商的app然后再重新安装的话，这个标识符就会不一致。
     advertisingIdentifier会返回给在这个设备上所有软件供应商相同的 一个值，所以只能在广告的时候使用。这个值会因为很多情况而有所变化，比如说用户初始化设备的时候便会改变。
     */
    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    
    return identifierForAdvertising;
}

//判断字符串是否正常
+(BOOL)IsOkString:(NSString *)str
{
    str=[NSString stringWithFormat:@"%@",str];
    
    if (str!=nil && ![str isEqual:[NSNull null]] && ![str isKindOfClass:[NSNull class]] && str.length>0  && [str isKindOfClass:[NSString class]] && ![str isEqualToString:@"<null>"] && ![str isEqualToString:@"null"] && ![str isEqualToString:@"(null)"] && ![str isEqualToString:@"<NULL>"]) {
        
        return YES;
    }
    
    return NO;
}

//判断字典是否正常
+(BOOL)IsOkNSDictionary:(NSDictionary *)dic
{
    if (dic!=nil && ![dic isEqual:[NSNull null]] && ![dic isKindOfClass:[NSNull class]]  && [dic isKindOfClass:[NSDictionary class]] && dic.count>0) {
        
        return YES;
    }
    
    return NO;
}


//判断数组是否正常
+(BOOL)IsOkNSArray:(NSArray *)array
{
    if (array!=nil && ![array isEqual:[NSNull null]] && ![array isKindOfClass:[NSNull class]]  && [array isKindOfClass:[NSArray class]] && array.count>0) {
        
        return YES;
    }
    
    return NO;
}



//判断用户是否开启推送
+ (BOOL)isAllowedNotification {
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    
    if(sysVersion >= 8.0f) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if
            (UIUserNotificationTypeNone != setting.types) {
                
                return
                YES;
            }
    }else{//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if(UIRemoteNotificationTypeNone != type)
            
            return
            YES;
    }
    return NO;
}


//验证手机号码

+(NSString *)numberSuitScanf:(NSString*)number{
    
    //首先验证是不是手机号码
    
    NSString *tel = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return tel;
    
}


//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}



//获取时间戳
+(NSString*)getCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

//验证车牌号
+ (BOOL)isValidCarNo:(NSString *)carNo {
    
//    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSString *carRegex =  @"^(([\u4e00-\u9fa5]{1}[A-Z]{1})[-]?|([wW][Jj][\u4e00-\u9fa5]{1}[-]?)|([a-zA-Z]{2}))([A-Za-z0-9]{5}|[DdFf][A-HJ-NP-Za-hj-np-z0-9][0-9]{4}|[0-9]{5}[DdFf])$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
    
}


// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    //长度不为18的都排除掉
    if (idCard.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:idCard];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[idCard substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [idCard substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }

}

//千位符
+ (NSString *)positiveFormat:(NSString *)text
{
    if (!text || [text floatValue] == 0) {
        return @"0.00";
    }
    if (text.floatValue<1000) {
        return [NSString stringWithFormat:@"%.2f",text.floatValue];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@",###.00;"];
    
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];

}



@end
