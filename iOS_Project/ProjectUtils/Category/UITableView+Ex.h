//
//  UITableView+Common.h
//  Catering
//
//  Created by apple_administrator on 16/3/23.
//  Copyright © 2016年 TeYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Ex)
- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;
/**  leftSpace左边距离 rightSpace右边距离 hasSectionLine Section要不要线 sectionLong线长还是短*/
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace hasSectionLine:(BOOL)hasSectionLine SectionLineIsLong:(BOOL)sectionLong;
@end
