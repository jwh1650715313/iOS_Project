//
//  MyViewController.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/3.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    [HHPopupView alertWithTitle:@"提示" detail:@"呵呵呵呵" contentArr:@[@"确定"] selectComplete:^(NSInteger index) {
//
//    }];
   
//    [(BaseTabBarController* )self.tabBarController setBadgeValue:@"12" index:0];
    
    
    
    NSString   *login_inApkContext=@"/ipay/f6ajax/com.zteict.xinlebao.business.base.BusinessCenter4ApkUser.login_inApkContext";
    
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    
    [parameters setValue:@"caidewu" forKey:@"userName"];
    [parameters setValue:@"123456" forKey:@"password"];
    
    [self.requestManager postRequestWithUrl:login_inApkContext params:parameters success:^(id response, NSInteger resposeCode) {
        
         NSLog(@"哈哈===%ld",resposeCode);
        
    } failure:^(NSError *error, NSString *errorMsg) {
        
         NSLog(@"======%@",errorMsg);
        
        [self showCenterTip:errorMsg];
    }];
    
    
    
    
    
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
