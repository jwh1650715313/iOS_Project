//
//  NSString+Json.m
//  Woyanyan
//
//  Created by ARIST on 14-9-19.
//  Copyright (c) 2014年 clyde. All rights reserved.
//

#import "NSString+Json.h"

@implementation NSString (Json)

- (id)objectFromJSONString{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
}

@end
