//
//  MapManagerModel.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/20.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapManagerModel : NSObject


//纬度
@property (copy, nonatomic) NSString *latitude;
//经度
@property (copy, nonatomic) NSString *longitude;
//详细地址
@property (copy, nonatomic) NSArray *detailaddr;
//城市
@property (copy, nonatomic) NSString *city;

//省
@property (copy, nonatomic) NSString *province;

//区
@property (copy, nonatomic) NSString *SubLocality;

@end
