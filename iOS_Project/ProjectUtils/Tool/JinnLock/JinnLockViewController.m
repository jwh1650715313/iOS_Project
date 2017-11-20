//
//  AppDelegate.m
//  houhe_ios
//
//  Created by hulianxinMac on 2017/3/31.
//  Copyright © 2017年 hulianxinMac. All rights reserved.
//

#import "JinnLockViewController.h"
#import <LocalAuthentication/LAContext.h>
#import "Masonry.h"
#import "JinnLockConfig.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"
//#import "HHGetMentLoanManger.h"
#import "TDTouchID.h"

typedef NS_ENUM(NSInteger, JinnLockStep)
{
    JinnLockStepNone = 0,
    JinnLockStepCreateNew,
    JinnLockStepCreateAgain,
    JinnLockStepCreateNotMatch,
    JinnLockStepCreateReNew,
    JinnLockStepModifyOld,
    JinnLockStepModifyOldError,
    JinnLockStepModifyReOld,
    JinnLockStepModifyNew,
    JinnLockStepModifyAgain,
    JinnLockStepModifyNotMatch,
    JinnLockStepModifyReNew,
    JinnLockStepVerifyOld,
    JinnLockStepVerifyOldError,
    JinnLockStepVerifyReOld,
    JinnLockStepRemoveOld,
    JinnLockStepRemoveOldError,
    JinnLockStepRemoveReOld
};

@interface JinnLockViewController () <JinnLockSudokoDelegate>

@property (nonatomic, weak) id<JinnLockViewControllerDelegate> delegate;
@property (nonatomic, assign) JinnLockType       type;
@property (nonatomic, assign) JinnLockAppearMode appearMode;

@property (nonatomic, strong) JinnLockIndicator  *indicator;
@property (nonatomic, strong) JinnLockSudoko     *sudoko;
@property (nonatomic, strong) UILabel            *noticeLabel;
@property (nonatomic, strong) UIButton           *resetButton;
@property (nonatomic, strong) UIButton           *touchIdButton;

@property (nonatomic, assign) JinnLockStep       step;
@property (nonatomic, strong) NSString           *passcodeTemp;
@property (nonatomic, strong) LAContext          *context;


@property (nonatomic, assign) NSInteger countt;

@end

