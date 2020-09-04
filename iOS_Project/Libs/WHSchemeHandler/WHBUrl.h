//
//  WHBUrl.h
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/4.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHBUrl : NSObject

@property (nonatomic, copy, readonly) NSString *scheme;
@property (nonatomic, copy, readonly) NSString *host;
@property (nonatomic, copy, readonly) NSNumber *port;
@property (nonatomic, copy, readonly) NSString *user;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *fragment;
@property (nonatomic, copy, readonly) NSString *parameterString;
@property (nonatomic, copy, readonly) NSString *originUrl;

// url 格式化
+ (WHBUrl *)urlWithUrl:(NSURL *)url;
+ (WHBUrl *)urlWithString:(NSString *)string;

// set url query for key
- (void)setQuery:(NSString *)value forKey:(NSString *)key;
- (void)setQuery:(NSString *)value forKey:(NSString *)key sensitive:(BOOL)sensitive;
- (void)setQueryString:(NSString *)queryString;
- (void)setQueryDic:(NSDictionary *)queryDic;

// get url query
- (NSString *)getQueryString;
- (NSDictionary *)getQueryDic;
- (NSString *)getQueryForKey:(NSString *)key;
- (NSString *)getQueryForKey:(NSString *)key sensitive:(BOOL)sensitive;

// remove url query
- (void)removeQueryForKey:(NSString *)key;
- (void)removeQueryForKey:(NSString *)key sensitive:(BOOL)sensitive;



@end

NS_ASSUME_NONNULL_END
