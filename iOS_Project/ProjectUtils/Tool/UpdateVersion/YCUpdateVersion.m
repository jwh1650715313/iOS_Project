//
//  HHUpdateVersion.m
//  iOS_Project
//
//  Created by 金永学 on 2018/4/16.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "YCUpdateVersion.h"

@implementation YCUpdateVersion
{
//    UIAlertView * _alert;
    NSInteger forcedUpdate;//是否强制：1.强制更新 0.不强制更新 ,
    NSString * versionName;//序号
    NSString * updateRemark;//更新内容说明
    NSString * iosUrl;//下载链接
}
-(void)updateVersion{
    
    [self.requestManager postRequestWithUrl:queryAppVersion params:nil success:^(id response, NSInteger resposeCode) {
        
        NSLog(@"_____%@",response);
       NSDictionary *dic= response[@"data"];
        forcedUpdate=[dic[@"forcedUpdate"] integerValue];
        iosUrl=dic[@"iosUrl"];
        updateRemark=dic[@"updateRemark"];
        versionName=[dic[@"versionName"] stringByReplacingOccurrencesOfString:@"V" withString:@""];
       
        NSString *oldVersion= [[NSUserDefaults standardUserDefaults]objectForKey:@"versionName"];
        
        if (![versionName isEqualToString:oldVersion]||forcedUpdate) {
            //只展示一次
            [self compareVersion];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:versionName forKey:@"versionName"];
        
    } failure:^(NSError *error, NSString *errorMsg) {
    
    }];
}
-(void)compareVersion{
    NSString *localVerson=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    char storeVersion0=[versionName characterAtIndex:0];
    char storeVersion2=[versionName characterAtIndex:2];
    char storeVersion4=[versionName characterAtIndex:4];
    
    char localVerson0=[localVerson characterAtIndex:0];
    char localVerson2=[localVerson characterAtIndex:2];
    char localVerson4=[localVerson characterAtIndex:4];
    
    int a=localVerson0-storeVersion0;
    int b=localVerson2-storeVersion2;
    int c=localVerson4-storeVersion4;
    
    [self up:a update:b update:c];
}
-(void)up:(NSInteger )a update:(NSInteger )b update:(NSInteger )c{
    
    if (a<0) {
        [self show];
    }else if (a==0){
        if (b<0) {
            [self show];
        }else if (b==0)
        {
            if (c<0) {
                [self show];
            }
        }
    }
}

-(void)show{
    
    
    if (forcedUpdate==1) {
        //强更
        
        [HHPopupView alertWithTitle:@"更新" detail:updateRemark contentArr:@[@"更新"] selectComplete:^(NSInteger index) {
            if (index==0) {
                //强更
                NSURL *url = [NSURL URLWithString:iosUrl];
                [[UIApplication sharedApplication]openURL:url];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self show];
 });
            }
        }];
    }
    
    else{
        //hidden

        [HHPopupView alertWithTitle:@"更新" detail:updateRemark contentArr:@[@"忽略",@"更新"] selectComplete:^(NSInteger index) {
            if (index==1) {
                NSURL *url = [NSURL URLWithString:iosUrl];
                [[UIApplication sharedApplication]openURL:url];
            }
        }];
    }
    
    
}
#pragma mark - 懒加载

- (HttpRequstManager *)requestManager {
    if (!_requestManager) {
        _requestManager = [HttpRequstManager sharedInstance];
    }
    return _requestManager;
}
@end
