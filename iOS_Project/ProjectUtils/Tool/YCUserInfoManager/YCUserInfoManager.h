//
//  HHUserInfoManager.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/26.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCUserInfo.h"


typedef void(^updateInfoSuccess)(BOOL success);


@interface YCUserInfoManager : NSObject



// 保存信息
+ (void)saveInfo:(YCUserInfo *)info;

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key;

// 获取信息
+ (YCUserInfo *)getInfo;

// 删除信息
+ (void)deleteInfo;

//更新信息
+ (void)updateInfo;


//更新信息
+ (void)updateInfoSuccess:(updateInfoSuccess )success;


@end
