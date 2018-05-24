//
//  HHLoginModelManager.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/27.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHLoginModelManager.h"

#define kHHLoginModel @"kHHLoginModel"


@implementation HHLoginModelManager




// 是否登录
+ (BOOL)isLogin
{
    HHLoginModel *uDefault = [HHLoginModelManager getInfo];
    return [CommonUtils IsOkString:uDefault.token]==YES?NO : YES;
}


// 保存信息
+ (void)saveInfo:(HHLoginModel *)info
{
    NSMutableDictionary *infoDic = [info mj_keyValues];
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault setObject:infoDic forKey:kHHLoginModel];
    [uDefault synchronize];
}

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:[uDefault objectForKey:kHHLoginModel]];
    [infoDic setObject:kEnsureNotNil(info) forKey:key];
    [uDefault setObject:infoDic forKey:kHHLoginModel];
    [uDefault synchronize];
}

// 获取信息
+ (HHLoginModel *)getInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:kHHLoginModel];
    HHLoginModel *km_userInfo = [HHLoginModel mj_objectWithKeyValues:infoDic];
  
    return km_userInfo==nil?[HHLoginModel new]:km_userInfo;
}

// 删除信息
+ (void)deleteInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    [uDefault removeObjectForKey:kHHLoginModel];
    [uDefault synchronize];
}



@end
