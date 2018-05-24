//
//  HHUserInfoManager.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/26.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHUserInfoManager.h"
#import "HHLoginModelManager.h"
#define kUserInfoKey @"KMUSERKEY"

@implementation HHUserInfoManager



// 保存信息
+ (void)saveInfo:(HHUserInfo *)info
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
+ (HHUserInfo *)getInfo
{
    NSUserDefaults *uDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *infoDic = [uDefault objectForKey:kUserInfoKey];
    HHUserInfo *km_userInfo = [HHUserInfo mj_objectWithKeyValues:infoDic];
    NSLog(@"用户信息：%@",km_userInfo.mj_keyValues);
    return km_userInfo==nil?[HHUserInfo new]:km_userInfo;
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

    NSDictionary  *dic=@{@"phone":kEnsureNotNil([HHLoginModelManager getInfo].userInfo.phone)
                         };
    
    [[HttpRequstManager sharedInstance] getRequestWithUrl:getCustomerByPhone params:dic success:^(id response, NSInteger resposeCode) {
        
        
        NSDictionary *dic = [response objectForKey:@"data"];
        HHUserInfo *uInfo = [HHUserInfo mj_objectWithKeyValues:dic];
        [self saveInfo:uInfo];
        
        
        
    } failure:^(NSError *error, NSString *errorMsg) {
        
        NSLog(@"===%@",errorMsg);
        
        
    }];
}

+ (void)updateInfoSuccess:(updateInfoSuccess )success
{
    NSDictionary  *dic=@{@"phone":kEnsureNotNil([HHLoginModelManager getInfo].userInfo.phone)
                         };
    
    [[HttpRequstManager sharedInstance] getRequestWithUrl:getCustomerByPhone params:dic success:^(id response, NSInteger resposeCode) {
        
        
        NSDictionary *dic = [response objectForKey:@"data"];
        HHUserInfo *uInfo = [HHUserInfo mj_objectWithKeyValues:dic];
        [self saveInfo:uInfo];
        
        
        success(YES);
        
        
        
    } failure:^(NSError *error, NSString *errorMsg) {
        
        NSLog(@"===%@",errorMsg);
        
          success(NO);
    }];
}




@end
