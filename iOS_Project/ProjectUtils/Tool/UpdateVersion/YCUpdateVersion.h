//
//  HHUpdateVersion.h
//  iOS_Project
//
//  Created by 金永学 on 2018/4/16.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCUpdateVersion : NSObject
@property (nonatomic, strong) HttpRequstManager *requestManager;
-(void)updateVersion;
@end
