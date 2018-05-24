//
//  HHLoginViewController.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/22.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "HHLoginViewController.h"
#import "HHResetLoginPsdViewController.h"
#import "HHRegisterViewController.h"

@interface HHLoginViewController ()<UITextFieldDelegate,JinnLockViewControllerDelegate>

@property (nonatomic,strong) UIImageView *imglogo;
@property (nonatomic,strong) UITextField *phoneTdf;//账号
@property (nonatomic,strong) UITextField *psdTdf;//密码
@property (nonatomic,strong) UIView *splitLline1;//分割线
@property (nonatomic,strong) UIView *splitLline2;//分割线
@property (nonatomic,strong) UIButton *submitBtn;//登录按钮
@property (nonatomic,strong) UIButton *showPsdBtn;//显示密码按钮

@property (nonatomic,strong) UIButton *forgetPsdBtn;//忘记密码按钮
@property (nonatomic,strong) UIView *splitLline3;//分割线
@property (nonatomic,strong) UIButton *registerBtn;//注册按钮
@property (nonatomic,strong) UIView   *bsView;
@property (nonatomic,strong) UILabel  *labelMsg;
@property (nonatomic,strong) UIButton *hhpolicyBtn;//后河政策

@end

@implementation HHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"登录";
    
    self.view.backgroundColor=WhiteColor;
    
}





-(void)initUI
{
    
    
   
    
    //logo
    [self.view addSubview:self.imglogo];
    
    [self.imglogo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.offset(SCALE_WIDTH(50));
        make.size.mas_equalTo(CGSizeMake(65, 65));
    
    }];
    
    //手机号
    [self.view addSubview:self.phoneTdf];
    
    [self.phoneTdf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-31);
        make.top.equalTo(self.imglogo.mas_bottom).offset(SCALE_WIDTH(51));
        make.height.equalTo(@21);

    }];
    
    //分割线
    [self.view addSubview:self.splitLline1];
    
    [self.splitLline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
      
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.phoneTdf.mas_bottom).offset(SCALE_WIDTH(10));
        make.height.equalTo(@1);
        
    }];
    
    //密码
    [self.view addSubview:self.psdTdf];
    
    [self.psdTdf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.splitLline1.mas_bottom).offset(SCALE_WIDTH(37));
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-55);
        make.height.equalTo(@21);
        
    }];
    
    //分割线
    [self.view addSubview:self.splitLline2];
    
    [self.splitLline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.psdTdf.mas_bottom).offset(SCALE_WIDTH(10));
        make.height.equalTo(@1);
        
    }];
    
    
    //提交按钮
    [self.view addSubview:self.submitBtn];
    
    self.submitBtn.enabled=YES;
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.splitLline2.mas_bottom).offset(SCALE_WIDTH(79));
        make.height.equalTo(@45);
        
    }];
    
    //显示密码按钮
    [self.view addSubview:self.showPsdBtn];
    
    [self.showPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.psdTdf.mas_right).offset(12);
        make.centerY.equalTo(self.psdTdf);
        make.size.mas_equalTo(CGSizeMake(17, 17));
       
        
    }];
    //分割线

    [self.view addSubview:self.splitLline3];
    
    [self.splitLline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(SCALE_WIDTH(-43));
        make.size.mas_equalTo(CGSizeMake(1, 15));
        
    }];
    
    //忘记密码
    [self.view addSubview:self.forgetPsdBtn];
    
    [self.forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.splitLline3.mas_left).offset(-12);
        make.centerY.equalTo(self.splitLline3);
        make.size.mas_equalTo(CGSizeMake(60, 14));
        
        
    }];
    
    //立即注册
    [self.view addSubview:self.registerBtn];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.splitLline3.mas_right).offset(12);
        make.centerY.equalTo(self.splitLline3);
        make.size.mas_equalTo(CGSizeMake(60, 14));
        
        
    }];
    
    //bsView
    [self.view addSubview:self.bsView];
    
    [self.bsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.splitLline3.mas_bottom).offset(9);
        make.size.mas_equalTo(CGSizeMake(261, 14));
        
        
    }];
    
    //labelMsg
    [self.bsView addSubview:self.labelMsg];
    
    [self.labelMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.bsView).offset(0);
        make.top.equalTo(self.bsView).offset(1);
        make.size.mas_equalTo(CGSizeMake(138, 12));
    }];
    
    
    //隐私政策
    [self.bsView addSubview:self.hhpolicyBtn];
    
    [self.hhpolicyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.labelMsg.mas_right).offset(0);
        make.top.equalTo(self.bsView).offset(1);
        make.size.mas_equalTo(CGSizeMake(123, 12));
    }];
    
    

    if (self.presentingViewController) {
        
        [self setLeftItemWithIcon:[UIImage imageNamed:@"BackNormal"] title:@"" selector:@selector(backClick)];
    }
    
}


