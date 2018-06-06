//
//  HHStatementViewController.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/5/18.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHStatementViewController.h"

#import <UMSocialCore/UMSocialCore.h>
@interface HHStatementViewController ()

@end

@implementation HHStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
//    [self pushViewControllerWithName:@"HHTestViewController"];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:@"" thumImage:nil];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObjectWithMediaObject:shareObject];
    
    
    shareObject.title = @"车飞贷";
    shareObject.descr = @"有这种事:评估只需6步,最高可借20万,利率低至0.03%,2小时内即可放款";
    shareObject.thumbImage =  [UIImage imageNamed:@"icon_1024"];
    //设置网页地址
    shareObject.webpageUrl = @"https://itunes.apple.com/cn/app/%E8%BD%A6%E9%A3%9E%E8%B4%B7/id1243925385?mt=8";
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:  UMSocialPlatformType_WechatSession
                                        messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                                            if (error) {
                                                NSLog(@"************Share fail with error %@*********",error);
                                            }else{
                                                NSLog(@"response data is %@",data);
                                                
                                            }
                                        }];
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
