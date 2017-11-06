//
//  MMDateView.m
//  MMPopupView
//
//  Created by Ralph Li on 9/7/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMDateView.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import <Masonry/Masonry.h>

@interface MMDateView() {
    DateSelectBlock _dateSelectBlk;
}

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@end

@implementation MMDateView


- (instancetype)initWithModel:(UIDatePickerMode)model minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectFinish:(DateSelectBlock)dateSelect
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        _dateSelectBlk = dateSelect;
        self.backgroundColor = [UIColor whiteColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(216+50);
        }];
        
        self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        [self addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.left.top.equalTo(self);
        }];
        self.btnCancel.tag = 1000;
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        
        
        self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        self.btnConfirm.tag = 1001;
        [self addSubview:self.btnConfirm];
        [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.right.top.equalTo(self);
        }];
        [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnConfirm setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        
        self.datePicker = [UIDatePicker new];
        self.datePicker.datePickerMode = model;
        if (minDate) {
            self.datePicker.minimumDate = minDate;
        }
        if (maxDate) {
            self.datePicker.maximumDate = maxDate;
        }
        [self addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
    }
    
    return self;
}

- (void)actionHide:(UIButton*)sender
{
    if (sender.tag == 1001) {
        if (_dateSelectBlk) {
            _dateSelectBlk(_datePicker.date);
        }
    }
    [self hide];
}

@end
