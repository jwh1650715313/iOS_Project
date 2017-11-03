//
//  BaseCollectionViewCell.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/8/2.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (float)getCellFrame:(id)msg;

- (void)setData:(id)data delegate:(id)delegate;



@end
