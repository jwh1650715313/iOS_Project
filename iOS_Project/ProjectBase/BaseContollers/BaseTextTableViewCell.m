//
//  BaseTextTableViewCell.m
//  HuoHe_iOS
//
//  Created by hulianxin on 2017/3/24.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "BaseTextTableViewCell.h"

@implementation BaseTextTableViewCell {
    
    __weak IBOutlet NSLayoutConstraint *_arrowToRight;
    __weak IBOutlet UIImageView *_arrowView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 *  隐藏右边箭头按钮，默认显示
 */
- (void)hideIndicator {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _arrowView.hidden = YES;
    _arrowToRight.constant = - (SCALE_WIDTH(16) - 11);
}

/**
 *  显示右边箭头按钮
 */
- (void)showIndicator {
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    _arrowView.hidden = NO;
    _arrowToRight.constant = 15.0f;
}

- (void)setArrowImgStr:(NSString *)arrowImgStr {
    _arrowView.image = [UIImage imageNamed:arrowImgStr];
}
@end
