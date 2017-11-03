//
//  ViewPager.m
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import "ViewPager.h"

@implementation ViewPager
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andViews:(NSArray *)views
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _views = views;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _Enabled=YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame=CGRectMake(0, 0, self.frame.size.width, rect.size.height);
   
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.scrollEnabled =_Enabled;
    CGRect frame;
    frame.origin.y = 0;
    frame.size.height = _scrollView.frame.size.height;
    frame.size.width = _scrollView.frame.size.width;
    for (int i = 0; i < _views.count; i++) {
        UIView* view = [_views objectAtIndex:i];
        frame.origin.x = self.frame.size.width*i;
        [view setFrame:frame];
        [_scrollView addSubview:view];
    }
    
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width*_views.count + 1, rect.size.height)];
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    
}

#pragma mark - UIScrollView Delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
    
    if ([self.delegate respondsToSelector:@selector(viewPager:didPageSelectedAtIndex:)]) {
        [self.delegate viewPager:self didPageSelectedAtIndex:index];
    }
    
}


- (NSInteger)currentPage{
    NSInteger index = _scrollView.contentOffset.x / self.frame.size.width;
    return index;
}

- (void)SetscrollViewHeight:(NSInteger )Height
{
    
    _scrollView.height=Height;
    
}



- (UIView *)currentView{
    return [_views objectAtIndex:[self currentPage]];
}

- (BOOL)setCurrentPage:(NSInteger)index animated:(BOOL)animated{
    if (index > _scrollView.contentSize.width/self.frame.size.width) {
        return NO;
    }
    if (index == [self currentPage]) {
        return NO;
    }
    
    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * index, _scrollView.contentOffset.y, self.width, self.height) animated:animated];
    return YES;
}

@end
