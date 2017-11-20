/*
 
 Erica Sadun, http://ericasadun.com
 iOS 7 Cookbook
 Use at your own risk. Do no harm.
 
 */


#import <UIKit/UIKit.h>

CGFloat pointAdapt4(CGFloat point);
CGFloat pointAdapt6(CGFloat point);

// 获取矩形的中心点
CGPoint CGRectGetCenter(CGRect rect);
// 将矩形的中心点移到指定点
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);
// 将矩形与指定矩形中心对齐
CGRect  CGRectCenteredInRect(CGRect rect, CGRect mainRect);
// 屏幕宽度
CGFloat ScreenWidth();
// 屏幕高度
CGFloat ScreenHeight();
// 屏幕矩形
CGRect ScreenRect();

@interface UIView (LayoutHelper)

@property (readonly) CGPoint midpoint;      // 中点，等同于cener
@property (readonly) CGPoint bottomLeft;    // 左下角
@property (readonly) CGPoint bottomRight;   // 右下角
@property (readonly) CGPoint topLeft;       // 左上角
@property (readonly) CGPoint topRight;      // 右上角


@property CGPoint origin;                   // 原点（左上角）
@property CGSize size;                      // 尺寸
@property CGFloat height;                   // 高度
@property CGFloat width;                    // 宽度
@property CGFloat top;                      // 顶部位置
@property CGFloat left;                     // 左侧位置
@property CGFloat bottom;                   // 底部位置
@property CGFloat right;                    // 右侧位置


// 移动指定距离
- (void)moveBy:(CGPoint)delta;
// 缩放
- (void)scaleBy:(CGFloat)scaleFactor;
// 适配指定尺寸
- (void)fitInSize:(CGSize)aSize;
// 填满父窗口
- (void)fillParent;
// 填满屏幕
- (void)fillScreen;

// 水平居中对齐
- (void)centerH_To_View:(UIView *)view xoffset:(CGFloat)xoffset;
// 垂直居中对齐
- (void)centerV_To_View:(UIView *)view yoffset:(CGFloat)yoffset;
// 居中对齐
- (void)center_To_View:(UIView *)view offset:(CGSize)offset;
// 居中对齐
- (void)center_To_View:(UIView *)view;

// 水平居中对齐父窗口
- (void)centerH_To_Parent:(CGFloat)xoffset;
// 垂直居中对齐父窗口
- (void)centerV_To_Parent:(CGFloat)yoffset;
// 居中对齐父窗口
- (void)center_To_Parent:(CGSize)offset;
// 居中对齐父窗口
- (void)center_To_Parent;

// 置于View的左边
- (void)layoutLeft_To_View:(UIView*)view xoffset:(CGFloat)xoffset;
// 置于View的右边
- (void)layoutRight_To_View:(UIView*)view xoffset:(CGFloat)xoffset;
// 置于View的上边
- (void)layoutTop_To_View:(UIView*)view yoffset:(CGFloat)yoffset;
// 置于View的底边
- (void)layoutBottom_To_View:(UIView*)view yoffset:(CGFloat)yoffset;

// 置于父窗口的左边
- (void)layoutLeft_To_Parent:(CGFloat)xoffset;
// 置于父窗口的右边
- (void)layoutRight_To_Parent:(CGFloat)xoffset;
// 置于父窗口的上边
- (void)layoutTop_To_Parent:(CGFloat)yoffset;
// 置于父窗口的底边
- (void)layoutBottom_To_Parent:(CGFloat)yoffset;

+ (CGRect)scaleRect:(CGRect)rect xscale:(CGFloat)xscale yscale:(CGFloat)yscale;

- (void)testColor;
@end
