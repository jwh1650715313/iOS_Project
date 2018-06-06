//
//  YCLoginModelManager.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/6/6.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "YCLoginModelManager.h"

#define kYCLoginModel @"kYCLoginModel"


@implementation YCLoginModelManager

// 是否登录
+ (BOOL)isLogin
{
    YCLoginModel *uDefault = [YCLoginModelManager getInfo];
    return [CommonUtils IsOkString:uDefault.token]==YES?NO : YES;
}


// 保存信息
+ (void)saveInfo:(YCLoginModel *)info
{
    NSMutableDictionary *infoDic = [info mj_keyValues];
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault setObject:infoDic forKey:kYCLoginModel];
    [uDefault synchronize];
}

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:[uDefault objectForKey:kYCLoginModel]];
    [infoDic setObject:kEnsureNotNil(info) forKey:key];
    [uDefault setObject:infoDic forKey:kYCLoginModel];
    [uDefault synchronize];
}

// 获取信息
+ (YCLoginModel *)getInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:kYCLoginModel];
    YCLoginModel *km_userInfo = [YCLoginModel mj_objectWithKeyValues:infoDic];
    
    return km_userInfo==nil?[YCLoginModel new]:km_userInfo;
}

// 删除信息
+ (void)deleteInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault removeObjectForKey:kYCLoginModel];
    [uDefault synchronize];
}

@end
