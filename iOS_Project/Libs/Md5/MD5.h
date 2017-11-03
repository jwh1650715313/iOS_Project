//
//  MD5.h
//  娱乐帮
//
//  Created by LogicalThinking on 15/9/14.
//  Copyright (c) 2015年 LogicalThinking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>


@interface MD5 : NSObject
+ (NSString *)md5:(NSString *)str;


+ (NSString *)md5UpStr:(NSString *)str;


+ (NSString *)getRandomString;
@end
