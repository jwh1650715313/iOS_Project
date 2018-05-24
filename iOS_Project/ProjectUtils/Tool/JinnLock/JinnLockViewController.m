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
#import "HHLoginModelManager.h"
#import "TDTouchID.h"

#import "HHLoginViewController.h"

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

@property (nonatomic, strong) UIImageView        *headimage;
@property (nonatomic, strong) UILabel            *phoneLabel;

@property (nonatomic, strong) UILabel            *noticeLabel;
@property (nonatomic, strong) UIButton           *resetButton;
@property (nonatomic, strong) UIButton           *touchIdButton;

@property (nonatomic, assign) JinnLockStep       step;
@property (nonatomic, strong) NSString           *passcodeTemp;
@property (nonatomic, strong) LAContext          *context;
@property (nonatomic, strong) UIView             *baseView;//忘记手势，密码登录
@property (nonatomic,strong) UIButton *forgetGesture;//忘记手势
@property (nonatomic,strong) UIView *splitLline;//分割线
@property (nonatomic,strong) UIButton *PsdLogin;//密码登录




@property (nonatomic, assign) NSInteger countt;

@end

@implementation JinnLockViewController

#pragma mark - Override

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    
     self.view.backgroundColor=WhiteColor;
    
    
    
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
            
            if ([JinnLockTool isTouchIdUnlockEnabled]) {
                
                [self showTouchIdView];
                
            }
            
            
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
    //九宫格
    JinnLockSudoko *sudoko = [[JinnLockSudoko alloc] init];
    [sudoko setDelegate:self];
    //    sudoko.backgroundColor = [UIColor redColor];
    [self.view addSubview:sudoko];
    [self setSudoko:sudoko];
    [sudoko mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerX.equalTo(self.view);
        make.centerY.centerY.equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(SCALE_WIDTH(kSudokoSideLength), SCALE_WIDTH(kSudokoSideLength)));
    }];
    
    
    //提示
    UILabel *noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:18]];
    [noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noticeLabel];
    [self setNoticeLabel:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.sudoko.mas_top).offset(-25);
        make.height.mas_equalTo(20);
    }];
    
    //绘制轨迹
    JinnLockIndicator *indicator = [[JinnLockIndicator alloc] init];
    //indicator.backgroundColor = [UIColor lightGrayColor];
    indicator.tag=1001;
    [self.view addSubview:indicator];
    [self setIndicator:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.noticeLabel.mas_top).offset(-33);
        if (self.type == JinnLockTypeVerify) {
            
            make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, 0));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, kIndicatorSideLength));
            
        }
        
    }];
    
    
    //头像
    UIImageView *headimage = [[UIImageView alloc] init];
    //imgvv.backgroundColor = [UIColor redColor];
    
    NSString  *imgUrl=[NSString stringWithFormat:@"%@%@",QiNiuYunHostName,[HHUserInfoManager getInfo].photo];
    
    [headimage sd_setImageWithURL:[NSURL URLWithString:imgUrl]  placeholderImage:[UIImage imageNamed:@"headimage"]];
    
    [self.view addSubview:headimage];
    [self setHeadimage:headimage];
    self.headimage.hidden=YES;
    self.headimage.layer.cornerRadius=35;
    self.headimage.layer.masksToBounds=YES;
    
    [headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.sudoko.mas_top).offset(-70);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        
    }];
    
    //电话号码
    UILabel *phonelabel = [[UILabel alloc] init];
    [phonelabel setFont:[UIFont systemFontOfSize:18]];
    [phonelabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:phonelabel];
    [self setPhoneLabel:phonelabel];
    self.phoneLabel.hidden=YES;
    [phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headimage.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    phonelabel.text=[HHUserInfoManager getInfo].phone.length>0? [[HHUserInfoManager getInfo].phone stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"]:@"";;
    
    
    //重新设置
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:kJinnLockResetText forState:UIControlStateNormal];
    [resetButton setTitleColor:kMinorColor forState:UIControlStateNormal];
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
    
    //忘记手势,密码登录
    UIView  *view=[[UIView alloc]init];
    //    view.backgroundColor=RedColor;
    [self.view addSubview:view];
    [self setBaseView:view];
    self.baseView.hidden=YES;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.sudoko.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.baseView addSubview:self.splitLline];
    [self.baseView addSubview:self.forgetGesture];
    [self.baseView addSubview:self.PsdLogin];
    
    [self.splitLline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseView);
        make.top.equalTo(self.baseView).offset(2.5);
        make.size.mas_equalTo(CGSizeMake(1, 15));
    }];
    
    
    [self.forgetGesture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.splitLline).offset(-12);
        make.top.equalTo(self.baseView).offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    
    
    [self.PsdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.splitLline).offset(12);
        make.top.equalTo(self.baseView).offset(3);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    
    
    
}

