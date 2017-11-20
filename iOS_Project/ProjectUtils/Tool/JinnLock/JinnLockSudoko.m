//
//  AppDelegate.m
//  houhe_ios
//
//  Created by hulianxinMac on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "JinnLockSudoko.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockSudoko ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat        circleMargin;
@property (nonatomic, assign) CGPoint        currentPoint;
@property (nonatomic, assign, getter = isErrorPassword) BOOL errorPasscode;
@property (nonatomic, assign, getter = isDrawing) BOOL drawing;

@end

@implementation JinnLockSudoko

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
    self.circleMargin        = kSudokoSideLength / 15;
}

- (void)createCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = self.circleMargin * (4.5 * (i % 3) + 1.5);
        float y = self.circleMargin * (4.5 * (i / 3) + 1.5);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:self.circleMargin * 3];
        [circle setTag:kSudokoLevelBase + i];
        [circle setFrame:CGRectMake(x, y, self.circleMargin * 3, self.circleMargin * 3)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Public

- (void)showErrorPasscode:(NSString *)errorPasscode
{
    self.errorPasscode = YES;
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:errorPasscode.length];
    
    for (int i = 0; i < errorPasscode.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [errorPasscode substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] updateCircleState:JinnLockCircleStateError];
        [self.selectedCircleArray addObject:self.circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reset];
    });
}

- (void)reset
{
    if (!self.drawing)
    {
        self.errorPasscode = NO;
        
        for (JinnLockCircle *circle in self.circleArray)
        {
            [circle updateCircleState:JinnLockCircleStateNormal];
        }
        
        [self.selectedCircleArray removeAllObjects];
        [self setNeedsDisplay];
    }
}

#pragma mark - Private

- (void)updateTrack:(CGPoint)point
{
    self.currentPoint = point;
    
    for (JinnLockCircle *circle in self.circleArray)
    {
        CGFloat xABS = fabs(point.x - circle.center.x);
        CGFloat yABS = fabs(point.y - circle.center.y);
        CGFloat radius = self.circleMargin * 3 / 2;
        
        if (xABS <= radius && yABS <= radius)
        {
            if (circle.state == JinnLockCircleStateNormal)
            {
                [circle updateCircleState:JinnLockCircleStateSelected];
                [self.selectedCircleArray addObject:circle];
            }
            
            break;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)endTrack
{
    self.drawing = NO;
    
    NSString *passcode = @"";
    for (int i = 0; i < self.selectedCircleArray.count; i++)
    {
        JinnLockCircle *circle = self.selectedCircleArray[i];
        passcode = [passcode stringByAppendingFormat:@"%ld", circle.tag - kSudokoLevelBase];
    }
    
    [self reset];
    
    if ([_delegate respondsToSelector:@selector(sudoko:passcodeDidCreate:)])
    {
        [_delegate sudoko:self passcodeDidCreate:passcode];
    }
}

#pragma mark - Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.drawing = NO;
    
    if (self.errorPasscode)
    {
        [self reset];
    }
    
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.drawing = YES;
    
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (self.selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kSudokoTrackWidth);
    self.errorPasscode ? [JINN_LOCK_COLOR_ERROR set] : [JINN_LOCK_COLOR_NORMAL set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in self.selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
    
    if (!self.errorPasscode)
    {
        UIButton* lastButton = self.selectedCircleArray.lastObject;
        CGContextMoveToPoint(context, lastButton.center.x, lastButton.center.y);
        CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
        CGContextStrokePath(context);
    }
}

@end