-(void)backClick
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIImageView *)imglogo
{
    if (!_imglogo) {
        _imglogo = [[UIImageView alloc] init];
        _imglogo.image = [UIImage imageNamed:@"iconAbout"];
    }
    return _imglogo;
}


-(UITextField *)phoneTdf
{
    if (!_phoneTdf) {
        
        _phoneTdf = [[UITextField alloc] init];
        [_phoneTdf setTextColor:kUIToneTextColor];
        [_phoneTdf setBackgroundColor:[UIColor clearColor]];
        [_phoneTdf setPlaceholder:@"请输入手机号码"];
        _phoneTdf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTdf.delegate = self;
        [_phoneTdf setKeyboardType:UIKeyboardTypeNumberPad];
        [_phoneTdf setFont:Font(15)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFiledTextChanged:) name:UITextFieldTextDidChangeNotification object:_phoneTdf];
       
    }
    
    return _phoneTdf;
}

- (UIView *)splitLline1
{
    if (!_splitLline1) {
        _splitLline1 = [[UIView alloc] init];
        _splitLline1.backgroundColor=kSplitLlineColor;
    }
    return _splitLline1;
}

- (UIView *)splitLline2
{
    if (!_splitLline2) {
        _splitLline2 = [[UIView alloc] init];
        _splitLline2.backgroundColor=kSplitLlineColor;
    }
    return _splitLline2;
}
- (UIView *)splitLline3
{
    if (!_splitLline3) {
        _splitLline3 = [[UIView alloc] init];
        _splitLline3.backgroundColor=kSplitLlineColor;
    }
    return _splitLline3;
}

-(UITextField *)psdTdf
{
    if (!_psdTdf) {
        
        _psdTdf = [[UITextField alloc] init];
        [_psdTdf setTextColor:kUIToneTextColor];
        [_psdTdf setBackgroundColor:[UIColor clearColor]];
        [_psdTdf setPlaceholder:@"请输入密码（不少于6位）"];
        _psdTdf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _psdTdf.delegate = self;
        _psdTdf.secureTextEntry = YES;
        [_psdTdf setKeyboardType:UIKeyboardTypeNamePhonePad];
        [_psdTdf setFont:Font(15)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFiledTextChanged:) name:UITextFieldTextDidChangeNotification object:_psdTdf];
    }
    
    return _psdTdf;
}


-(UIButton *)submitBtn
{
    if (!_submitBtn) {
        
         _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 2;
        _submitBtn.layer.masksToBounds=YES;
        _submitBtn.backgroundColor=kNormalColor;
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:kNormalColor size:CGSizeMake(KScreenWidth, 100)] forState:UIControlStateNormal];
         [_submitBtn setBackgroundImage:[UIImage imageWithColor: kDisabledColor size:CGSizeMake(KScreenWidth, 100)] forState:UIControlStateDisabled];
    
        
        
        
    }
    
    return _submitBtn;
}

-(UIButton *)showPsdBtn
{
    if (!_showPsdBtn) {
        
        _showPsdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
       
        [_showPsdBtn addTarget:self action:@selector(showPsdAction:) forControlEvents:UIControlEventTouchUpInside];
       
        [_showPsdBtn setImage:[UIImage imageNamed:@"yincangmima"] forState:UIControlStateNormal];
        [_showPsdBtn setImage:[UIImage imageNamed:@"xianshimima"] forState:UIControlStateSelected];
        
        
    }
    
    return _showPsdBtn;
}

-(UIButton *)forgetPsdBtn
{
    if (!_forgetPsdBtn) {
        
        _forgetPsdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_forgetPsdBtn addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPsdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPsdBtn setTitleColor:kUIToneTextColor forState:UIControlStateNormal];
        _forgetPsdBtn.titleLabel.font=Font(14);
        
    }
    
    return _forgetPsdBtn;
}


-(UIButton *)registerBtn
{
    if (!_registerBtn) {
        
        _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.titleLabel.font=Font(14);
        [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:kUIToneTextColor forState:UIControlStateNormal];
        
    }
    
    return _registerBtn;
}

- (UIView *)bsView
{
    if (!_bsView) {
        _bsView = [[UIView alloc] init];
        _bsView.backgroundColor=ClearColor;
    }
    return _bsView;
}