#pragma mark - Private

- (void)showTouchIdView
{
    
    
    [JinnLockTool setTouchIdUnlockEnabled:YES];
    
    
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
            self.indicator.hidden = NO;
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
            self.indicator.hidden = NO;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            self.noticeLabel.text = kJinnLockReNewText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
            
            [self.indicator reset];
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
            self.indicator.hidden = NO;
            self.resetButton.hidden = YES;
            self.touchIdButton.hidden = YES;
            
            [self.indicator reset];
        }
            break;
        case JinnLockStepVerifyOld:
        {
            NSLog(@"验证密码");
            self.noticeLabel.text = kJinnLockVerifyText;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
            self.headimage.hidden=NO;
            self.phoneLabel.hidden=NO;
            self.baseView.hidden=NO;
            self.noticeLabel.font=Font(13);
            [self.noticeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(self.sudoko.mas_top).offset(-5);
                make.height.mas_equalTo(20);
                
                
            }];
            
            
            
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
                
            
                [NSUserDefaultTools setStringValueWithKey:@"" key:[HHUserInfoManager getInfo].appUserId];
                
                
                [self gotoLoginViewController];
                
                
                
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
        JinnLockIndicator *indicator=[self.view viewWithTag:1001];
        
        [indicator reset];
        
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
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                appDelegate.window.rootViewController = [BaseTabBarController new];
                
                if ([CommonUtils IsOkString:self.info.token]) {
                    
                    [HHLoginModelManager saveInfo:self.info];
                    
                    [HHUserInfoManager saveInfo:self.info.userInfo];
                    
                    
                    [NSUserDefaultTools setStringValueWithKey:passcode key:self.info.userInfo.appUserId];
                    
                }
                
                
                
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
            
            NSString  *psd=[NSUserDefaultTools getStringValueWithKey:[HHUserInfoManager getInfo].appUserId];
            
//            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            if ([passcode isEqualToString:psd])
            
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
//            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            
             NSString  *psd=[NSUserDefaultTools getStringValueWithKey:[HHUserInfoManager getInfo].appUserId];
            
            if([passcode isEqualToString:psd])
            
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
             NSString  *psd=[NSUserDefaultTools getStringValueWithKey:[HHUserInfoManager getInfo].appUserId];
            
//            if ([passcode isEqualToString:[JinnLockTool currentGesturePasscode]])
            
            if ([passcode isEqualToString:psd])
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


-(UIButton *)forgetGesture
{
    if (!_forgetGesture) {
        
        _forgetGesture=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_forgetGesture addTarget:self action:@selector(forgetGestureClick) forControlEvents:UIControlEventTouchUpInside];
        [_forgetGesture setTitle:@"忘记手势" forState:UIControlStateNormal];
        [_forgetGesture setTitleColor:kMinorColor forState:UIControlStateNormal];
        _forgetGesture.titleLabel.font=Font(14);
        
    }
    
    return _forgetGesture;
}


-(UIButton *)PsdLogin
{
    if (!_PsdLogin) {
        
        _PsdLogin=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_PsdLogin addTarget:self action:@selector(PsdLoginClick) forControlEvents:UIControlEventTouchUpInside];
        [_PsdLogin setTitle:@"密码登录" forState:UIControlStateNormal];
        [_PsdLogin setTitleColor:kMinorColor forState:UIControlStateNormal];
        _PsdLogin.titleLabel.font=Font(14);
        
    }
    
    return _PsdLogin;
}

- (UIView *)splitLline
{
    if (!_splitLline) {
        _splitLline = [[UIView alloc] init];
        _splitLline.backgroundColor=kSplitLlineColor;
    }
    return _splitLline;
}




#pragma mark-忘记手势
-(void)forgetGestureClick
{
    BaseNavigationController *NavigationVc=[[BaseNavigationController alloc]initWithRootViewController:[HHLoginViewController new]];
    
    [self presentViewController:NavigationVc animated:YES completion:nil];
    
}


#pragma mark-密码登录
-(void)PsdLoginClick
{
    BaseNavigationController *NavigationVc=[[BaseNavigationController alloc]initWithRootViewController:[HHLoginViewController new]];
    
    [self presentViewController:NavigationVc animated:YES completion:nil];
}





@end