@implementation JinnLockViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.type == JinnLockTypeModify) {
        self.title = @"修改手势密码";
    }
    _countt = 5;
    [self setup];
    [self createViews];
    
    switch (self.type)
    {
        case JinnLockTypeCreate:
        {
            [self updateUiForStep:JinnLockStepCreateNew];
        }
            break;
        case JinnLockTypeModify:
        {
            [self updateUiForStep:JinnLockStepModifyOld];
        }
            break;
        case JinnLockTypeVerify:
        {
            [self updateUiForStep:JinnLockStepVerifyOld];
            
                //[self showTouchIdView];
                [TDTouchID td_showTouchIDWithDescribe:nil BlockState:^(TDTouchIDState state, NSError *error) {
                    if (state == TDTouchIDStateSuccess) {
                        
                        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        appDelegate.window.rootViewController = [BaseTabBarController new];
                    }
                }];
        }
            break;
        case JinnLockTypeRemove:
        {
            [self updateUiForStep:JinnLockStepRemoveOld];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Init

- (instancetype)initWithDelegate:(id<JinnLockViewControllerDelegate>)delegate
                            type:(JinnLockType)type
                      appearMode:(JinnLockAppearMode)appearMode
{
    self = [super init];
    
    if (self)
    {
        self.delegate   = delegate;
        self.type       = type;
        self.appearMode = appearMode;
    }
    
    return self;
}

- (void)setup
{
    self.view.backgroundColor = JINN_LOCK_COLOR_BACKGROUND;
    self.step = JinnLockStepNone;
    self.context = [[LAContext alloc] init];
}

- (void)createViews
{
    JinnLockSudoko *sudoko = [[JinnLockSudoko alloc] init];
    [sudoko setDelegate:self];
    //sudoko.backgroundColor = [UIColor redColor];
    [self.view addSubview:sudoko];
    [self setSudoko:sudoko];
    [sudoko mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerX.equalTo(self.view);
        make.centerY.centerY.equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(kSudokoSideLength, kSudokoSideLength));
    }];
    
    JinnLockIndicator *indicator = [[JinnLockIndicator alloc] init];
    //indicator.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:indicator];
    [self setIndicator:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(sudoko.mas_top).offset(-10);
        if (self.type == JinnLockTypeVerify) {
            
            make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, 0));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, kIndicatorSideLength));
        
        }
        
    }];
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:14]];
    [noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noticeLabel];
    [self setNoticeLabel:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(indicator.mas_top).offset(-20);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *imgvv = [[UIImageView alloc] init];
    //imgvv.backgroundColor = [UIColor redColor];
    imgvv.image = [UIImage imageNamed:@"icon_168"];
    [self.view addSubview:imgvv];
    [imgvv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(indicator.mas_top).offset(-70);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:kJinnLockResetText forState:UIControlStateNormal];
    [resetButton setTitleColor:RedColor forState:UIControlStateNormal];
    [resetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    [self setResetButton:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(sudoko.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *touchIdButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [touchIdButton setTitle:kJinnLockTouchIdText forState:UIControlStateNormal];
    [touchIdButton setTitleColor:RedColor forState:UIControlStateNormal];
    [touchIdButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [touchIdButton addTarget:self action:@selector(touchIdButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchIdButton];
    [self setTouchIdButton:touchIdButton];
    [touchIdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(sudoko.mas_bottom).offset(30);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - Private

- (void)showTouchIdView
{
    
    
//    [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                 localizedReason:@"通过验证指纹解锁"
//                           reply:^(BOOL success, NSError * _Nullable error) {
//                               if (success)
//                               {
//                                   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                                   appDelegate.window.rootViewController = [TabBarViewController new];
//                                   //[self hide];
//                               }
//                           }];
    [TDTouchID td_showTouchIDWithDescribe:nil BlockState:^(TDTouchIDState state, NSError *error) {
        if (state == TDTouchIDStateSuccess) {
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = [BaseTabBarController new];
        }
    }];

}

- (void)updateUiForStep:(JinnLockStep)step
{
    self.step = step;
    
    switch (step)
    {
        case JinnLockStepCreateNew:
        {
            self.noticeLabel.text = kJinnLockNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateAgain:
        {
            self.noticeLabel.text = kJinnLockAgainText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateNotMatch:
        {
            self.noticeLabel.text = kJinnLockNotMatchText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            self.noticeLabel.text = kJinnLockReNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOld:
        {
            self.noticeLabel.text = kJinnLockOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOldError:
        {
            self.noticeLabel.text = kJinnLockOldErrorText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReOld:
        {
            self.noticeLabel.text = kJinnLockReOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNew:
        {
            self.noticeLabel.text = kJinnLockNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain:
        {
            self.noticeLabel.text = kJinnLockAgainText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNotMatch:
        {
            self.noticeLabel.text = kJinnLockNotMatchText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReNew:
        {
            self.noticeLabel.text = kJinnLockReNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOld:
        {
            self.noticeLabel.text = kJinnLockVerifyText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            
            if ([JinnLockTool isTouchIdUnlockEnabled] && [JinnLockTool isTouchIdSupported])
            {
                self.touchIdButton.hidden = NO;
            }
            else
            {
                self.touchIdButton.hidden = YES;
            }
        }
            break;
        case JinnLockStepVerifyOldError:
        {
            _countt--;
            self.noticeLabel.text = [NSString stringWithFormat:@"%@,你还有%ld次机会",kJinnLockOldErrorText,(long)_countt];
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
            if (_countt < 1) {
               //[self hide];
//                [KMUserInfoManager deleteInfo];
//                [HHGetMentLoanManger deleteInfo];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"appHasLogout" object:nil];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.window.rootViewController = [BaseTabBarController new];
            }
        }
            break;
        case JinnLockStepVerifyReOld:
        {
            self.noticeLabel.text = kJinnLockReVerifyText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            
            if ([JinnLockTool isTouchIdUnlockEnabled] && [JinnLockTool isTouchIdSupported])
            {
                self.touchIdButton.hidden = NO;
            }
            else
            {
                self.touchIdButton.hidden = YES;
            }
        }
            break;
        case JinnLockStepRemoveOld:
        {
            self.noticeLabel.text = kJinnLockOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOldError:
        {
            self.noticeLabel.text = kJinnLockOldErrorText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveReOld:
        {
            self.noticeLabel.text = kJinnLockReOldText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
        default:
            break;
    }
}

- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - Action

- (void)hide
{
    if (self.appearMode == JinnLockAppearModePush)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.appearMode == JinnLockAppearModePresent)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)resetButtonClicked
{
    if (self.type == JinnLockTypeCreate)
    {
        [self updateUiForStep:JinnLockStepCreateNew];
    }
    else if (self.type == JinnLockTypeModify)
    {
        [self updateUiForStep:JinnLockStepModifyNew];
    }
}

- (void)touchIdButtonClicked
{
    [self showTouchIdView];
}

#pragma mark - JinnLockSudokoDelegate

- (void)sudoko:(JinnLockSudoko *)sudoko passcodeDidCreate:(NSString *)passcode
{
    if ([passcode length] < kConnectionMinNum)
    {
        [self.noticeLabel setText:JINN_LOCK_NOT_ENOUGH];
        [self.noticeLabel setTextColor:JINN_LOCK_COLOR_ERROR];
        [self shakeAnimationForView:self.noticeLabel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateUiForStep:self.step];
        });
        
        return;
    }
    
    switch (self.step)
    {
        case JinnLockStepCreateNew:
        case JinnLockStepCreateReNew:
        {
            self.passcodeTemp = passcode;
            [self updateUiForStep:JinnLockStepCreateAgain];
        }
            break;
        case JinnLockStepCreateAgain:
        {
            if ([passcode isEqualToString:self.passcodeTemp])
            {
                [JinnLockTool setGestureUnlockEnabled:YES];
                [JinnLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidCreate:)])
                {
                    [self.delegate passcodeDidCreate:passcode];
                }
                BaseTabBarController *tabbar =[BaseTabBarController new];
                [self presentViewController:tabbar animated:YES completion:nil];
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepCreateNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepCreateReNew];
                });
            }
        }
            break;
        case JinnLockStepModifyOld:
        case JinnLockStepModifyReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                [self updateUiForStep:JinnLockStepModifyNew];
            }
            else
            {
                [self updateUiForStep:JinnLockStepModifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepModifyReOld];
                });
            }
        }
            break;
        case JinnLockStepModifyNew:
        case JinnLockStepModifyReNew:
        {
            self.passcodeTemp = passcode;
            [self updateUiForStep:JinnLockStepModifyAgain];
        }
            break;
        case JinnLockStepModifyAgain:
        {
            if ([passcode isEqualToString:self.passcodeTemp])
            {
                [JinnLockTool setGestureUnlockEnabled:YES];
                [JinnLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidModify:)])
                {
                    [self.delegate passcodeDidModify:passcode];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepModifyNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepModifyReNew];
                });
            }
        }
            break;
        case JinnLockStepVerifyOld:
        case JinnLockStepVerifyReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                if ([self.delegate respondsToSelector:@selector(passcodeDidVerify:)])
                {
                    [self.delegate passcodeDidVerify:passcode];
                }
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.window.rootViewController = [BaseTabBarController new];
                //[self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepVerifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepVerifyReOld];
                });
            }
        }
            break;
        case JinnLockStepRemoveOld:
        case JinnLockStepRemoveReOld:
        {
            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            {
                [JinnLockTool setGestureUnlockEnabled:NO];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidRemove)])
                {
                    [self.delegate passcodeDidRemove];
                }
                
                [self hide];
            }
            else
            {
                [self updateUiForStep:JinnLockStepRemoveOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateUiForStep:JinnLockStepRemoveReOld];
                });
            }
        }
            break;
        default:
            break;
    }
    
    [self.indicator showPasscode:passcode];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!(self.type == JinnLockTypeModify)) {
        self.navigationController.navigationBarHidden = YES;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!(self.type == JinnLockTypeModify)) {
        self.navigationController.navigationBarHidden = NO;
    }
}

@end
