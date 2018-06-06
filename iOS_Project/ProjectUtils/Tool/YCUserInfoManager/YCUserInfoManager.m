//
//  HHUserInfoManager.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/26.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "YCUserInfoManager.h"

#define kUserInfoKey @"KMUSERKEY"

@implementation YCUserInfoManager



// 保存信息
+ (void)saveInfo:(YCUserInfo *)info
{
    NSMutableDictionary *infoDic = [info mj_keyValues];
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault setObject:infoDic forKey:kUserInfoKey];
    [uDefault synchronize];
}

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:[uDefault objectForKey:kUserInfoKey]];
    [infoDic setObject:kEnsureNotNil(info) forKey:key];
    [uDefault setObject:infoDic forKey:kUserInfoKey];
    [uDefault synchronize];
}

// 获取信息
+ (YCUserInfo *)getInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:kUserInfoKey];
    YCUserInfo *km_userInfo = [YCUserInfo mj_objectWithKeyValues:infoDic];
    NSLog(@"用户信息：%@",km_userInfo.mj_keyValues);
    return km_userInfo==nil?[YCUserInfo new]:km_userInfo;
}

// 删除信息
+ (void)deleteInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault removeObjectForKey:kUserInfoKey];
    [uDefault synchronize];
}

//更新信息
+ (void)updateInfo
{

   
}

+ (void)updateInfoSuccess:(updateInfoSuccess )success
{
    
}




@end
