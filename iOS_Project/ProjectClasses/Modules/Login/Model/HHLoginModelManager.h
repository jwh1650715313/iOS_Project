//
//  HHLoginModelManager.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/27.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHLoginModel.h"
@interface HHLoginModelManager : NSObject

// 是否登录
+ (BOOL)isLogin;



// 保存信息
+ (void)saveInfo:(HHLoginModel *)info;

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key;

// 获取信息
+ (HHLoginModel *)getInfo;

// 删除信息
+ (void)deleteInfo;


@end
