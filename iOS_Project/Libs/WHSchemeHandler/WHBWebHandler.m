//
//  WHBWebHandler.m
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/3.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import "WHBWebHandler.h"
#import <objc/message.h>
#import "WHSchemeHandler.h"
@interface WHBWebHandler ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, weak) id<WKNavigationDelegate> wkWebViewDelegate;

@end

@implementation WHBWebHandler

+ (WHBWebHandler *)handleWeb:(WKWebView *)webView {
    return [[WHBWebHandler alloc]initWithWebView:webView];
}

- (instancetype)initWithWebView:(WKWebView *)webView {
    self = [super init];
    if (self) {
        _webView = webView;
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
        [_bridge setWebViewDelegate:self];
        _webView.UIDelegate = self;
    }
    return self;
}

- (void)setWebViewDelegate:(id)webViewDelegate {
    _wkWebViewDelegate = webViewDelegate;
}

// 注册JS响应方法
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    [self.bridge registerHandler:handlerName handler:handler];
}

// 调用JS注册方法
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [self.bridge callHandler:handlerName data:data responseCallback:responseCallback];
}

- (void)dealloc {
    _webView = nil;
    _webView.navigationDelegate = nil;
    _bridge = nil;
    _wkWebViewDelegate = nil;
}

#pragma mark-WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *handleURL = navigationAction.request.URL;
    SEL selector = NSSelectorFromString(@"canHandleUrl:webView:action:");
    BOOL canHandle = NO;

    NSURL *URL = navigationAction.request.URL;

    NSString *scheme = [URL scheme];
      
     if ([scheme isEqualToString:@"wxxcx"]) {
         
         NSLog(@"小程序");
         
         
      
    
     }
     
     if ([[WHSchemeHandler currentHandler]respondsToSelector:selector]) {
         canHandle = ((BOOL (*)(id, SEL, NSURL*, WKWebView*, WKNavigationAction*))objc_msgSend)([WHSchemeHandler currentHandler], selector, handleURL, webView, navigationAction);
     }
     if (canHandle) {
         [[WHSchemeHandler currentHandler]handleUrl:navigationAction.request.URL.absoluteString animated:YES];
         decisionHandler(WKNavigationActionPolicyCancel);
         return;
     }
     __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
     if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
         [_wkWebViewDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
     } else {
         decisionHandler(WKNavigationActionPolicyAllow);
     }

    
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [strongDelegate webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [strongDelegate webView:webView didStartProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [strongDelegate webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [strongDelegate webView:webView didCommitNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [strongDelegate webView:webView didFinishNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [strongDelegate webView:webView didFailNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        [strongDelegate webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    if (webView != _webView) { return; }
    __strong typeof(_wkWebViewDelegate) strongDelegate = _wkWebViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]) {
        [strongDelegate webViewWebContentProcessDidTerminate:webView];
    }
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (![navigationAction.targetFrame isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    
}


@end
