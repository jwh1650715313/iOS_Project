//
//  BaseTextTableViewCell.h
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/24.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)setArrowImgStr:(NSString *)arrowImgStr;
///默认15  图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthLayOut;


/**
 *  隐藏右边箭头按钮,默认显示
 */
- (void)hideIndicator;

/**
 *  显示右边箭头按钮
 */
- (void)showIndicator;

@end
