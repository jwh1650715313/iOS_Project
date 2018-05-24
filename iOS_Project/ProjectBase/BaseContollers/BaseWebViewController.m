//
//  BaseWebViewController.m
//  houhe_ios
//
//  Created by hulianxin on 2017/4/24.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "BaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"


@interface BaseWebViewController () <NJKWebViewProgressDelegate,UIWebViewDelegate,NSURLConnectionDelegate> {
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
    BOOL _authenticated;
    NSURLConnection *_urlConnection;
    NSURLRequest *_request;
}

@property (retain, nonatomic) UIWebView *webView;


@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 66.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_progressView setProgress:0 animated:YES];
    _progressView.backgroundColor =kViewBackgroundColor;
    
//    [self.navigationController.navigationBar addSubview:_progressView];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 2, KScreenWidth, KScreenHeight - progressBarHeight)];
//    _webView.delegate = self;
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
//    [self.view addSubview:_webView];
    _webView.delegate = _progressProxy;
    
    NSString  *hostURL=HostName;
    
     if (_webUrl.length) {
         
         if (_webUrl.length >= hostURL.length && [[_webUrl substringToIndex:hostURL.length] isEqualToString:hostURL]) {
             _request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
         }
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    } else if (_html.length) {
        [_webView loadHTMLString:_html baseURL:nil];
    }
    
   
//  _webView.contentMode = UIViewContentModeScaleAspectFit;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    _progressView.frame = CGRectMake(0, 0, KScreenWidth, progressBarHeight);
    [self.view addSubview:_progressView];
    
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title =self.htmlTitle.length>0?self.htmlTitle: [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    if ([webView.request.URL.absoluteString isEqualToString:@"https://api.baiqishi.com/credit/zhima/search"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationeSesameSuccess object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *callBackUrl = @"repay/creditApply/alcallback";
    NSLog(@"=====%@",request.URL.absoluteString);
    if ([request.URL.absoluteString containsString:callBackUrl]) {
        
        NSString  *endStr = [[request.URL.absoluteString componentsSeparatedByString:@"?"] lastObject];
        NSArray *paraArr = [endStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
        for (NSString *subStr in paraArr) {
            NSArray *temArr = [subStr componentsSeparatedByString:@"="];
            [para setObject:kEnsureNotNil(temArr[1]) forKey:kEnsureNotNil(temArr[0])];
        }
        if ([para[@"success"] isEqualToString:@"true"]) {
           
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
      NSString  *hostURL=HostName;
    
    if (_webUrl.length >= hostURL.length && [[_webUrl substringToIndex:hostURL.length] isEqualToString:hostURL]) {
        if (!_authenticated) {
            _authenticated = NO;
            _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
            [_urlConnection start];
            return NO;
        }
    }
    return YES;
}

#pragma mark -connectDelegate
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"验证签名证书");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [_webView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
