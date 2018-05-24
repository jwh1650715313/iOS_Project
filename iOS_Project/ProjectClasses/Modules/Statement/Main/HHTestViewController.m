//
//  HHTestViewController.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/5/24.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHTestViewController.h"

#import "STPhotoBrowserController.h"
#import "UIView+STPhotoBrowser.h"
#import "STPhotoBrowserUI.h"
#import <UIButton+WebCache.h>


@interface HHTestViewController ()<STPhotoBrowserDelegate>


@property (nonatomic, strong, nullable)NSArray *arrayImageUrl; //

@property (nonatomic, strong, nullable)UIScrollView *scrollView; //

@property (nonatomic, strong, nullable)NSMutableArray *arrayButton; //


@end

@implementation HHTestViewController

#pragma mark - lift cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    
    __block CGFloat buttonW = (CGRectGetWidth(self.view.frame) - STMargin * 3)/3;
    __block CGFloat buttonH = buttonW;
    __block CGFloat buttonX = 0;
    __block CGFloat buttonY = 0;
    [self.arrayImageUrl enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        buttonX = STMargin + (idx % 3) * (buttonW + STMarginSmall);
        buttonY = (idx / 3) * (buttonH + STMarginSmall);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                     buttonY,
                                                                     buttonW,
                                                                     buttonH)];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        button.clipsToBounds = YES;
        [button sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                          forState:UIControlStateNormal
                  placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        
        [button setTag:idx];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.arrayButton addObject:button];
    }];
    
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,
                                               (self.arrayImageUrl.count / 3 + 1)* (buttonH +
                                                                                    STMarginSmall))];
}


#pragma mark - Delegate 视图委托


#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.scrollView.subviews[index] currentImage];
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.arrayImageUrl[index];
    return [NSURL URLWithString:urlStr];
}


#pragma mark - event response 事件相应

- (void)buttonClick:(UIButton *)button
{
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self.scrollView; // 原图的父控件
    browserVc.countImage = self.arrayImageUrl.count; // 图片总数
    browserVc.currentPage = (int)button.tag;
    browserVc.delegate = self;
    [browserVc show];
}

#pragma mark - private methods 私有方法


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark - getters and setters 属性

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    20,
                                                                    CGRectGetWidth(self.view.frame),
                                                                    CGRectGetHeight(self.view.frame) - 20)];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
    }
    return _scrollView;
}

- (NSArray *)arrayImageUrl
{
    return @[@"http://img5.duitang.com/uploads/item/201406/11/20140611041659_jjNvG.thumb.700_0.jpeg",
             @"http://img3.3lian.com/2014/f1/1/d/32.jpg",
             @"http://img4.duitang.com/uploads/item/201406/27/20140627004739_nQwxv.jpeg"];
}

- (NSMutableArray *)arrayButton
{
    if (!_arrayButton) {
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
}

@end
