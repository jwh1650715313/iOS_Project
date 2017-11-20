/*
 
 Erica Sadun, http://ericasadun.com
 iOS 7 Cookbook
 Use at your own risk. Do no harm.
 
 */

#import "UIView+LayoutHelper.h"

// These are repeats, to avoid dependency on other files

CGFloat pointAdapt6(CGFloat point) {
    CGFloat standard = 375.0;
    int screenwidth = (int)[UIScreen mainScreen].bounds.size.width;
    
    switch (screenwidth) {
        case 320:
            return point*(320/standard);
        case 375:
            return point*(375/standard);
        case 414:
            return point*(414/standard);
        default:
            return point*(screenwidth/standard);
    }
    return point;
}

CGFloat pointAdapt4(CGFloat point) {
    CGFloat standard = 320.0;
    int screenwidth = (int)[UIScreen mainScreen].bounds.size.width;
    
    switch (screenwidth) {
        case 320:
            return point*(320/standard);
        case 375:
            return point*(375/standard);
        case 414:
            return point*(414/standard);
        default:
            return point*(screenwidth/standard);
    }
    
    return point;
}


CGPoint CGRectGetCenter(CGRect rect) {
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center) {
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-(rect.size.width / 2.0);
    newrect.origin.y = center.y-(rect.size.height / 2.0);
    newrect.size = rect.size;
    return newrect;
}

CGRect CGRectCenteredInRect(CGRect rect, CGRect mainRect) {
    CGFloat xOffset = CGRectGetMidX(mainRect)-CGRectGetMidX(rect);
    CGFloat yOffset = CGRectGetMidY(mainRect)-CGRectGetMidY(rect);
    return CGRectOffset(rect, xOffset, yOffset);
}

// 屏幕宽度
CGFloat ScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

// 屏幕高度
CGFloat ScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

// 屏幕矩形
CGRect ScreenRect() {
    return [UIScreen mainScreen].bounds;
}

@implementation UIView (ViewGeometry)
// Midpoint is with respect to the view's coordinate system
// and not the superview's coordinate system
- (CGPoint)midpoint {
    CGRect frame = self.frame;
    frame.origin = CGPointZero;
    CGFloat x = CGRectGetMidX(frame);
    CGFloat y = CGRectGetMidY(frame);
    return CGPointMake(x, y);
}

// Query other frame locations
- (CGPoint)bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topLeft {
    return self.frame.origin;
}

- (CGPoint)topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

// Retrieve and set the origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight: (CGFloat) newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth: (CGFloat) newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop: (CGFloat) newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGFloat delta = newbottom - (self.frame.origin.y + self.frame.size.height);
    CGRect newframe = self.frame;
    newframe.origin.y += delta;
    self.frame = newframe;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

// Move via offset
- (void)moveBy:(CGPoint)delta {
    CGPoint newCenter = CGPointMake(self.center.x + delta.x, self.center.y + delta.y);
    self.center = newCenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)fillParent {
    if (self.superview)
        self.frame = self.superview.frame;
}

- (void)fillScreen {
    
}

- (void)centerH_To_View:(UIView *)view xoffset:(CGFloat)xoffset {
    CGPoint center = self.center;
    center.x = view.center.x + xoffset;
    self.center = center;
}

- (void)centerV_To_View:(UIView *)view yoffset:(CGFloat)yoffset {
    CGPoint center = self.center;
    center.y = view.center.y + yoffset;
    self.center = center;
}

- (void)center_To_View:(UIView *)view offset:(CGSize)offset {
    CGPoint center = self.center;
    center.x = view.center.x + offset.width;
    center.y = view.center.y + offset.height;
    self.center = center;
}

- (void)centerH_To_Parent:(CGFloat)xoffset {
    CGPoint center = self.center;
    center.x = CGRectGetMidX(self.superview.bounds) + xoffset;
    self.center = center;
}

- (void)centerV_To_Parent:(CGFloat)yoffset {
    CGPoint center = self.center;
    center.y = CGRectGetMidY(self.superview.bounds) + yoffset;
    self.center = center;
}

- (void)center_To_Parent:(CGSize)offset {
    CGPoint center = self.center;
    center.x = CGRectGetMidX(self.superview.bounds) + offset.width;
    center.y = CGRectGetMidY(self.superview.bounds) + offset.height;
    self.center = center;
}

- (void)center_To_Parent {
    [self center_To_Parent:CGSizeZero];
}

- (void)center_To_View:(UIView *)view {
    [self center_To_View:view offset:CGSizeZero];
}

- (void)layoutLeft_To_View:(UIView*)view xoffset:(CGFloat)xoffset {
    self.right = view.left + xoffset;
}

- (void)layoutRight_To_View:(UIView*)view xoffset:(CGFloat)xoffset {
    self.left = view.right + xoffset;
}

- (void)layoutTop_To_View:(UIView*)view yoffset:(CGFloat)yoffset {
    self.bottom = view.top + yoffset;
}
- (void)layoutBottom_To_View:(UIView*)view yoffset:(CGFloat)yoffset {
    self.top = view.bottom + yoffset;
}

- (void)layoutLeft_To_Parent:(CGFloat)xoffset {
    self.left = xoffset;
}

- (void)layoutRight_To_Parent:(CGFloat)xoffset {
    self.right = self.superview.width + xoffset;
}

- (void)layoutTop_To_Parent:(CGFloat)yoffset {
    self.top = yoffset;
}

- (void)layoutBottom_To_Parent:(CGFloat)yoffset {
    self.bottom = self.superview.height + yoffset;
}

+ (CGRect)scaleRect:(CGRect)rect xscale:(CGFloat)xscale yscale:(CGFloat)yscale {
    return CGRectMake(rect.origin.x*xscale, rect.origin.y*yscale, rect.size.width*xscale, rect.size.height*yscale);
}

- (void)testColor{
    self.backgroundColor = [UIColor  redColor];
}
@end