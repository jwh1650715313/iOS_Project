//
//  MD5.m
//  娱乐帮
//
//  Created by LogicalThinking on 15/9/14.
//  Copyright (c) 2015年 LogicalThinking. All rights reserved.
//

#import "MD5.h"
#import <string.h>

@implementation MD5

+ (NSString *)md5:(NSString *)str
{
    if (str.length > 0) {
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5( cStr, (int)strlen(cStr), result );
        NSString * results =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                               result[0], result[1], result[2], result[3],
                               result[4], result[5], result[6], result[7],
                               result[8], result[9], result[10], result[11],
                               result[12], result[13], result[14], result[15]
                               ];

        
        
        return results;
    }else {
        return @"";
    }
    
    
}

+ (NSString *)md5UpStr:(NSString *)str
{
    if (str.length > 0) {
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5( cStr, (int)strlen(cStr), result );
        NSString * results =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                               result[0], result[1], result[2], result[3],
                               result[4], result[5], result[6], result[7],
                               result[8], result[9], result[10], result[11],
                               result[12], result[13], result[14], result[15]
                               ];
                for (NSInteger i=0; i<results.length; i++) {
                    if ([results characterAtIndex:i]>='a'&[results characterAtIndex:i]<='z') {
                        //A  65  a  97
                        char  temp=[results characterAtIndex:i]-32;
                        NSRange range=NSMakeRange(i, 1);
                        results=[results stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
                      
        
        
                    }
                }
        
        
        return results;
    }else {
        return @"";
    }
}



+ (NSString *)getRandomString {
    NSMutableArray * result = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",
            result[arc4random()%61], result[arc4random()%61], result[arc4random()%61], result[arc4random()%61],result[arc4random()%61], result[arc4random()%61], result[arc4random()%61], result[arc4random()%61],result[arc4random()%61], result[arc4random()%61]];

}
@end
