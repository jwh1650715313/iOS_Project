//
//  WHWebController.m
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/3.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import "WHWebController.h"
#import <WebKit/WebKit.h>
#import "WHBWebHandler.h"

@interface WHWebController ()


@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL canReturnRefresh;

@property (nonatomic, strong) WHBWebHandler *webHandler;

@end

@implementation WHWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)initUI{
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    _webHandler = [WHBWebHandler handleWeb:self.webView];
    [_webHandler setWebViewDelegate:self];
    [self registerHandler];
    [self callHandler];
    [self loadRequest];
   
    
    self.webView.sd_layout
    .topSpaceToView(self.view,0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view).offset(TABBAR_OFFSET);
    
    self.progressView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(1);
    
    // kvo
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    progressView.tintColor = kCyColorFromHex(0x3FA2FF);
    progressView.trackTintColor = [UIColor clearColor];
    [progressView setProgress:0 animated:NO];

}

- (void)registerHandler {
    WEAKSELF
    // 执行用户登录
       [self.webHandler registerHandler:@"userLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
           
           
           
    }];
}


- (void)callHandler {
    
    /*
    [self.webHandler callHandler:@"getShareInfo" data:@{@"uid":@"1"} responseCallback:^(id responseData) {
        NSLog(@"拿到js回调的分享数据%@",responseData);
    }];
     
     */
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(void)loadRequest{
    
    NSURL *theURL = [NSURL URLWithString:self.url];
    NSURLRequestCachePolicy cachePolicy = [self shouldIgnoreLocalCacheDataWithURL:theURL] ? NSURLRequestReloadIgnoringLocalCacheData : NSURLRequestUseProtocolCachePolicy;
    NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:theURL cachePolicy:cachePolicy timeoutInterval:10.0];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    if (cookies) {
        NSMutableString *cookieString = [NSMutableString string];
        for (NSHTTPCookie *cookie in cookies) {
            [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
        }
        [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
    
    [self.webView loadRequest:request];

}

-(BOOL)shouldIgnoreLocalCacheDataWithURL:(NSURL *)url {
    BOOL rlt = TRUE;
    NSString *host = url.host;
    if (host && host.length > 0) {
        if (![@[@"m.hinabian.com",@"m.dighouse.com"] containsObject:host]) {
            rlt = FALSE;
        }
    }
    return rlt;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _webView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            self.progressView.progress = self.webView.estimatedProgress;
            self.progressView.hidden = self.webView.estimatedProgress == 1 ? YES : NO;
        }
        if ([keyPath isEqualToString:@"title"]) {
            self.title = self.webView.title;
          
        }
    }
}


- (void)navGoBack {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        UIViewController *backController = nil;
        NSArray *controllers = self.navigationController.viewControllers;
        NSInteger index = -1;
        for (NSInteger i = controllers.count - 1; i >= 0; i--) {
            UIViewController *controller = controllers[i];
            /*
            if ([controller isKindOfClass:AssessController.class] && i != controllers.count - 1) {
                index = i - 1;
                break;
            }
             */
        }
        if (index >= 0) {
            backController = controllers[index];
        }
        if (backController) {
            [self.navigationController popToViewController:backController animated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}



- (WKWebView *)webView {
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.allowsInlineMediaPlayback = YES;
        config.preferences.minimumFontSize = 9;
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        _webView.allowsBackForwardNavigationGestures = YES;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.tintColor = kCyColorFromHex(0x3FA2FF);
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progress = 0;
    }
    return _progressView;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
