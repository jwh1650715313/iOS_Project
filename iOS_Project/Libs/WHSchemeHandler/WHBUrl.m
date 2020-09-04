//
//  WHBUrl.m
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/4.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import "WHBUrl.h"
@interface WHBUrl ()
{
    NSMutableDictionary *_queryDic;
}
@property (nonatomic, copy, readwrite) NSString *scheme;
@property (nonatomic, copy, readwrite) NSString *host;
@property (nonatomic, copy, readwrite) NSNumber *port;
@property (nonatomic, copy, readwrite) NSString *user;
@property (nonatomic, copy, readwrite) NSString *password;
@property (nonatomic, copy, readwrite) NSString *path;
@property (nonatomic, copy, readwrite) NSString *fragment;
@property (nonatomic, copy, readwrite) NSString *parameterString;
@property (nonatomic, copy, readwrite) NSString *originUrl;

@end


@implementation WHBUrl

// url 格式化
+ (WHBUrl *)urlWithUrl:(NSURL *)url {
    WHBUrl *_url = [[WHBUrl alloc]init];
    _url.scheme = url.scheme;
    _url.host = url.host;
    _url.port = url.port;
    _url.user = url.user;
    _url.password = url.password;
    _url.path = url.path;
    _url.fragment = url.fragment;
    _url.parameterString = url.parameterString;
    [_url setQueryString:url.query];
    _url.originUrl = [url absoluteString];
    return _url;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _queryDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - pub fun

+ (WHBUrl *)urlWithString:(NSString *)string {
    return [WHBUrl urlWithUrl:[NSURL URLWithString:string]];
}

// set url query for key
- (void)setQuery:(NSString *)value forKey:(NSString *)key {
    [self setQuery:value forKey:key sensitive:NO];
}

- (void)setQuery:(NSString *)value forKey:(NSString *)key sensitive:(BOOL)sensitive {
    if (key && key.length > 0) {
        value = value ? value : @"";
        [_queryDic setValue:[value description] forKey:key];
    }
}

- (void)setQueryString:(NSString *)queryString {
    NSArray *queryArray = [queryString componentsSeparatedByString:@"&"];
    for (NSString *item in queryArray) {
        NSArray* keyValue = [item componentsSeparatedByString:@"="];
        NSUInteger num = [keyValue count];
        NSString* key = num > 0 ? [keyValue objectAtIndex:0] : @"";
        NSString* value = num > 1 ? [keyValue objectAtIndex:1] : @"";
        [self setQuery:value forKey:key];
    }
}

- (void)setQueryDic:(NSDictionary *)queryDic {
    NSEnumerator* keyEnum = [queryDic keyEnumerator];
    NSString * key = nil;
    while ((key = [keyEnum nextObject])) {
        NSString * value = [queryDic objectForKey:key];
        value = (nil == value) ? @"" : value;
        [self setQuery:value forKey:key];
    }
}

// get url query
- (NSString *)getQueryString {
    if (_queryDic.count < 1) {
        return nil;
    }
    NSMutableString *queryStr = [[NSMutableString alloc] init];
    NSArray* allKeys = [_queryDic allKeys];
    for (int i = 0; i < allKeys.count; i++) {
        if (i > 0) {
            [queryStr appendString:@"&"];
        }
        NSString* key = [allKeys objectAtIndex:i];
        NSString* value = [_queryDic objectForKey:key];
        NSString* queryItem = [NSString stringWithFormat:@"%@=%@",key,value];
        [queryStr appendString:queryItem];
    }
    return [NSString stringWithString:queryStr];
}

- (NSDictionary *)getQueryDic {
    NSMutableDictionary *tpDic = [NSMutableDictionary dictionary];
    NSEnumerator* keyEnum = [_queryDic keyEnumerator];
    NSString * key = nil;
    while ((key = [keyEnum nextObject])) {
        NSString * value = [_queryDic valueForKey:key];
        value = (nil == value) ? @"" : value;
        [tpDic setValue:[value decodeURLString] forKey:key];
    }
    return tpDic;
}

- (NSString *)getQueryForKey:(NSString *)key {
    return [self getQueryForKey:key sensitive:NO];
}

- (NSString *)getQueryForKey:(NSString *)key sensitive:(BOOL)sensitive {
    NSString *result = nil;
    NSArray *allKeys = [_queryDic allKeys];
    NSStringCompareOptions option = sensitive ? NSLiteralSearch : NSCaseInsensitiveSearch;
    for (NSString *_key in allKeys) {
        if ([key compare:_key options:option] == NSOrderedSame) {
            result = [_queryDic objectForKey:_key];
            break;
        }
    }
    return [result decodeURLString];
}

// remove url query
- (void)removeQueryForKey:(NSString *)key {
    [self removeQueryForKey:key sensitive:NO];
}

- (void)removeQueryForKey:(NSString *)key sensitive:(BOOL)sensitive {
    NSArray* allKeys = [_queryDic allKeys];
    NSStringCompareOptions option = sensitive ? NSLiteralSearch : NSCaseInsensitiveSearch;
    for (int i = 0; i < allKeys.count; i++) {
        NSString* keyItem = [allKeys objectAtIndex:i];
        if ([key compare:keyItem options:option] == NSOrderedSame) {
            [_queryDic removeObjectForKey:@"keyItem"];
            break;
        }
    }
}



@end
