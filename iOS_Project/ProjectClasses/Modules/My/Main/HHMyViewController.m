//
//  HHMyViewController.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/5/18.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "HHMyViewController.h"

@interface HHMyViewController ()

@property (nonatomic , strong)NSArray *gifArray;

@property (nonatomic , strong)NSArray *imagesArray;


@end

@implementation HHMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
   
}

-(void)requestData
{
    _gifArray = @[
                  @"http://ww1.sinaimg.cn/large/8faf3cccjw1evvz8z4d9vg208h05okjs.gif",
                  @"http://ww4.sinaimg.cn/large/8faf3cccjw1evvz92bb87g208h05ox6q.gif",
                  @"http://ww2.sinaimg.cn/large/64dfd849jw1evveimxrocg20lh0h70tf.gif",
                  @"http://ww3.sinaimg.cn/large/87beacabgw1eumj4nai5hg20jg0jg46e.gif",
                  @"http://ww3.sinaimg.cn/large/8faf3cccgw1evyy4tj6hgg206805an6v.gif",
                  @"http://ww2.sinaimg.cn/large/9e6b7fdbjw1evyk8r14p4g20b405uqv5.gif",
                  @"http://ww3.sinaimg.cn/large/5657d033jw1evpjwywt77g206o04pnpd.gif",
                  @"http://ww4.sinaimg.cn/large/0066KRqFgw1evpurtrx8hg30b408cjsw.gif",
                  @"http://ww4.sinaimg.cn/large/0066KRqFgw1evpuor41kbg30m80gox5n.gif",
                  @"http://ww4.sinaimg.cn/large/0066KRqFgw1evpur22fopg30m80go4ga.gif",
                  @"http://ww4.sinaimg.cn/large/0066KRqFgw1evpurrduizg30m80gowp0.gif",
                  @"http://ww2.sinaimg.cn/large/0060fv5Fgw1evqiqzx55pg309x05m1l3.gif"
                  ];
    
    //24
    _imagesArray = @[
                     @"http://p7.pstatp.com/large/w960/664900017cfbc581077a",
                     @"http://p7.pstatp.com/large/w960/66440002b321f06ef66f",
                     @"http://p7.pstatp.com/large/w960/6647000281dc7cb086d4",
                     @"http://p2.pstatp.com/large/w960/664600029725d746d12b",
                     @"http://p3.pstatp.com/large/w960/664900017cfd1bc1b3a5",
                     @"http://p3.pstatp.com/large/w960/66480001879a57c9ab03",
                     @"http://p7.pstatp.com/large/w960/66480001879c7bb2ade2",
                     @"http://p7.pstatp.com/large/w960/6647000281e1f07860bb",
                     @"http://p7.pstatp.com/large/w960/66440002b32aa1ca379e",
                     @"http://p7.pstatp.com/large/w960/66470001f91b20ad9722",
                     @"http://p3.pstatp.com/large/w960/66480000fff1b6c0eb3a",
                     @"http://p3.pstatp.com/large/w960/66490000f3e529e57899",
                     @"http://p7.pstatp.com/large/w960/664400022a3486116be2",
                     @"http://p3.pstatp.com/large/w960/66470001f92187b948dd",
                     @"http://p3.pstatp.com/large/w960/664500021a20d461df50",
                     @"http://p7.pstatp.com/large/w960/664500021a21a6ff9046",
                     @"http://p3.pstatp.com/large/w960/66470001f922087ad9c1",
                     @"http://p7.pstatp.com/large/w960/66470001f92386571408",
                     @"http://p2.pstatp.com/large/w960/664700026a09254cb679",
                     @"http://p7.pstatp.com/large/w960/664500028cd40bc97b57",
                     @"http://p2.pstatp.com/large/w960/664400029bc616a193e7",
                     @"http://p7.pstatp.com/large/w960/664a00015851a7728378",
                     @"http://p2.pstatp.com/large/w960/664500028cd633015730",
                     @"http://p7.pstatp.com/large/w960/664700026a0be7b63c78"
                     ];
}


- (IBAction)click:(id)sender {
    
    
    
    
    
    
    /*
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    
   
    
    
    //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 5;
    ac.configuration.maxPreviewCount = 10;
    
    //如调用的方法无sender参数，则该参数必传
    ac.sender = self;
    
    //选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
    }];
    
    //调用相册
    [ac showPreviewAnimated:YES];
    */
    
    
  
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
