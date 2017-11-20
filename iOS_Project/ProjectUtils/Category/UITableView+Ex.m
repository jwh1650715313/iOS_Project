//
//  UITableView+Common.m
//  Catering
//
//  Created by apple_administrator on 16/3/23.
//  Copyright © 2016年 TeYou. All rights reserved.
//

#import "UITableView+Ex.h"

@implementation UITableView (Common)

- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 5.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        //        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        if (cell.backgroundColor) {
            layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
        }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
            layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
        }else{
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        }
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+2, bounds.size.height-lineHeight, bounds.size.width-2, lineHeight);
            
            lineLayer.backgroundColor = self.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
    }
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    
    //判断整个tableview 最后的元素
    if ((self.numberOfSections==(indexPath.section+1))&&indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //上短,下长
        //        [self layer:layer addLineUp:TRUE andLong:YES andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
        [self layer:layer addLineUp:NO andLong:YES andColor:lineColor andBounds:bounds withLeftSpace:0];
    }else
    {
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
    
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xE2E2E2"].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    //    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    //    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
           // [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            //[self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace hasSectionLine:(BOOL)hasSectionLine SectionLineIsLong:(BOOL)sectionLong {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    //    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdddddd"].CGColor;
    //    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:sectionLong andColor:sectionLineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace rightSpace:rightSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    [self addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rSpace {
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, right, top;
    if (isUp) {
        top = 0;
    } else {
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
        right = 0;
    } else {
        left = leftSpace;
        right = rSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + left, top, bounds.size.width - left - right, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}


@end
