//
//  HomeViewController.m
//  iOS_Project
//
//  Created by 白石洲霍华德 on 2017/11/3.
//  Copyright © 2017年 景文浩. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "TestCell.h"

static NSString * const KTestCell = @"TestCell";

@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) SDCycleScrollView *headView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    
    
    
    
    
    
    
    
    
    
    

    [self.view addSubview:self.tableView];
    
    
    
    
}

#pragma mark-banner
-(SDCycleScrollView *)headView {
     
     if (!_headView) {
         
         if (IS_IPHONE_6P) {
             _headView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 250)];
         }
         else
         {
             _headView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 225)];
         }
         _headView.placeholderImage = [UIImage imageNamed:@"newsdefault"];
         _headView.delegate = self;
         _headView.backgroundColor = kViewBackgroundColor;
         _headView.pageDotImage = [UIImage imageNamed:@"switch_01"];
         _headView.currentPageDotImage = [UIImage imageNamed:@"switch_02"];
         _headView.autoScrollTimeInterval = 3;
         _headView.pageControlBottomOffset = 10;
         _headView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        
     }
    
     return _headView;
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:rect];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:KTestCell bundle:nil] forCellReuseIdentifier:KTestCell];
    }
    
    return _tableView;
    
}


-(void)requestData{
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    self.headView.imageURLStringsGroup=imagesURLStrings;
    
    self.tableView.tableHeaderView=self.headView;
    
    [PageSurveyView showViewWithType:ExceptionViewType_ServerError toView:self.tableView];
    
}


#pragma mark-TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00000001f;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0 hasSectionLine:YES];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TestCell *cell = [tableView dequeueReusableCellWithIdentifier:KTestCell];
    cell.textLabel.text=@"呵呵呵";
    return cell;

}

#pragma mark -SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"=======%ld",index);
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
