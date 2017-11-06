//
//  HttpRequstManager.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/27.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id response, NSInteger resposeCode);
typedef void(^FailureBlock)(NSError *error, NSString *errorMsg);
typedef void(^FailureBlockCode)(NSDictionary *error, NSString *errorMsg,NSInteger code);

@interface HttpRequstManager : NSObject

//get
- (void)getRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

//POST
- (void)postRequestWithUrl:(NSString *)url
                    params:(id)params
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

//PUT
- (void)putRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

//PATCH
- (void)patchRequestWithUrl:(NSString *)url
                     params:(id)params
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure;

//DELETE
- (void)deleteRequestWithUrl:(NSString *)url
                      params:(id)params
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;


+ (instancetype)sharedInstance;



@end
