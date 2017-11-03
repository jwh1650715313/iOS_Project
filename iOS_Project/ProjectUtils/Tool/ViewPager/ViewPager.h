//
//  ViewPager.h
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewPager;

typedef NS_ENUM(NSInteger, ViewPagerState) {
    ViewPagerStateIdle,             // the state of idle.
    ViewPagerStateDragging,         // the state of user's dragging
    ViewPagerStateSettling,         // the state of actions after user's finger leave the view, and the next state should be idle
};

@protocol ViewPagerDelegate<NSObject>

@optional
// selected at which index
- (void)viewPager:(ViewPager *)viewPager didPageSelectedAtIndex:(NSInteger)index;
// the state of viewPager changed
- (void)viewPager:(ViewPager *)viewPager didPageScrollStateChanged:(NSInteger)state;

//- (void)didSelectedPageAtIndex:(NSInteger)index;

@end


@interface ViewPager : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSArray *_views;
}



- (id)initWithFrame:(CGRect)frame andViews:(NSArray *)views;

- (NSInteger)currentPage;

- (void)SetscrollViewHeight:(NSInteger )Height;

- (UIView *)currentView;

- (BOOL)setCurrentPage:(NSInteger)index animated:(BOOL)animated;

@property(nonatomic,assign) id<ViewPagerDelegate> delegate;

@property (nonatomic, assign) BOOL Enabled;

@end
