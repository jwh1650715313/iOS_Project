//
//  MapManager.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/20.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapManagerModel.h"

typedef void(^LocationBlock)(MapManagerModel *model);

@interface MapManager : NSObject

+ (instancetype)shareMapManager;

- (void)startLocationWithComplete:(LocationBlock)locationComplete;

@end
