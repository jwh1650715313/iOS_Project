//
//  PickerTool.m
//  DSports
//
//  Created by wujianming on 16/12/12.
//  Copyright © 2016年 szteyou. All rights reserved.
//

#import "PickerTool.h"

@interface PickerTool () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIView *mask;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) UIView *toolBar;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger titleIndex;

@end

@implementation PickerTool

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mask = [[UIView alloc] init];
        self.mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
        [self addSubview:self.mask];
        
        [self.mask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskDidTap)];
        [self.mask addGestureRecognizer:tap];
        
        self.toolBar = [[UIView alloc] init];
        self.toolBar.backgroundColor = kCyColorFromHex(0xF5F5F5);
        [self addSubview:self.toolBar];
        
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(40); // 键盘高度
        }];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        [self.toolBar addSubview:effectview];
        
        [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
        [commit setTitle:@"完成" forState:UIControlStateNormal];
        [commit setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        commit.titleLabel.font = [UIFont systemFontOfSize:14.0];
        commit.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15.0);
        commit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.toolBar addSubview:commit];
        
        [commit addTarget:self action:@selector(commitEditAction) forControlEvents:UIControlEventTouchUpInside];
        
        [commit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.toolBar.mas_right);
            make.top.mas_equalTo(self.toolBar.mas_top);
            make.bottom.mas_equalTo(self.toolBar.mas_bottom);
            make.width.mas_equalTo(100);
        }];
        
        self.picker = [[UIPickerView alloc] init];
        self.picker.delegate = self;
        self.picker.dataSource = self;
        self.picker.backgroundColor = [UIColor whiteColor];
        self.picker.showsSelectionIndicator = NO;
        [self addSubview:self.picker];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.toolBar.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(216); // 键盘高度
        }];
    }
    
    return self;
}

- (void)commitEditAction {
    [self hide];
    
    if (self.finishCallBack) {
        self.finishCallBack(self.titleIndex, self.title);
    }
}

- (void)maskDidTap {
    [self hide];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:Font(15)];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.dataSource.count) {
        self.title = self.dataSource[row];
        self.titleIndex = row;
    }
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    for(UIView *speartorView in pickerView.subviews) {
        if (speartorView.frame.size.height < 1) {
            speartorView.backgroundColor = kCyColorFromHex(0xE2E2E2);//隐藏分割线
        }
    }
    
    if (0 == row) {
        self.title = self.dataSource[row];
    }
    
    return self.dataSource[row];
}

- (void)show {
    [KEY_WINDOW addSubview:self];
    self.mask.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.mask.alpha = 1;
        self.picker.transform = CGAffineTransformMakeTranslation(0, -self.picker.bounds.size.height-40);
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -self.picker.bounds.size.height-40);
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.mask.alpha = 0;
        self.picker.transform = CGAffineTransformIdentity;
        self.toolBar.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
