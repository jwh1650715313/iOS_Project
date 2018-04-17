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
-(void)getRequestWithUrl:(NSString *)url params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSLog(@"请求路径: %@ \n\t请求参数: %@", url, params?:@"nil");
    
    [self.sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        
        if (0 == code) {
            success(responseObject,code);
        } else {
            failure(nil, responseObject[@"msg"]);
        }
        
        NSLog(@"请求路径:%@\n\t返回结果: %@", task.response.URL, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        failure(error, dic[@"NSLocalizedDescription"]);
        
        NSLog(@"请求路径: %@\n\t返回错误结果: %@", dic[@"NSErrorFailingURLKey"], dic[@"NSLocalizedDescription"]);
    }];
}




//POST
- (void)postRequestWithUrl:(NSString *)url
                    params:(id)params
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure {
    
    NSLog(@"请求路径: %@ \n\t请求参数: %@", url, params?:@"nil");
    
    
    if ([CommonUtils checkNet]) {
        
        [self.sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            
            if (0 == code) {
                success(responseObject,code);
            } else {
                failure(nil, responseObject[@"msg"]);
            }
            
            NSLog(@"请求路径:%@\n\t返回结果: %@", task.response.URL, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSDictionary *dic = [error userInfo];
            failure(error, dic[@"NSLocalizedDescription"]);
            
            NSLog(@"请求路径: %@\n\t返回错误结果: %@", dic[@"NSErrorFailingURLKey"], dic[@"NSLocalizedDescription"]);
        }];
    }
    else{
        
        NSError *error;
        failure(error , @"服务器连接失败");
    }
    
    
}

//PUT
- (void)putRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure  {
    
    NSLog(@"请求路径: %@ \n\t请求参数: %@", url, params?:@"nil");
    
    if ([CommonUtils checkNet]) {
        
        [self.sessionManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            
            if (0 == code) {
                success(responseObject,code);
            } else {
                failure(nil, responseObject[@"msg"]);
            }
            
            NSLog(@"请求路径:%@\n\t返回结果: %@", task.response.URL, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSDictionary *dic = [error userInfo];
            failure(error, dic[@"NSLocalizedDescription"]);
            
            NSLog(@"请求路径: %@\n\t返回错误结果: %@", dic[@"NSErrorFailingURLKey"], dic[@"NSLocalizedDescription"]);
        }];
    }
    else{
          NSError *error;
          failure(error , @"服务器连接失败");
    }
   
    
    
}

//PATCH
- (void)patchRequestWithUrl:(NSString *)url
                     params:(id)params
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure {
    
    NSLog(@"请求路径: %@ \n\t请求参数: %@", url, params?:@"nil");
    
    
    [self.sessionManager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        
        if (0 == code) {
            success(responseObject,code);
        } else {
            failure(nil, responseObject[@"msg"]);
        }
        
        NSLog(@"请求路径:%@\n\t返回结果: %@", task.response.URL, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        failure(error, dic[@"NSLocalizedDescription"]);
        
        NSLog(@"请求路径: %@\n\t返回错误结果: %@", dic[@"NSErrorFailingURLKey"], dic[@"NSLocalizedDescription"]);
    }];
}

//DELETE
- (void)deleteRequestWithUrl:(NSString *)url
                      params:(id)params
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure  {
    
    [self.sessionManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        
        if (0 == code) {
            success(responseObject,code);
        } else {
            failure(nil, responseObject[@"msg"]);
        }
        
        NSLog(@"请求路径:%@\n\t返回结果: %@", task.response.URL, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = [error userInfo];
        failure(error, dic[@"NSLocalizedDescription"]);
        
        NSLog(@"请求路径: %@\n\t返回错误结果: %@", dic[@"NSErrorFailingURLKey"], dic[@"NSLocalizedDescription"]);
    }];
}



- (void)logoutForTokenExpired
{
    [HHPopupView  alertWithTitle:@"登录信息过期" detail:@"请重新登录？" contentArr:@[@"登录"] selectComplete:^(NSInteger index) {
        
        
        if (index==0) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            
            //写退出登录的逻辑
            
            
            
            KPostNotification(KNotificationLoginStateChange, @NO);
        }
        
        
        
    }];
}


@end
