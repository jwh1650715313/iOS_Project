//
//  BaseCollectionViewCell.m
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/8/2.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setData:(id)data delegate:(id)delegate {
    
}

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (float)getCellFrame:(id)msg {
    if ([msg isKindOfClass:[NSNumber class]]) {
        NSNumber *number = msg;
        float height = number.floatValue;
        if (height > 0) {
            return height;
        }
    }
    return 44;
}
@end
