//
//  BaseWebViewController.h
//  houhe_ios
//
//  Created by hulianxin on 2017/4/24.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : BaseViewController

@property (copy, nonatomic) NSString *webUrl;
@property (copy, nonatomic) NSString *html;
@property (copy, nonatomic) NSString *htmlTitle;
///点击返回是否不直接返回，默认不直接返回
@property (assign, nonatomic) BOOL isNotBackDirect;

@end
