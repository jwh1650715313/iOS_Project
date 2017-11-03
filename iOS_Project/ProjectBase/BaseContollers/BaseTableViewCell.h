//
//  BaseTableViewCell.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/8/2.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SecondHouseCellType) {
    SecondHouseCellTypeFirst,
    SecondHouseCellTypeMiddle,
    SecondHouseCellTypeLast,
    SecondHouseCellTypeSingle,
    SecondHouseCellTypeAny,
    SecondHouseCellTypeHaveTop,
    SecondHouseCellTypeHaveBottom,
    SecondHouseCellTypeNone
};

@interface BaseTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *lineviewTop;//上横线
@property (strong, nonatomic)  UIImageView *lineviewBottom;//下横线,都是用来分隔cell的

- (void)setSeperatorLineForIOS7 :(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
- (void)setData:(id)data delegate:(id)delegate;


+ (float)getCellFrame:(id)msg;//返回高度的


@end



