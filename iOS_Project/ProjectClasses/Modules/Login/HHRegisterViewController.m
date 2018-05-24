//
//  HHRegisterViewController.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/22.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "HHRegisterViewController.h"

@interface HHRegisterViewController ()<UITextFieldDelegate>
{
    int djs_end_time; //60秒后重新获取验证码
    NSTimer *addDjsTimer;
}
@property (nonatomic,strong) UITextField *phoneTdf;//账号
@property (nonatomic,strong) UITextField *psdTdf;//密码
@property (nonatomic,strong) UITextField *codeTdf;//验证码

@property (nonatomic,strong) UIView *splitLline;//分割线
@property (nonatomic,strong) UIButton *submitBtn;//注册按钮
@property (nonatomic,strong) UIButton *showPsdBtn;//显示密码按钮
@property (nonatomic,strong) UIButton *codeBtn;//获取验证码按钮

//用户协议
@property (nonatomic,strong) UILabel *msgLabel;
@property (nonatomic,strong) UIButton *hhBtn1;//用户协议
@property (nonatomic,strong) UIButton *hhBtn2;//隐私协议


@end

@implementation HHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"注册";
    
     self.view.backgroundColor=WhiteColor;
}

-(void)initUI
{
    
   
    
    
    //手机号
    [self.view addSubview:self.phoneTdf];
    
    [self.phoneTdf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-31);
        make.top.equalTo(self.view).offset(SCALE_WIDTH(51));
        make.height.equalTo(@21);
        
    }];
    
    //分割线
    UIView *splitLline1=self.splitLline;
    [self.view addSubview:splitLline1];
    
    [splitLline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.phoneTdf.mas_bottom).offset(SCALE_WIDTH(10));
        make.height.equalTo(@1);
        
    }];
    
    //验证码
    [self.view addSubview:self.codeTdf];
    
    [self.codeTdf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(splitLline1.mas_bottom).offset(SCALE_WIDTH(37));
        make.left.equalTo(self.view).offset(19);
        make.width.equalTo(@200);
        make.height.equalTo(@21);
        
    }];
    
    
    //获取验证码按钮
    [self.view addSubview:self.codeBtn];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(-23);
        make.centerY.equalTo(self.codeTdf);
        make.size.mas_equalTo(CGSizeMake(80, 15));
        
    }];
    
    //获取验证码按钮左边的分割线
    UIView *rightLline=self.splitLline;
    [self.view addSubview:rightLline];
    
    [rightLline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.codeBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.codeTdf);
        make.size.mas_equalTo(CGSizeMake(1, 10));
        
    }];
    
    
    
    
    //分割线
    UIView *splitLline2=self.splitLline;
    [self.view addSubview:splitLline2];
    
    [splitLline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.codeTdf.mas_bottom).offset(SCALE_WIDTH(10));
        make.height.equalTo(@1);
        
    }];
    
    
    //密码
    [self.view addSubview:self.psdTdf];
    
    [self.psdTdf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(splitLline2.mas_bottom).offset(SCALE_WIDTH(70));
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-55);
        make.height.equalTo(@21);
        
    }];
    
    //分割线
    UIView *splitLline3=self.splitLline;
    [self.view addSubview:splitLline3];
    
    [splitLline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(self.psdTdf.mas_bottom).offset(SCALE_WIDTH(10));
        make.height.equalTo(@1);
        
    }];
    
    
    //注册按钮
    [self.view addSubview:self.submitBtn];
    
    _submitBtn.enabled=NO;
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(19);
        make.right.equalTo(self.view).offset(-19);
        make.top.equalTo(splitLline3.mas_bottom).offset(SCALE_WIDTH(79));
        make.height.equalTo(@45);
        
    }];
    
    //显示密码按钮
    [self.view addSubview:self.showPsdBtn];
    
    [self.showPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.psdTdf.mas_right).offset(12);
        make.centerY.equalTo(self.psdTdf);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        
        
    }];
    
    //msgLabel
    
    [self.view addSubview:self.msgLabel];
    
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.view).offset(22);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(138, 12));
    }];
    
    //注册协议
    [self.view addSubview:self.hhBtn1];
    
    [self.hhBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.msgLabel.mas_right).offset(-5);
        make.centerY.equalTo(self.msgLabel);
        make.size.mas_equalTo(CGSizeMake(100, 12));
    }];
    
    //隐私协议
    [self.view addSubview:self.hhBtn2];
    
    [self.hhBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.hhBtn1.mas_right).offset(-15);
        make.centerY.equalTo(self.msgLabel);
        make.size.mas_equalTo(CGSizeMake(85, 12));
    }];
    
    
    [self setLeftItemWithIcon:[UIImage imageNamed:@"BackNormal"] title:@"" selector:@selector(backClick)];
    
    
    
}


