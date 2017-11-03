//
//  HttpRequstManager.m
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "HttpRequstManager.h"

@interface HttpRequstManager ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end



@implementation HttpRequstManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

#pragma mark - 配置请求底层参数

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        //主Url 可以封装起来统一管理,也可以直接写在GET参数里单独管理
        NSURL *baseUrl = [NSURL URLWithString:HostName];
        //AFHTTPSessionManager 创建一个网络请求
        _sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
        // Requests 请求Header参数
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
        _sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"charset=UTF-8", nil];
        //设置请求头
//        [_sessionManager.requestSerializer setValue:@"fd0a97bd4bcb79b91c50b47c7fa8246d" forHTTPHeaderField:@"apikey"];
        
        //Responses 响应Header参数
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}


#pragma mark - 各种请求

//GET
- (void)getRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(void (^)(id   responseObject))success
                  failure:(void (^)(NSError *  error))failure {
    
    [self.sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//POST
- (void)postRequestWithUrl:(NSString *)url
                    params:(id)params
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *  error))failure {
    
    
    
    [self.sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//PUT
- (void)putRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(void (^)(id  _Nullable responseObject))success
                  failure:(void (^)(NSError * _Nonnull error))failure {
    
    [self.sessionManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//PATCH
- (void)patchRequestWithUrl:(NSString *)url
                     params:(id)params
                    success:(void (^)(id  responseObject))success
                    failure:(void (^)(NSError * error))failure {
    
    [self.sessionManager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//DELETE
- (void)deleteRequestWithUrl:(NSString *)url
                      params:(id)params
                     success:(void (^)(id   responseObject))success
                     failure:(void (^)(NSError *  error))failure {
    
    [self.sessionManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




@end
