//
//  YCLoginModelManager.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/6/6.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCLoginModel.h"
@interface YCLoginModelManager : NSObject


// 是否登录
+ (BOOL)isLogin;



// 保存信息
+ (void)saveInfo:(YCLoginModel *)info;

// 保存信息
+ (void)saveInfo:(NSString *)info forKey:(NSString *)key;

// 获取信息
+ (YCLoginModel *)getInfo;

// 删除信息
+ (void)deleteInfo;


@end
