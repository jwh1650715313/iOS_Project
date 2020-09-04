//
//  YCMyViewController.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/6/6.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "YCMyViewController.h"

@interface YCMyViewController ()

@end

@implementation YCMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setRightItemWithTitle:@"网络" selector:@selector(netClick)];
}

-(void)netClick{
    
    [self pushViewControllerWithName:@"WIFISetupHelper"];
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