- (UILabel *)labelMsg
{
    if (!_labelMsg) {
        _labelMsg = [[UILabel alloc] init];
        _labelMsg.backgroundColor=ClearColor;
        _labelMsg.font=Font(12);
        _labelMsg.textColor=kMinorColor;
        _labelMsg.text=@"登录即代表已阅读并同意";
        _labelMsg.textAlignment=NSTextAlignmentRight;
    }
    return _labelMsg;
}

-(UIButton *)hhpolicyBtn
{
    if (!_hhpolicyBtn) {
        
        _hhpolicyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _hhpolicyBtn.titleLabel.font=Font(12);
        [_hhpolicyBtn addTarget:self action:@selector(hhpolicyAction) forControlEvents:UIControlEventTouchUpInside];
        [_hhpolicyBtn setTitle:@"《后河车贷隐私政策》" forState:UIControlStateNormal];
        [_hhpolicyBtn setTitleColor:kCyColorFromHex(0x6a9eff) forState:UIControlStateNormal];
        
        
    }
    
    return _hhpolicyBtn;
}


#pragma mark-各种事件
//登录
-(void)loginAction
{
    
   
    
    if (_phoneTdf.text.length!=11) {
        
        [self showCenterTip:@"请正确输入手机号"];
        
        return;
    }else if (self.psdTdf.text.length<6 || self.psdTdf.text.length>16){
        
        [self showCenterTip:@"请正确输入密码"];
        
        return;
    }
    
   
    NSDictionary *dic=@{@"phone":kEnsureNotNil(_phoneTdf.text)
                        ,@"password":kEnsureNotNil(_psdTdf.text)
                        };
    
    
    [self showProgress];
    
    
    WEAKSELF
    [self.requestManager postRequestWithUrl:login params:dic success:^(id response, NSInteger resposeCode) {
        
        
       
        
        
       [weakSelf hideProgress];
        
       
        NSDictionary *dic = [response objectForKey:@"data"];
        HHLoginModel *uInfo = [HHLoginModel mj_objectWithKeyValues:dic];
      
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        NSString  *psd=[NSUserDefaultTools getStringValueWithKey:uInfo.userInfo.appUserId];
        
        if (psd.length>0) {
            
            
            [HHLoginModelManager saveInfo:uInfo];
            
            [HHUserInfoManager saveInfo:uInfo.userInfo];
            
            [appDelegate enterApp];
            
            return ;
        }
        
        
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self
                                                                                                 type:JinnLockTypeCreate
                                                                                           appearMode:JinnLockAppearModePush];
        lockViewController.info=uInfo;
        
        [self presentViewController:lockViewController animated:YES completion:nil];
        
    
    } failure:^(NSError *error, NSString *errorMsg) {
        
        
        
        [weakSelf hideProgress];
        
        
        if ([errorMsg isKindOfClass:[NSString class]]) {
            [weakSelf showCenterTip:errorMsg];
        } else {
            [weakSelf showProgress:@"当前网络不稳定"];
        }
    }];
    
    
   
}

//显示密码
-(void)showPsdAction:(UIButton *)sender
{
     UIButton  *btn=(UIButton *)sender;
    
    self.psdTdf.enabled = NO;    // the first one;
    self.psdTdf.secureTextEntry = btn.selected;
    btn.selected = !btn.selected;
    self.psdTdf.enabled = YES;  // the second one;
    [self.psdTdf becomeFirstResponder];
}
//忘记密码
-(void)forgetPsdAction
{
//    [self pushViewControllerWithName:@"HHResetLoginPsdViewController"];

     BaseNavigationController *NavigationVc=[[BaseNavigationController alloc]initWithRootViewController:[HHResetLoginPsdViewController new]];
    
    [self presentViewController:NavigationVc animated:YES completion:nil];
}

//注册账号
-(void)registerAction
{
    
//    [self pushViewControllerWithName:@"HHRegisterViewController"];
    
    BaseNavigationController *NavigationVc=[[BaseNavigationController alloc]initWithRootViewController:[HHRegisterViewController new]];
    
    [self presentViewController:NavigationVc animated:YES completion:nil];
}

//隐私政策
-(void)hhpolicyAction
{
    
 

    NSString *path = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"];
    
    BaseWebViewController  *vc=[BaseWebViewController new];
    
    vc.webUrl=path;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

#pragma mark-TextFiled代理
- (void)TextFiledTextChanged:(NSNotification *)no {
    
    
    /*
    [UIView animateWithDuration:.3 animations:^{
        
     
        self.submitBtn.enabled = _phoneTdf.text.length ==11 && _psdTdf.text.length>=6;
        
        
    }];。
     
     */
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneTdf resignFirstResponder];
    [_psdTdf resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - JinnLockViewControllerDelegate

- (void)passcodeDidCreate:(NSString *)passcode
{
    
}

- (void)passcodeDidRemove
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
