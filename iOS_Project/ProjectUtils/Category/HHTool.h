//
//  HHTool.h
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTool : NSObject

///非空判断，content有效返回原值，否则返回@""
+ (NSString *)ensureNotNiL:(NSString *)content;

@end
