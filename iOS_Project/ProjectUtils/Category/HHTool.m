//
//  HHTool.m
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "HHTool.h"

@implementation HHTool
///非空判断，content有效返回原值，否则返回@""
+ (NSString *)ensureNotNiL:(NSString *)content {
  
    if ([CommonUtils IsOkString:content]) {
        
        return content;
    }
    
    
    return @"";
}

@end
