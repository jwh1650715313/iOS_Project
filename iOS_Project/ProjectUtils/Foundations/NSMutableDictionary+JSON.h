//
//  NSMutableDictionary+JSON.h
//  iOS_XLB
//
//  Created by 白石洲霍华德 on 2017/7/26.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (JSON)

-(NSString *)toJSON;
-(NSMutableDictionary *)byJSON:(NSString *) json;



@end