-(void)backClick
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark-控件初始化

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

-(UITextField *)codeTdf
{
    if (!_codeTdf) {
        
        _codeTdf = [[UITextField alloc] init];
        [_codeTdf setTextColor:kUIToneTextColor];
        [_codeTdf setBackgroundColor:[UIColor clearColor]];
        [_codeTdf setPlaceholder:@"请输入验证码"];
        _codeTdf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTdf.delegate = self;
        [_codeTdf setKeyboardType:UIKeyboardTypeNumberPad];
        [_codeTdf setFont:Font(15)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFiledTextChanged:) name:UITextFieldTextDidChangeNotification object:_codeTdf];
        
    }
    
    return _codeTdf;
}

- (UIView *)splitLline
{

    _splitLline = [[UIView alloc] init];
    _splitLline.backgroundColor=kSplitLlineColor;
    
    return _splitLline;
}

-(UITextField *)psdTdf
{
    if (!_psdTdf) {
        
        _psdTdf = [[UITextField alloc] init];
        [_psdTdf setTextColor:kUIToneTextColor];
        [_psdTdf setBackgroundColor:[UIColor clearColor]];
        [_psdTdf setPlaceholder:@"请设置登录密码（不少于6位）"];
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
        [_submitBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 2;
        _submitBtn.layer.masksToBounds=YES;
        _submitBtn.backgroundColor=kNormalColor;
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:kNormalColor size:CGSizeMake(KScreenWidth, 100)] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:kDisabledColor size:CGSizeMake(KScreenWidth, 100)] forState:UIControlStateDisabled];
        
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


-(UIButton *)codeBtn
{
    if (!_codeBtn) {
        
        _codeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
      
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(getcodeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn setTitleColor:kUIToneTextColor forState:UIControlStateNormal];
        [_codeBtn setTitleColor:kMinorColor forState:UIControlStateDisabled];
        
        
        _codeBtn.titleLabel.font=Font(15);
     
    }
    
    return _codeBtn;
}

- (UILabel *)msgLabel
{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.backgroundColor=ClearColor;
        _msgLabel.font=Font(12);
        _msgLabel.textColor=kMinorColor;
        _msgLabel.text=@"注册即代表已阅读并同意";
        _msgLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _msgLabel;
}


-(UIButton *)hhBtn1
{
    if (!_hhBtn1) {
        
        _hhBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        _hhBtn1.titleLabel.font=Font(12);
        [_hhBtn1 addTarget:self action:@selector(hhprotocolAction) forControlEvents:UIControlEventTouchUpInside];
        [_hhBtn1 setTitle:@"《用户注册协议》" forState:UIControlStateNormal];
        [_hhBtn1 setTitleColor:kCyColorFromHex(0x6a9eff) forState:UIControlStateNormal];
        
        
    }
    
    return _hhBtn1;
}

