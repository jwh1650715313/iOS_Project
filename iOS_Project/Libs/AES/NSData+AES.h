//
//  NSData+AES.h
//  Smile
//
//  Created by 蒲晓涛 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@class NSString;

@interface NSData (Encryption)



- (NSData *)AES128ParmEncryptWithKey:(NSString *)key;   //加密

- (NSData *)AES128ParmDecryptWithKey:(NSString *)key;   //解密

@end
