//
//  HHLoginModel.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/26.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHUserInfo.h"
@interface HHLoginModel : NSObject


@property (strong, nonatomic) NSString *token;

@property (strong, nonatomic) HHUserInfo *userInfo;



@end
