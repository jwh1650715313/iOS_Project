//
//  HttpRequstManager.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequstManager : NSObject

//get
- (void)getRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(void (^)(id   responseObject))success
                  failure:(void (^)(NSError *  error))failure;

//POST
- (void)postRequestWithUrl:(NSString *)url
                    params:(id)params
                   success:(void (^)(id   responseObject))success
                   failure:(void (^)(NSError *  error))failure;

//PUT
- (void)putRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(void (^)(id   responseObject))success
                  failure:(void (^)(NSError *  error))failure;

//PATCH
- (void)patchRequestWithUrl:(NSString *)url
                     params:(id)params
                    success:(void (^)(id   responseObject))success
                    failure:(void (^)(NSError *  error))failure;

//DELETE
- (void)deleteRequestWithUrl:(NSString *)url
                      params:(id)params
                     success:(void (^)(id   responseObject))success
                     failure:(void (^)(NSError *  error))failure;


+ (instancetype)sharedInstance;



@end
