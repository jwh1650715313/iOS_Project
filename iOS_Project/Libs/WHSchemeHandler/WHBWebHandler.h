//
//  WHBWebHandler.h
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/3.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHBWebHandler : NSObject


// 生成webHandler
+ (WHBWebHandler *)handleWeb:(WKWebView *)webView;

// 设置webView代理
- (void)setWebViewDelegate:(id)webViewDelegate;

/**
 注册JS响应方法

 @param handlerName JS响应方法名
 @param handler 结果回调
 */
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler;

/**
 调用JS注册方法

 @param handlerName JS注册方法名
 @param data JS所需参数
 @param responseCallback 结果回调
 */
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;



@end

NS_ASSUME_NONNULL_END