-(UIButton *)hhBtn2
{
    if (!_hhBtn2) {
        
        _hhBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        _hhBtn2.titleLabel.font=Font(12);
        [_hhBtn2 addTarget:self action:@selector(hhpolicyAction) forControlEvents:UIControlEventTouchUpInside];
        [_hhBtn2 setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        [_hhBtn2 setTitleColor:kCyColorFromHex(0x6a9eff) forState:UIControlStateNormal];
        
        
    }
    
    return _hhBtn2;
}






#pragma mark-TextFiled代理
- (void)TextFiledTextChanged:(NSNotification *)no {
    
    
    NSString *psd = [_psdTdf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        _submitBtn.enabled = _phoneTdf.text.length ==11 && (psd.length>=6 && psd.length<=16) &&_codeTdf.text.length==6;
        
        
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    [self hideKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark-各种事件
//注册事件
-(void)registerAction
{
    
    [self showProgress];
    
    WEAKSELF
    
    
    //用户注册
    NSDictionary  *dic=@{@"phone":kEnsureNotNil(KstringByReplace(_phoneTdf.text))
                         ,@"password":kEnsureNotNil(KstringByReplace(_psdTdf.text))
                         ,@"registerCode":kEnsureNotNil(KstringByReplace(_codeTdf.text))
                         };

    
    [self.requestManager postRequestWithUrl:register params:dic success:^(id response, NSInteger resposeCode) {
        
         [weakSelf hideProgress];
        
        //注册成功后到登录页面
        if (weakSelf.presentingViewController) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    
    } failure:^(NSError *error, NSString *errorMsg) {
        
       [weakSelf hideProgress];
        
        if ([errorMsg isKindOfClass:[NSString class]]) {
            [weakSelf showCenterTip:errorMsg];
        } else {
            [weakSelf showCenterTip:@"当前网络不稳定"];
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

//获取验证码
-(void)getcodeAction:(UIButton *)sender
{
    if (![CommonUtils checkPhone:_phoneTdf.text]) {
        [self showCenterTip:@"请输入11位手机号码"];
        return;
    }
    // 用title来区分当前是在倒计时还是可以获取验证码
    else if ([[_codeBtn titleForState:UIControlStateNormal] isEqualToString:@"发送验证码"]) {
        
        [self hideKeyboard];
        
        djs_end_time = 60;
        [self handleTimer];
        addDjsTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        

        [self showProgress];
        
        WEAKSELF
        
        
        
        //获取 验证码的请求
        [self.requestManager getRequestWithUrl:getRegisterCode params:@{@"phone":kEnsureNotNil(KstringByReplace(_phoneTdf.text)),@"type":@"0"} success:^(id response, NSInteger resposeCode) {
            
            
            [weakSelf hideProgress];
            
            
        } failure:^(NSError *error, NSString *errorMsg) {
            
           [weakSelf hideProgress];
            
            if ([errorMsg isKindOfClass:[NSString class]]) {
                [weakSelf showCenterTip:errorMsg];
            } else {
                [weakSelf showCenterTip:@"当前网络不稳定"];
            }
            
            
        }];
        
        
    }
}



//《后河车贷用户注册协议》
-(void)hhprotocolAction
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"useragreement" ofType:@"html"];
    
    BaseWebViewController  *vc=[BaseWebViewController new];
    
    vc.webUrl=path;
    
    [self.navigationController pushViewController:vc animated:YES];
}


//《后河车贷隐私政策》
-(void)hhpolicyAction
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"html"];
    
    BaseWebViewController  *vc=[BaseWebViewController new];
    
    vc.webUrl=path;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark-私有的方法
//倒计时
-(void)handleTimer
{
    
    if(djs_end_time>0)
    {
        _codeBtn.enabled=NO;
   
        int sec = djs_end_time;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%dS",sec] forState:UIControlStateNormal];
        
    }
    else
    {
        _codeBtn.enabled=YES;
       
     
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        
        [addDjsTimer invalidate];
        
    }
    djs_end_time = djs_end_time - 1;
}


-(void)hideKeyboard
{
    [_phoneTdf resignFirstResponder];
    [_psdTdf resignFirstResponder];
    [_codeTdf resignFirstResponder];
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
