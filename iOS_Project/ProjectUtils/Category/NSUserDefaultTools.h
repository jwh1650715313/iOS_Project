//
//  NSUserDefaultTools.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/26.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultTools : NSObject


+ (void)setBooleanValueWithKey:(BOOL)value key:(NSString *)key;
+ (BOOL)getBooleanValueWithKey:(NSString *)key;

+ (void)setStringValueWithKey:(NSString *)value key:(NSString *)key;
+ (NSString *)getStringValueWithKey:(NSString *)key;

+ (void)setDataWithKey:(NSData *)data key:(NSString *)key;
+ (NSData *)getDataWithKey:(NSString *)key;


@end
