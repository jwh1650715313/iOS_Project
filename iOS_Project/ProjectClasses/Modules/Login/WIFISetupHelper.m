//
//  WIFISetupHelper.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/4/19.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "WIFISetupHelper.h"

@interface WIFISetupHelper ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *km_tableView;

@end

@implementation WIFISetupHelper



static NSString *identifier = @"WIFISetupCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换环境";
    [self commonInit];
    
    
    NSLog(@"当前HOST：%@", HostName);
    
    
    NSLog(@"当前七牛云HOST：%@", QiNiuYunHostName);
    
}

- (void)dealloc {
    NSLog(@"当前HOST：%@", HostName);
}

+ (void)checkHostCache {
    NSMutableArray *temp = [@[] mutableCopy];
    for (NSDictionary *dic in HOST_MENUS) {
        [temp addObject:dic.allValues.firstObject];
    }
    
    NSMutableArray *temp1 = [@[] mutableCopy];
    for (NSDictionary *dic in QiNiuYunHOST_MENUS) {
        [temp1 addObject:dic.allValues.firstObject];
    }
    
    
    
    
    if (![temp containsObject:HostName]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:HOST_KEY];
        
        
#ifdef DEBUG
        CACHE_HOST(temp.firstObject) // DEV默认环境设置
        
        
#else
        CACHE_HOST(temp.lastObject) // REREAS默认环境设置
#endif
        
        NSLog(@"当前HOST：%@", HostName);
    }
    
    
    //七牛云
    if (![temp1 containsObject:QiNiuYunHostName]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:QiNiuYunHOST_KEY];
        
        
#ifdef DEBUG
        QiNiuYunCACHE_HOST(temp1.firstObject) // DEV默认环境设置
        
        
#else
        QiNiuYunCACHE_HOST(temp1.lastObject) // REREAS默认环境设置
#endif
        
        NSLog(@"当前七牛云HOST：%@", QiNiuYunHostName);
        
        
        
    }
    
}

- (void)commonInit {
    // 保险起见，页面唤起再次检查缓存HOST
    [WIFISetupHelper checkHostCache];
    
    // 自定义导航控制器
    //    [self.view addSubview:self.km_navigationBar];
    //    self.title = @"HOST设置";
    //    [self.km_navigationBar.rightItem setTitle:@"完成" forState:UIControlStateNormal];
    //
    //    WEAKSELF(weakSelf)
    //    [self.km_navigationBar rightItemActionCompletion:^(UIButton *item) {
    //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    //    }];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"HOST设置" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"" size:17.0], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    // 表体
    [self.view addSubview:self.km_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return HOST_MENUS.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = HOST_MENUS[section];
    return dic.allValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dic = HOST_MENUS[indexPath.section];
    cell.textLabel.text = dic.allValues[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if ([dic.allValues[indexPath.row] isEqual:HostName]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = HOST_MENUS[section];
    
    UIButton *header = [UIButton buttonWithType:UIButtonTypeCustom];
    header.titleLabel.font = Font(13);
    [header setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [header setTitle:dic.allKeys[0] forState:UIControlStateNormal];
    [header setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [header setTitleEdgeInsets:(UIEdgeInsets){0,15,0,0}];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = HOST_MENUS[indexPath.section];
    NSLog(@"---%@",dic.allValues[indexPath.row]);
    CACHE_HOST(dic.allValues[indexPath.row]);
    
    
    NSMutableArray *temp1 = [@[] mutableCopy];
    for (NSDictionary *dic in QiNiuYunHOST_MENUS) {
        [temp1 addObject:dic.allValues.firstObject];
    }
    
  
    QiNiuYunCACHE_HOST(indexPath.section==0?temp1.firstObject:temp1.lastObject);
    
    NSLog(@"当前七牛云HOST：%@", QiNiuYunHostName);
    
    [self.km_tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UITableView *)km_tableView {
    if (_km_tableView == nil) {
        CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight );
        _km_tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _km_tableView.backgroundColor = kViewBackgroundColor;
        _km_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _km_tableView.showsVerticalScrollIndicator = NO;
        _km_tableView.delegate = self;
        _km_tableView.dataSource = self;
        _km_tableView.rowHeight = 50.0;
        [_km_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    
    return _km_tableView;
}
- (void)clickRightButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
