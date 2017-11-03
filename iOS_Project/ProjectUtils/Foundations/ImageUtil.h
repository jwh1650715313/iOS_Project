//
//  ImageUtil.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/26.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject


//高斯模糊图片
+ (UIImage *)getCIGaussianBlurImageWithRadius:(CGFloat)radius image:(UIImage *)image;

+ (UIImage *)fixOrientation:(UIImage *)aImage;//改变图片的方向

+ (UIImage *)grayscale:(UIImage *)anImage type:(char)type;

+ (UIImage *)imageFromColor:(UIColor *)color;



@end
