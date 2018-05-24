//
//  AppDelegate.m
//  houhe_ios
//
//  Created by hulianxinMac on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "JinnLockIndicator.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockIndicator ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat        circleMargin;

@end

@implementation JinnLockIndicator

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self createCircles];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor     = [UIColor clearColor];
    self.clipsToBounds       = YES;
    
    self.circleArray         = [NSMutableArray array];
    self.selectedCircleArray = [NSMutableArray array];
    self.circleMargin        = kIndicatorSideLength / 15;
}

- (void)createCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = self.circleMargin * (4.5 * (i % 3) + 1.5);
        float y = self.circleMargin * (4.5 * (i / 3) + 1.5);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:self.circleMargin * 3];
        
        circle.Indicator=YES;
        [circle setTag:kIndicatorLevelBase + i];
        [circle setFrame:CGRectMake(x, y, self.circleMargin * 3, self.circleMargin * 3)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Public

- (void)showPasscode:(NSString *)passcode
{
    [self reset];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:passcode.length];
    for (int i = 0; i < passcode.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [passcode substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] updateCircleState:JinnLockCircleStateFill];
        [self.selectedCircleArray addObject:self.circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
}

- (void)reset
{
    
   
    
    
    for (JinnLockCircle *circle in self.circleArray)
    {
        [circle updateCircleState:JinnLockCircleStateNormal];
    }
    
    [self.selectedCircleArray removeAllObjects];
    
    
    
   
    
    
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (self.selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kIndicatorTrackWidth);
    [ClearColor set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in self.selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
}

@end
