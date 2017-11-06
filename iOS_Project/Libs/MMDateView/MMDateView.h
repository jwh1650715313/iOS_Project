//
//  MMDateView.h
//  MMPopupView
//
//  Created by Ralph Li on 9/7/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^DateSelectBlock)(NSDate *date);

@interface MMDateView : MMPopupView

- (instancetype)initWithModel:(UIDatePickerMode)model minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectFinish:(DateSelectBlock)dateSelect;

@end
